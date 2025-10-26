#!/bin/bash

# AI Dev Workflow - Project Installation Script
# Version: 1.0.0
# 
# This script installs a minimal copy of the AI workflow into your project.
# Files are copied locally and become part of your project repository.
#
# Usage:
#   ./install-ai-workflow.sh /path/to/your/project

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Configuration
WORKFLOW_VERSION="1.0.0"
WORKFLOW_REPO="https://github.com/tichaonax/ai-dev-workflow.git"

echo -e "${BLUE}╔══════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║   AI Dev Workflow - Project Installation             ║${NC}"
echo -e "${BLUE}║   Version: ${WORKFLOW_VERSION}                                     ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════════════════════════╝${NC}"
echo ""

# Parse flags
DRY_RUN=false
ASSUME_YES=false

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
   --dry-run ) DRY_RUN=true; shift;;
   -y | --yes ) ASSUME_YES=true; shift;;
   --list-templates )
      # Print available templates from local repo and exit
      SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
      if [ -d "$SCRIPT_DIR/templates/v1" ]; then
         echo "Available templates:" 
            for f in "$SCRIPT_DIR"/templates/v1/*-session.md; do
               [ -e "$f" ] || continue
               base=$(basename "$f")
               short=${base%-session.md}
               friendly=$(echo "$short" | sed -E 's/-/ /g' | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1')
               # Extract a short description: first header or first non-empty paragraph
               desc=$(awk 'BEGIN{desc="";found=0} /^#/ {gsub(/^#+[ \t]*/,"",$0); if(length($0)>0 && !found){print $0; exit}} { if($0 ~ /[^[:space:]]/ && !found){print $0; exit}}' "$f" | sed -n '1p' | sed -E 's/^[# ]+//')
               if [ -z "$desc" ]; then desc="(no description)"; fi
               printf "%s  — %s\n    %s\n" "$base" "$friendly" "$desc"
            done
         exit 0
      else
         echo "No templates found in $SCRIPT_DIR/templates/v1"
         exit 1
      fi ;;
   --list-templates-json )
      SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
      if [ -d "$SCRIPT_DIR/templates/v1" ]; then
         echo "["
         first=true
            for f in "$SCRIPT_DIR"/templates/v1/*-session.md; do
               [ -e "$f" ] || continue
               name=$(basename "$f")
            if [ "$first" = true ]; then
               first=false
            else
               echo ","
            fi
            printf '  "%s"' "$name"
         done
         echo ""
         echo "]"
         exit 0
      else
         echo "[]"
         exit 1
      fi ;;
      --template )
         # Install a single template (only used together with target path)
         shift
         TEMPLATE_NAME="$1"
         if [ -z "$TEMPLATE_NAME" ]; then
            echo "Error: --template requires a template name (short or filename)"
            exit 1
         fi
         shift
         # The remaining arg should be the target project path; push it back for main processing
         set -- "$@"
         TEMPLATE_ONLY="$TEMPLATE_NAME"
         ;;
         --choose-template )
            CHOOSE_TEMPLATE=true; shift;;
   -h | --help )
      echo "Usage: $0 [--dry-run] [--yes] /path/to/your/project"
      echo "  --dry-run   Print actions without making changes"
      echo "  --yes,-y    Run non-interactively (assume yes to prompts)"
      exit 0;;
   * ) break;;
esac; done

# Check if target directory provided
if [ -z "$1" ]; then
    echo -e "${RED}Error: Please provide target project directory${NC}"
    echo ""
    echo "Usage:"
    echo "  $0 /path/to/your/project"
    echo ""
    echo "Examples:"
    echo "  # Install to existing project:"
    echo "  $0 /Users/yourname/projects/existing-app"
    echo ""
    echo "  # Install to new project (directory will be created):"
    echo "  $0 /Users/yourname/projects/new-app"
    echo ""
    echo "  # Install to current directory:"
    echo "  $0 ."
    echo ""
    exit 1
fi

TARGET_PROJECT="$1"

# Helper wrappers for actions that respect dry-run
run_mkdir() {
   if [ "$DRY_RUN" = true ]; then
      echo "DRY-RUN: mkdir -p $*"
   else
      mkdir -p "$@"
   fi
}

run_cp() {
   if [ "$DRY_RUN" = true ]; then
      echo "DRY-RUN: cp $*"
   else
      cp "$@"
   fi
}

run_mv() {
   if [ "$DRY_RUN" = true ]; then
      echo "DRY-RUN: mv $*"
   else
      mv "$@"
   fi
}

run_write_file() {
   if [ "$DRY_RUN" = true ]; then
      echo "DRY-RUN: write to $1"
   else
      eval "$2"
   fi
}

# Require target directory to already exist (script is run from repo, user should create project first)
if [ ! -d "$TARGET_PROJECT" ]; then
   echo -e "${RED}Error: Target directory does not exist: $TARGET_PROJECT${NC}"
   echo "Please create the project directory first and ensure it is a git repository if desired."
   exit 1
fi

# Warn if not a git repository but continue (optionally auto-accept if ASSUME_YES)
if [ ! -d "$TARGET_PROJECT/.git" ]; then
   if [ "$ASSUME_YES" = true ]; then
      echo -e "${YELLOW}Warning: Target directory is not a git repository. Continuing anyway (assume-yes).${NC}"
   else
      echo -e "${YELLOW}Warning: Target directory is not a git repository. Continuing anyway.${NC}"
   fi
fi

# Check if ai-contexts already exists
if [ -d "$TARGET_PROJECT/ai-contexts" ]; then
    echo -e "${YELLOW}⚠️  Warning: ai-contexts/ already exists in target project${NC}"
    echo ""
    echo "Existing installation found at:"
    echo "  $TARGET_PROJECT/ai-contexts/"
    echo ""
    echo "This will:"
    echo "  • Backup existing ai-contexts/ → ai-contexts.backup.$(date +%Y%m%d_%H%M%S)/"
    echo "  • Install fresh copy of workflow files"
    echo "  • Preserve any custom/ folders you may have created"
    echo ""
    echo -e "${BLUE}Do you want to proceed with overwrite? ${NC}"
   if [ "$ASSUME_YES" = true ]; then
      echo "  → assume-yes: proceeding with overwrite"
   else
      read -p "(y/n) " -n 1 -r
      echo
      if [[ ! $REPLY =~ ^[Yy]$ ]]; then
         echo -e "${YELLOW}Installation cancelled.${NC}"
         exit 1
      fi
   fi

   # Backup existing
   BACKUP_NAME="ai-contexts.backup.$(date +%Y%m%d_%H%M%S)"
   echo -e "${BLUE}Creating backup: $BACKUP_NAME${NC}"
   run_mv "$TARGET_PROJECT/ai-contexts" "$TARGET_PROJECT/$BACKUP_NAME"
   echo "  ✓ Backup created at: $TARGET_PROJECT/$BACKUP_NAME"

   # Preserve custom/ folder if it exists (team-specific contexts)
   CUSTOM_BACKUP_DIR=""
   if [ -d "$TARGET_PROJECT/$BACKUP_NAME/custom" ]; then
      echo -e "${BLUE}Preserving custom team contexts...${NC}"
      CUSTOM_BACKUP_DIR="$TARGET_PROJECT/$BACKUP_NAME/custom"
      echo "  ✓ Custom contexts will be restored after installation"
   fi
fi

echo ""
echo -e "${GREEN}[1/5] Locating workflow source files...${NC}"
# Use the script's parent directory as the source of workflow files. The script is expected
# to be run from the repository root where these files exist.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
LOCAL_SRC="$SCRIPT_DIR"
if [ -d "$LOCAL_SRC/contexts" ] && [ -d "$LOCAL_SRC/templates" ]; then
   echo "  ✓ Found local workflow files at: $LOCAL_SRC"
else
   echo -e "${RED}Error: Local workflow files not found in script directory: $LOCAL_SRC${NC}"
   echo "Please run this script from the repository root (where install-ai-workflow.sh lives)."
   exit 1
fi

# If user requested interactive template selection, present choices and set TEMPLATE_ONLY
if [ "$CHOOSE_TEMPLATE" = true ]; then
   templates=("$LOCAL_SRC"/templates/v1/*-session.md)
   echo "Available templates:" 
   i=1
   for f in "${templates[@]}"; do
      [ -e "$f" ] || continue
      base=$(basename "$f")
      short=${base%-session.md}
      friendly=$(echo "$short" | sed -E 's/-/ /g' | awk '{for(i=1;i<=NF;i++){ $i=toupper(substr($i,1,1)) substr($i,2) }}1')
      desc=$(awk 'BEGIN{desc="";found=0} /^#/ {gsub(/^#+[ \t]*/,"",$0); if(length($0)>0 && !found){print $0; exit}} { if($0 ~ /[^[:space:]]/ && !found){print $0; exit}}' "$f" | sed -n '1p' | sed -E 's/^[# ]+//')
      printf "%2d) %s  — %s\n    %s\n" "$i" "$base" "$friendly" "$desc"
      ((i++))
   done
   if [ "$ASSUME_YES" = true ]; then
      choice=1
      echo "Assume-yes: selecting template #1"
   else
      read -p "Choose a template number: " choice
   fi
   # Map choice to template
   idx=1
   selected=""
   for f in "${templates[@]}"; do
      [ -e "$f" ] || continue
      if [ "$idx" -eq "$choice" ]; then
         selected="$f"
         break
      fi
      ((idx++))
   done
   if [ -z "$selected" ]; then
      echo "Invalid selection: $choice"
      exit 1
   fi
   TEMPLATE_ONLY=$(basename "$selected")
   # normalize to short name
   TEMPLATE_ONLY=${TEMPLATE_ONLY%-session.md}
   echo "Selected template: $TEMPLATE_ONLY"
fi

echo ""
echo -e "${GREEN}[2/5] Creating directory structure...${NC}"
run_mkdir "$TARGET_PROJECT/ai-contexts/contexts/backend"
run_mkdir "$TARGET_PROJECT/ai-contexts/contexts/frontend"
run_mkdir "$TARGET_PROJECT/ai-contexts/templates/v1"
run_mkdir "$TARGET_PROJECT/ai-contexts/wip"
run_mkdir "$TARGET_PROJECT/ai-contexts/project-plans/active"
run_mkdir "$TARGET_PROJECT/ai-contexts/project-plans/completed"
run_mkdir "$TARGET_PROJECT/ai-contexts/custom"
run_mkdir "$TARGET_PROJECT/ai-contexts/integrations/vscode"
echo "  ✓ Directory structure created"

echo ""
echo -e "${GREEN}[3/5] Copying essential workflow files...${NC}"

SRC_ROOT="$LOCAL_SRC"

# Copy core contexts
echo "  → Core contexts"
run_cp "$SRC_ROOT/contexts/master-context.md" \
   "$TARGET_PROJECT/ai-contexts/contexts/" 2>/dev/null || true
run_cp "$SRC_ROOT/contexts/code-workflow.md" \
   "$TARGET_PROJECT/ai-contexts/contexts/" 2>/dev/null || true
run_cp "$SRC_ROOT/contexts/general-problem-solving-context.md" \
   "$TARGET_PROJECT/ai-contexts/contexts/" 2>/dev/null || true

# Copy backend contexts
echo "  → Backend contexts"
if [ -d "$SRC_ROOT/contexts/backend" ]; then
   run_cp "$SRC_ROOT/contexts/backend/"*.md \
      "$TARGET_PROJECT/ai-contexts/contexts/backend/" 2>/dev/null || true
fi

# Copy frontend contexts  
echo "  → Frontend contexts"
if [ -d "$SRC_ROOT/contexts/frontend" ]; then
   run_cp "$SRC_ROOT/contexts/frontend/"*.md \
      "$TARGET_PROJECT/ai-contexts/contexts/frontend/" 2>/dev/null || true
fi

# Copy templates (only the templates, not examples)
echo "  → Session templates"
if [ -n "$TEMPLATE_ONLY" ]; then
   # Resolve template name: accept short name (feature-development) or full filename
   resolve_template() {
      local candidate="$1"
      # If candidate already ends with -session.md and exists, return it
      if [ -f "$SRC_ROOT/templates/v1/$candidate" ]; then
         echo "$SRC_ROOT/templates/v1/$candidate"
         return 0
      fi
      # If candidate doesn't end with suffix, try adding suffix
      if [ -f "$SRC_ROOT/templates/v1/${candidate}-session.md" ]; then
         echo "$SRC_ROOT/templates/v1/${candidate}-session.md"
         return 0
      fi
      # Try match by treating candidate as case-insensitive
      for f in "$SRC_ROOT"/templates/v1/*-session.md; do
         [ -e "$f" ] || continue
         name=$(basename "$f")
         short=${name%-session.md}
         if [ "$(echo "$short" | tr '[:upper:]' '[:lower:]')" = "$(echo "$candidate" | tr '[:upper:]' '[:lower:]')" ]; then
            echo "$f"
            return 0
         fi
      done
      return 1
   }

   TEMPLATE_PATH=$(resolve_template "$TEMPLATE_ONLY") || true
   if [ -z "$TEMPLATE_PATH" ]; then
      echo -e "${RED}Error: Template '$TEMPLATE_ONLY' not found in templates/v1/${NC}"
      exit 1
   fi
   echo "  → Installing single template: $(basename "$TEMPLATE_PATH")"
   run_cp "$TEMPLATE_PATH" \
      "$TARGET_PROJECT/ai-contexts/templates/v1/" 2>/dev/null || true
else
   run_cp "$SRC_ROOT/templates/v1/"*-session.md \
       "$TARGET_PROJECT/ai-contexts/templates/v1/" 2>/dev/null || true
fi

# Copy README files for folder documentation
echo "  → Documentation files"
run_cp "$SRC_ROOT/wip/README.md" \
   "$TARGET_PROJECT/ai-contexts/wip/" 2>/dev/null || true
run_cp "$SRC_ROOT/project-plans/README.md" \
   "$TARGET_PROJECT/ai-contexts/project-plans/" 2>/dev/null || true

# Copy .gitkeep files to preserve folder structure
run_cp "$SRC_ROOT/wip/.gitkeep" \
   "$TARGET_PROJECT/ai-contexts/wip/" 2>/dev/null || true
run_cp "$SRC_ROOT/project-plans/active/.gitkeep" \
   "$TARGET_PROJECT/ai-contexts/project-plans/active/" 2>/dev/null || true
run_cp "$SRC_ROOT/project-plans/completed/.gitkeep" \
   "$TARGET_PROJECT/ai-contexts/project-plans/completed/" 2>/dev/null || true

# Copy custom/ folder files (.gitkeep and README.md)
echo "  → Custom contexts folder"
run_cp "$SRC_ROOT/custom/.gitkeep" \
   "$TARGET_PROJECT/ai-contexts/custom/" 2>/dev/null || true
run_cp "$SRC_ROOT/custom/README.md" \
   "$TARGET_PROJECT/ai-contexts/custom/" 2>/dev/null || true


# Copy VS Code snippets
echo "  → VS Code snippets"
if [ -d "$SRC_ROOT/integrations/vscode" ]; then
   run_cp "$SRC_ROOT/integrations/vscode/"*.code-snippets \
      "$TARGET_PROJECT/ai-contexts/integrations/vscode/" 2>/dev/null || true
fi

echo "  ✓ Essential files copied"

# Restore custom contexts from backup if they existed
if [ -n "$CUSTOM_BACKUP_DIR" ] && [ -d "$CUSTOM_BACKUP_DIR" ]; then
   echo ""
   echo -e "${GREEN}Restoring custom team contexts from backup...${NC}"
   # Copy all .md files except README.md from backup
   for custom_file in "$CUSTOM_BACKUP_DIR"/*.md; do
      if [ -f "$custom_file" ]; then
         filename=$(basename "$custom_file")
         if [ "$filename" != "README.md" ]; then
            run_cp "$custom_file" "$TARGET_PROJECT/ai-contexts/custom/"
            echo "  ✓ Restored: $filename"
         fi
      fi
   done
   echo "  ✓ Custom team contexts restored"
fi

echo ""
echo -e "${GREEN}[4/5] Creating version tracking file...${NC}"
cat > "$TARGET_PROJECT/ai-contexts/.workflow-version" << EOF
# AI Dev Workflow Version
# This file tracks which version of the workflow this project uses

workflow_version=$WORKFLOW_VERSION
installed_date=$(date +%Y-%m-%d)
source_repo=$WORKFLOW_REPO

# To update this workflow to a newer version:
# 1. Clone latest: git clone $WORKFLOW_REPO /tmp/workflow-latest
# 2. Run: /tmp/workflow-latest/install-ai-workflow.sh /path/to/this/project
# 3. Review changes and commit

# For documentation and examples:
# Visit: https://github.com/tichaonax/ai-dev-workflow
EOF
if [ "$DRY_RUN" = true ]; then
   echo "DRY-RUN: would create .workflow-version with version $WORKFLOW_VERSION"
else
   echo "  ✓ Version file created"
fi

echo ""
echo -e "${GREEN}[5/5] Creating project README...${NC}"
if [ "$DRY_RUN" = true ]; then
   echo "DRY-RUN: would create ai-contexts/README.md"
else
   cat > "$TARGET_PROJECT/ai-contexts/README.md" << 'EOF'
# AI Development Workflow

This directory contains the AI-assisted development workflow for this project.

## 📁 Structure

```
ai-contexts/
├── contexts/          # Context documents (teach AI your standards)
│   ├── master-context.md
│   ├── code-workflow.md
│   ├── backend/       # Backend-specific contexts
│   └── frontend/      # Frontend-specific contexts
│
├── templates/         # Session templates for different tasks
│   └── v1/
│       ├── feature-development-session.md
│       ├── debugging-session.md
│       ├── refactor-optimization-session.md
│       └── ...
│
├── wip/              # Work-in-progress context files (gitignored)
│
└── project-plans/    # AI-generated project plans
    ├── active/       # Currently working on (gitignored)
    └── completed/    # Finished & documented (tracked)
```

## 🚀 Quick Start

1. **Choose a template** based on your task:
   - Feature development: `templates/v1/feature-development-session.md`
   - Bug fixing: `templates/v1/debugging-session.md`
   - Refactoring: `templates/v1/refactor-optimization-session.md`

2. **Start AI session:**
   ```
   Please read these contexts in order:
   1. FIRST: ai-contexts/contexts/master-context.md
   2. SECOND: ai-contexts/contexts/code-workflow.md
   3. THIRD: ai-contexts/templates/v1/[your-template].md
   ```

3. **Follow the workflow** with approval checkpoints

## 📚 Documentation

For complete documentation, examples, and guides:
→ https://github.com/tichaonax/ai-dev-workflow

## 🔄 Updating

Check `.workflow-version` file for current version and update instructions.

## ✏️ Customization

Add project-specific contexts in:
- `contexts/custom/` (create this folder)
- These won't be overwritten during updates
EOF
fi
echo "  ✓ README created"

# Create .gitignore for work-in-progress folders
echo ""

# VS Code snippet registration
echo ""
echo -e "${GREEN}[6/7] VS Code snippet registration...${NC}"

VSCODE_SNIPPETS_COPIED=false
if [ -f "$TARGET_PROJECT/ai-contexts/integrations/vscode/ai-workflow-commands.code-snippets" ]; then
   echo "  ✓ VS Code snippets available in ai-contexts/integrations/vscode/"
   echo ""
   echo -e "${BLUE}Would you like to register these snippets with VS Code?${NC}"
   echo "  This will copy snippet files to .vscode/ in your project root."
   echo "  You'll be able to use triggers like 'task-start', 'resume', 'compare-req', etc."
   echo ""

   if [ "$ASSUME_YES" = true ]; then
      echo "  → assume-yes: registering snippets with VS Code"
      REGISTER_SNIPPETS=true
   else
      read -p "Register VS Code snippets? (y/n) " -n 1 -r
      echo
      if [[ $REPLY =~ ^[Yy]$ ]]; then
         REGISTER_SNIPPETS=true
      else
         REGISTER_SNIPPETS=false
      fi
   fi

   if [ "$REGISTER_SNIPPETS" = true ]; then
      # Create .vscode folder if it doesn't exist
      if [ ! -d "$TARGET_PROJECT/.vscode" ]; then
         echo "  → Creating .vscode/ folder in project root"
         run_mkdir "$TARGET_PROJECT/.vscode"
      fi

      # Copy snippet files
      echo "  → Copying snippet files to .vscode/"
      run_cp "$TARGET_PROJECT/ai-contexts/integrations/vscode/"*.code-snippets \
         "$TARGET_PROJECT/.vscode/" 2>/dev/null || true

      VSCODE_SNIPPETS_COPIED=true
      echo "  ✓ VS Code snippets registered"
      echo ""
      echo -e "${YELLOW}⚠️  IMPORTANT: Restart VS Code for snippets to take effect${NC}"
      echo ""
   else
      echo "  → Skipped VS Code snippet registration"
      echo "  → You can manually copy snippets later from:"
      echo "     ai-contexts/integrations/vscode/*.code-snippets"
      echo "     to .vscode/ folder"
   fi
else
   echo "  ⚠️  VS Code snippets not found in source (expected at integrations/vscode/)"
fi

# Create .gitignore for work-in-progress folders
echo ""
echo -e "${GREEN}[7/7] Configuring git...${NC}"
if [ "$DRY_RUN" = true ]; then
   echo "DRY-RUN: would create ai-contexts/.gitignore"
else
   cat > "$TARGET_PROJECT/ai-contexts/.gitignore" << 'EOF'
# ==========================================
# Work-in-progress (NOT tracked in git)
# ==========================================

# User context files during active development
wip/*
!wip/.gitkeep
!wip/README.md

# AI project plans during active work
project-plans/active/*
!project-plans/active/.gitkeep
!project-plans/active/README.md

# ==========================================
# Completed work (TRACKED for documentation)
# ==========================================
# project-plans/completed/YYYY-MM/ is tracked

# ==========================================
# Personal files (never track)
# ==========================================
*.draft.md
*.personal.md
*.temp.md
*.notes.md
.notes/

# ==========================================
# Editor/system files
# ==========================================
.DS_Store
*.swp
*.swo
*~
Thumbs.db
EOF
fi
echo "  ✓ .gitignore configured"

# No temporary clone used when run from local repository; nothing to clean up

# Summary
echo ""
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✓ Installation Complete!${NC}"
echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
echo ""
echo "Installed to: $TARGET_PROJECT/ai-contexts/"
echo ""
echo "📋 What was installed:"
echo "  • Core contexts (master-context, code-workflow)"
echo "  • Backend contexts (API, database)"
echo "  • Frontend contexts (components, styling, UI)"
echo "  • 9 session templates"
echo "  • VS Code snippets (32 snippets)"
if [ "$VSCODE_SNIPPETS_COPIED" = true ]; then
   echo "  • VS Code snippet registration (.vscode/)"
fi
echo "  • Version tracking"
echo "  • Project README"
echo ""
echo "📊 File count:"
CONTEXT_COUNT=$(find "$TARGET_PROJECT/ai-contexts/contexts" -name "*.md" 2>/dev/null | wc -l)
TEMPLATE_COUNT=$(find "$TARGET_PROJECT/ai-contexts/templates" -name "*.md" 2>/dev/null | wc -l)
echo "  • Contexts: $CONTEXT_COUNT files"
echo "  • Templates: $TEMPLATE_COUNT files"
echo ""
echo "🎯 Next steps:"
echo ""
echo "1. Review the installation:"
echo "   cd $TARGET_PROJECT/ai-contexts"
echo "   ls -la"
echo ""
echo "2. Add to git:"
echo "   cd $TARGET_PROJECT"
echo "   git add ai-contexts/"
echo "   git commit -m \"Add AI development workflow v${WORKFLOW_VERSION}\""
echo ""
echo "3. Read the quick start:"
echo "   cat ai-contexts/README.md"
echo ""
echo "4. Try your first session:"
echo "   • Pick a template from templates/v1/"
echo "   • Load contexts with AI"
echo "   • Follow the workflow"
echo ""
if [ "$VSCODE_SNIPPETS_COPIED" = true ]; then
   echo "5. Use VS Code snippets:"
   echo "   • Restart VS Code to activate snippets"
   echo "   • Type 'task-start' + Tab to start new task"
   echo "   • Type 'resume' + Tab to resume session"
   echo "   • Type 'show-snippets' + Tab to see all snippets"
   echo ""
fi
echo ""
echo "📖 Full documentation:"
echo "   https://github.com/tichaonax/ai-dev-workflow"
echo ""
echo -e "${GREEN}Happy AI-assisted coding! 🚀${NC}"
echo ""
