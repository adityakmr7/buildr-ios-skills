#!/usr/bin/env bash
#
# BuildrStudio iOS AI Skills Suite Universal Installer
# Official distribution by BuildrStudio (https://buildrstudio.in)
# Installs Buildr skills into any project or globally for Antigravity, Claude Code, Cursor, and Codex.
#

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"

print_header() {
  echo "=========================================================="
  echo "       🚀 BuildrStudio iOS AI Skills Suite (buildr-*)     "
  echo "              Official: https://buildrstudio.in           "
  echo "=========================================================="
}

usage() {
  print_header
  echo "Usage: ./install.sh [OPTIONS]"
  echo ""
  echo "Options:"
  echo "  --global              Install skills globally to your user profile"
  echo "                        (works across all projects in Antigravity, Claude, Cursor)"
  echo "  --project <DIR>       Install skills into a specific iOS project folder"
  echo "  --target <TOOL>       Target tool: 'all' (default), 'antigravity', 'claude', 'cursor'"
  echo "  --skill <NAME>        Install only a specific skill (e.g., buildr-ui). Default: all"
  echo "  --list                List available skills in this suite"
  echo "  --help                Show this help message"
  echo ""
  echo "Examples:"
  echo "  ./install.sh --global"
  echo "  ./install.sh --project ~/Development/MyCoolApp"
  echo "  ./install.sh --project ~/Development/MyCoolApp --skill buildr-concurrency"
  echo "  ./install.sh --global --target claude"
  exit 0
}

list_skills() {
  print_header
  echo "Available BuildrStudio skills in suite:"
  for skill_dir in "$SKILLS_SRC"/*; do
    if [ -d "$skill_dir" ]; then
      skill_name="$(basename "$skill_dir")"
      echo "  • $skill_name"
    fi
  done
  echo ""
  exit 0
}

copy_skill() {
  local src="$1"
  local dest_dir="$2"
  local skill_name
  skill_name="$(basename "$src")"
  
  mkdir -p "$dest_dir/$skill_name"
  cp -R "$src/"* "$dest_dir/$skill_name/"
  echo "  ✓ Installed $skill_name -> $dest_dir/$skill_name"
}

# Default options
MODE=""
PROJECT_DIR=""
TARGET_TOOL="all"
SELECTED_SKILL="all"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --global)
      MODE="global"
      shift
      ;;
    --project)
      MODE="project"
      PROJECT_DIR="$2"
      shift 2
      ;;
    --target)
      TARGET_TOOL="$2"
      shift 2
      ;;
    --skill)
      SELECTED_SKILL="$2"
      shift 2
      ;;
    --list)
      list_skills
      ;;
    --help|-h)
      usage
      ;;
    *)
      echo "Unknown option: $1"
      usage
      ;;
  esac
done

if [ -z "$MODE" ]; then
  print_header
  echo "No target specified. Please select an installation mode:"
  echo "1) Global Install (available across all projects on this machine)"
  echo "2) Project Install (add to a specific iOS project folder)"
  echo "3) Cancel"
  read -r -p "Enter choice [1-3]: " choice
  case "$choice" in
    1) MODE="global" ;;
    2)
      read -r -p "Enter project directory path: " input_dir
      PROJECT_DIR="$input_dir"
      MODE="project"
      ;;
    *) exit 0 ;;
  esac
fi

print_header
echo "Mode: $MODE"
[ -n "$PROJECT_DIR" ] && echo "Project: $PROJECT_DIR"
echo "Tool Target: $TARGET_TOOL"
echo "Skill Target: $SELECTED_SKILL"
echo "----------------------------------------------------------"

get_skills_to_install() {
  if [ "$SELECTED_SKILL" = "all" ]; then
    find "$SKILLS_SRC" -mindepth 1 -maxdepth 1 -type d
  else
    if [ -d "$SKILLS_SRC/$SELECTED_SKILL" ]; then
      echo "$SKILLS_SRC/$SELECTED_SKILL"
    else
      echo "Error: Skill '$SELECTED_SKILL' not found in $SKILLS_SRC" >&2
      exit 1
    fi
  fi
}

install_to_dest() {
  local dest_dir="$1"
  local tool_label="$2"
  echo "Installing for $tool_label ($dest_dir)..."
  mkdir -p "$dest_dir"
  while IFS= read -r skill_dir; do
    [ -n "$skill_dir" ] && copy_skill "$skill_dir" "$dest_dir"
  done < <(get_skills_to_install)
}

if [ "$MODE" = "global" ]; then
  if [ "$TARGET_TOOL" = "all" ] || [ "$TARGET_TOOL" = "antigravity" ]; then
    install_to_dest "$HOME/.gemini/antigravity-cli/skills" "Antigravity Global"
  fi
  if [ "$TARGET_TOOL" = "all" ] || [ "$TARGET_TOOL" = "claude" ]; then
    install_to_dest "$HOME/.claude/skills" "Claude Code Global"
  fi
  if [ "$TARGET_TOOL" = "all" ] || [ "$TARGET_TOOL" = "cursor" ]; then
    install_to_dest "$HOME/.cursor/skills" "Cursor Global"
  fi
elif [ "$MODE" = "project" ]; then
  if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project directory '$PROJECT_DIR' does not exist."
    exit 1
  fi
  
  if [ "$TARGET_TOOL" = "all" ] || [ "$TARGET_TOOL" = "antigravity" ]; then
    install_to_dest "$PROJECT_DIR/.agents/skills" "Antigravity Workspace"
  fi
  if [ "$TARGET_TOOL" = "all" ] || [ "$TARGET_TOOL" = "claude" ]; then
    install_to_dest "$PROJECT_DIR/.claude/skills" "Claude Code Workspace"
  fi
  if [ "$TARGET_TOOL" = "all" ] || [ "$TARGET_TOOL" = "cursor" ]; then
    install_to_dest "$PROJECT_DIR/.cursor/skills" "Cursor Workspace"
  fi
fi

echo "----------------------------------------------------------"
echo "🎉 BuildrStudio installation complete!"
echo "You can now prompt your AI coding assistant with natural commands like:"
echo "  • 'Review this SwiftUI view with buildr-ui for modern iOS 17/18 best practices'"
echo "  • 'Check this file with buildr-concurrency for Swift 6 data race safety'"
echo "  • 'Snap this layout to the 4/8-pt grid with buildr-design'"
echo "=========================================================="
