#!/bin/bash

# Test script for installer preservation functionality
# Tests that custom templates, wip, and project-plans are preserved during updates

set -e

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
WORKFLOW_ROOT="$(dirname "$SCRIPT_DIR")"
TEST_PROJECT_DIR="/tmp/test-installer-$$"

echo -e "${GREEN}Testing installer preservation functionality...${NC}"
echo "Test project: $TEST_PROJECT_DIR"
echo ""

# Cleanup function
cleanup() {
    if [ -d "$TEST_PROJECT_DIR" ]; then
        rm -rf "$TEST_PROJECT_DIR"
    fi
}
trap cleanup EXIT

# Create test project
mkdir -p "$TEST_PROJECT_DIR"
cd "$TEST_PROJECT_DIR"
git init >/dev/null 2>&1

echo -e "${GREEN}[1/6] Initial installation...${NC}"
"$WORKFLOW_ROOT/install-ai-workflow.sh" -y "$TEST_PROJECT_DIR" >/dev/null 2>&1
echo "  ✓ Initial installation complete"

echo -e "${GREEN}[2/6] Creating user content to preserve...${NC}"

# Create custom templates
mkdir -p ai-contexts/templates/custom
cat > ai-contexts/templates/custom/my-custom-template.md << 'EOF'
# My Custom Template
This is a custom template created by the user.
EOF

cat > ai-contexts/templates/v1/my-project-specific-session.md << 'EOF'
# My Project Specific Session
This is a custom session template in v1 directory.
EOF

# Create WIP content
cat > ai-contexts/wip/my-work-in-progress.md << 'EOF'
# Work in Progress
This is my current work session.
EOF

mkdir -p ai-contexts/wip/feature-branch
cat > ai-contexts/wip/feature-branch/context.md << 'EOF'
# Feature Branch Context
This is work in a subdirectory.
EOF

# Create project plans
cat > ai-contexts/project-plans/active/current-project.md << 'EOF'
# Current Project Plan
This is an active project plan.
EOF

cat > ai-contexts/project-plans/completed/finished-project.md << 'EOF'
# Finished Project Plan
This is a completed project plan.
EOF

mkdir -p ai-contexts/project-plans/completed/2024-10
cat > ai-contexts/project-plans/completed/2024-10/october-release.md << 'EOF'
# October Release Plan
This is a completed project in a subdirectory.
EOF

# Create custom contexts
cat > ai-contexts/custom/team-standards.md << 'EOF'
# Team Standards
These are our team's coding standards.
EOF

echo "  ✓ Created test user content"

echo -e "${GREEN}[3/6] Running installer update (should preserve content)...${NC}"
"$WORKFLOW_ROOT/install-ai-workflow.sh" -y "$TEST_PROJECT_DIR" >/dev/null 2>&1
echo "  ✓ Update installation complete"

echo -e "${GREEN}[4/6] Verifying preserved content...${NC}"

# Check custom templates
if [ -f "ai-contexts/templates/custom/my-custom-template.md" ]; then
    echo "  ✓ Custom template directory preserved"
else
    echo -e "  ${RED}✗ Custom template directory NOT preserved${NC}"
    exit 1
fi

if [ -f "ai-contexts/templates/v1/my-project-specific-session.md" ]; then
    echo "  ✓ Custom v1 template preserved"
else
    echo -e "  ${RED}✗ Custom v1 template NOT preserved${NC}"
    exit 1
fi

# Check WIP content
if [ -f "ai-contexts/wip/my-work-in-progress.md" ]; then
    echo "  ✓ WIP files preserved"
else
    echo -e "  ${RED}✗ WIP files NOT preserved${NC}"
    exit 1
fi

if [ -f "ai-contexts/wip/feature-branch/context.md" ]; then
    echo "  ✓ WIP subdirectories preserved"
else
    echo -e "  ${RED}✗ WIP subdirectories NOT preserved${NC}"
    exit 1
fi

# Check project plans
if [ -f "ai-contexts/project-plans/active/current-project.md" ]; then
    echo "  ✓ Active project plans preserved"
else
    echo -e "  ${RED}✗ Active project plans NOT preserved${NC}"
    exit 1
fi

if [ -f "ai-contexts/project-plans/completed/finished-project.md" ]; then
    echo "  ✓ Completed project plans preserved"
else
    echo -e "  ${RED}✗ Completed project plans NOT preserved${NC}"
    exit 1
fi

if [ -f "ai-contexts/project-plans/completed/2024-10/october-release.md" ]; then
    echo "  ✓ Completed project plan subdirectories preserved"
else
    echo -e "  ${RED}✗ Completed project plan subdirectories NOT preserved${NC}"
    exit 1
fi

# Check custom contexts
if [ -f "ai-contexts/custom/team-standards.md" ]; then
    echo "  ✓ Custom contexts preserved"
else
    echo -e "  ${RED}✗ Custom contexts NOT preserved${NC}"
    exit 1
fi

echo -e "${GREEN}[5/6] Verifying framework files were updated...${NC}"

# Check that framework templates are still present
framework_templates=("api-endpoint-session.md" "debugging-session.md" "feature-development-session.md")
for template in "${framework_templates[@]}"; do
    if [ -f "ai-contexts/templates/v1/$template" ]; then
        echo "  ✓ Framework template $template present"
    else
        echo -e "  ${RED}✗ Framework template $template MISSING${NC}"
        exit 1
    fi
done

echo -e "${GREEN}[6/6] Verifying backup was created...${NC}"

# Check that backup directory exists
backup_dirs=(ai-contexts.backup.*)
if [ ${#backup_dirs[@]} -gt 0 ] && [ -d "${backup_dirs[0]}" ]; then
    echo "  ✓ Backup directory created: ${backup_dirs[0]}"
else
    echo -e "  ${RED}✗ Backup directory NOT created${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}✅ All tests passed!${NC}"
echo ""
echo "The installer correctly:"
echo "  • Created timestamped backup"
echo "  • Preserved custom templates (both custom/ and v1/)"
echo "  • Preserved work-in-progress sessions"
echo "  • Preserved project plans (active and completed)"
echo "  • Preserved custom team contexts"
echo "  • Updated framework files"
echo ""
echo -e "${GREEN}Installer preservation functionality is working correctly! 🎉${NC}"