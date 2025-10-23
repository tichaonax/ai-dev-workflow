#!/bin/bash

# Template Selector Tool
# Helps you choose the right session template

echo "========================================="
echo "AI Workflow - Template Selector"
echo "========================================="
echo ""
echo "What are you working on?"
echo ""
echo "1) New feature or screen"
echo "2) Fixing a bug"
echo "3) Refactoring or optimizing code"
echo "4) Database schema changes"
echo "5) Creating/updating an API endpoint"
echo "6) Design/UI review"
echo "7) Writing documentation"
echo "8) Security review"
echo "9) General/exploration work"
echo ""
read -p "Enter choice [1-9]: " choice

case $choice in
    1)
        echo ""
        echo "Use: templates/v1/feature-development-session-template.md"
        echo "Example: examples/feature-development/EXAMPLE-feature-development-leave-request.md"
        ;;
    2)
        echo ""
        echo "Use: templates/v1/debugging-session-template.md"
        echo "Example: examples/debugging/EXAMPLE-debugging-revenue-bug.md"
        ;;
    3)
        echo ""
        echo "Use: templates/v1/refactor-optimization-session-template.md"
        echo "Example: examples/refactoring/EXAMPLE-refactor-optimization-dashboard.md"
        ;;
    4)
        echo ""
        echo "Use: templates/v1/database-schema-session-template.md"
        echo "Example: examples/database-schema/EXAMPLE-database-schema-asset-management.md"
        ;;
    5)
        echo ""
        echo "Use: templates/v1/api-endpoint-session-template.md"
        echo "Example: examples/api-endpoint/EXAMPLE-api-endpoint-user-profile.md"
        ;;
    6)
        echo ""
        echo "Use: templates/v1/design-review-session-template.md"
        ;;
    7)
        echo ""
        echo "Use: templates/v1/documentation-session-template.md"
        ;;
    8)
        echo ""
        echo "Use: templates/v1/security-review-session-template.md"
        ;;
    9)
        echo ""
        echo "Use: templates/v1/init-session-template.md"
        ;;
    *)
        echo "Invalid choice"
        exit 1
        ;;
esac

echo ""
