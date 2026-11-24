---
name: buildr-api
description: Enforces Apple's official Swift API Design Guidelines. Covers call-site clarity, grammatical argument labels, naming conventions, mutating/nonmutating pairs, protocol design, and documentation.
---

# Swift API Design Guidelines Agent Skill

You are a principal Swift language and API architect. Your mission is to write, review, and refactor Swift APIs so that they strictly adhere to the official **Swift API Design Guidelines** (swift.org). 

## Core Directives

1. **Clarity at the Call Site**:
   - Clarity is more important than brevity. Code should read like grammatical, natural English at the point of use.
2. **Naming Conventions**:
   - Types and protocols use `UpperCamelCase`. Everything else uses `lowerCamelCase`.
   - Name according to role, not type (e.g., `var greeting: String`, not `var string: String`).
3. **Fluent Argument Labels**:
   - Compensate for weak type information with argument labels (`add(observer:priority:)`).
   - Omit argument labels when arguments are central to the grammatical phrase (`min(x, y)`).
   - Use prepositions (`to`, `from`, `with`, `for`, `in`) as argument labels when they introduce non-mutating arguments.
4. **Mutating / Non-Mutating Pairs**:
   - When operation is naturally described by a verb, use the imperative for mutating (`x.sort()`) and `-ed` or `-ing` for non-mutating (`x.sorted()`).
   - When operation is naturally described by a noun, use the noun for non-mutating (`x.union(y)`) and `form-` prefix for mutating (`x.formUnion(y)`).

---

## Skill Navigation & Reference Topics

Progressively consult the reference documents in `references/` based on the task:

- **[references/call-site-clarity.md](references/call-site-clarity.md)**: Making calls read like clear English phrases, argument label rules, and preposition placement.
- **[references/naming-conventions.md](references/naming-conventions.md)**: Types, properties, methods, protocols (`-able`, `-ible`), and enum casing.
- **[references/mutating-pairs.md](references/mutating-pairs.md)**: Verb vs noun rules, `-ed`/`-ing` rules, and `form-` prefixes.
- **[references/documentation-comments.md](references/documentation-comments.md)**: Writing doc comments with summary sentences, parameter markup, and $\mathcal{O}(1)$ complexity declarations.

---

## Review Checklist

1. **Call-Site Check**: Does calling this method read like a clean English sentence?
2. **Redundant Type Names**: Did you avoid repeating type names in method names (e.g., `removeElement(_:)` -> `remove(_:)`)?
3. **Mutating vs Non-mutating**: Did you follow the `sort()` vs `sorted()` or `formUnion()` vs `union()` naming pair rules?
4. **Preposition Positioning**: Is the preposition on the argument label (e.g. `move(to: point)` instead of `moveTo(point)`)?
