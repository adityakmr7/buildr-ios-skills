#!/usr/bin/env python3
"""
validate-skills.py - Lint and validation script for iOS AI Skills Suite.
Verifies YAML frontmatter, markdown formatting, file existence, and reference link integrity.
"""

import os
import re
import sys
from pathlib import Path

def parse_frontmatter(content):
    if not content.startswith("---"):
        return None, "Missing opening frontmatter delimiter (---)"
    parts = content.split("---", 2)
    if len(parts) < 3:
        return None, "Unterminated frontmatter delimiter (---)"
    fm_raw = parts[1].strip()
    fm = {}
    for line in fm_raw.split("\n"):
        line = line.strip()
        if not line or line.startswith("#"):
            continue
        if ":" in line:
            key, val = line.split(":", 1)
            fm[key.strip()] = val.strip().strip('"').strip("'")
    return fm, parts[2]

def validate_skill(skill_dir):
    errors = []
    warnings = []
    skill_file = skill_dir / "SKILL.md"

    if not skill_file.exists():
        return [f"{skill_dir.name}: Missing SKILL.md"], []

    try:
        content = skill_file.read_text(encoding="utf-8")
    except Exception as e:
        return [f"{skill_file}: Read error: {e}"], []

    fm, body = parse_frontmatter(content)
    if not fm:
        errors.append(f"{skill_file}: Invalid YAML frontmatter: {body}")
    else:
        if "name" not in fm or not fm["name"]:
            errors.append(f"{skill_file}: Missing 'name' in frontmatter")
        if "description" not in fm or not fm["description"]:
            errors.append(f"{skill_file}: Missing 'description' in frontmatter")

    # Check references link integrity
    refs_dir = skill_dir / "references"
    if refs_dir.exists() and refs_dir.is_dir():
        ref_files = list(refs_dir.glob("*.md"))
        if not ref_files:
            warnings.append(f"{skill_dir.name}/references is empty")

        for ref in ref_files:
            ref_content = ref.read_text(encoding="utf-8")
            if len(ref_content.strip()) < 100:
                warnings.append(f"{ref.name}: File seems unusually short (<100 characters)")

    # Find relative markdown links in SKILL.md and verify they resolve
    link_pattern = re.compile(r'\[([^\]]+)\]\(([^)]+)\)')
    for match in link_pattern.finditer(content):
        link_text, link_target = match.groups()
        if link_target.startswith("http") or link_target.startswith("#") or link_target.startswith("file://"):
            continue
        # Split target from anchor if present
        target_path = link_target.split("#")[0]
        if target_path:
            resolved = (skill_dir / target_path).resolve()
            if not resolved.exists():
                errors.append(f"{skill_file}: Broken relative link '{link_target}' in text '[{link_text}]'")

    return errors, warnings

def main():
    root = Path(__file__).resolve().parent.parent
    skills_dir = root / "skills"

    if not skills_dir.exists():
        print(f"Error: skills directory not found at {skills_dir}")
        sys.exit(1)

    all_errors = []
    all_warnings = []
    skill_count = 0

    print("==================================================")
    print("🔍 Validating iOS AI Skills Suite...")
    print("==================================================")

    for skill_path in sorted(skills_dir.iterdir()):
        if skill_path.is_dir():
            skill_count += 1
            errors, warnings = validate_skill(skill_path)
            if errors:
                all_errors.extend(errors)
                print(f"❌ {skill_path.name}: FAILED with {len(errors)} error(s)")
                for err in errors:
                    print(f"   • {err}")
            else:
                print(f"✅ {skill_path.name}: PASSED")

            if warnings:
                all_warnings.extend(warnings)
                for w in warnings:
                    print(f"   ⚠️  Warning: {w}")

    print("--------------------------------------------------")
    print(f"Validated {skill_count} skills.")
    if all_errors:
        print(f"FAILED: {len(all_errors)} error(s) found.")
        sys.exit(1)
    else:
        print("ALL SKILLS PASSED VALIDATION! 🎉")
        if all_warnings:
            print(f"({len(all_warnings)} non-blocking warning(s))")
        sys.exit(0)

if __name__ == "__main__":
    main()
