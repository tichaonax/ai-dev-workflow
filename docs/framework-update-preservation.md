# Framework Update Preservation

This document explains how the AI Dev Workflow installer preserves your custom work during framework updates.

## What Gets Preserved

When you run the installer on an existing installation, it automatically preserves:

### 1. Custom Templates
- **Custom template directories**: `templates/custom/` and any other non-v1 directories
- **Custom v1 templates**: Templates in `templates/v1/` that aren't part of the framework
- **Framework templates are updated**: Standard templates get refreshed with latest improvements

### 2. Work-in-Progress Sessions
- **All WIP files**: `wip/*.md` files (except README.md)
- **WIP subdirectories**: Complete directory structures within `wip/`
- **Session continuity**: Your active development sessions remain intact

### 3. Project Plans
- **Active plans**: `project-plans/active/*.md` files
- **Completed plans**: `project-plans/completed/` files and directories
- **Historical records**: All completed project documentation is preserved

### 4. Custom Team Contexts
- **Team-specific contexts**: `custom/*.md` files (except README.md)
- **Local adaptations**: Any project-specific context modifications

## How It Works

### Backup Process
1. Installer detects existing `ai-contexts/` directory
2. Creates timestamped backup: `ai-contexts.backup.YYYYMMDD_HHMMSS/`
3. Identifies preservable content in the backup
4. Warns user about what will be preserved

### Update Process
1. Fresh framework files are installed
2. Directory structure is recreated
3. Framework templates and contexts are updated

### Restoration Process
1. Custom templates are restored to appropriate locations
2. WIP sessions are restored with full directory structure
3. Project plans (active and completed) are restored
4. Custom contexts are restored

## Example Update Flow

```bash
$ ./install-ai-workflow.sh /path/to/your/project

⚠️  Warning: ai-contexts/ already exists in target project

Existing installation found at:
  /path/to/your/project/ai-contexts/

This will:
  • Backup existing ai-contexts/ → ai-contexts.backup.20251026_144953/
  • Install fresh copy of workflow files
  • Preserve your custom templates, wip sessions, and project plans

Do you want to proceed with overwrite? (y/n) y

Creating backup: ai-contexts.backup.20251026_144953
  ✓ Backup created at: /path/to/your/project/ai-contexts.backup.20251026_144953

Preserving custom templates...
  ✓ Custom templates will be restored after installation

Preserving work-in-progress sessions...
  ✓ WIP sessions will be restored after installation

Preserving project plans...
  ✓ Project plans will be restored after installation

[Installation proceeds...]

Restoring preserved user content from backup...
  → Restoring custom templates
    ✓ Restored template directory: custom
    ✓ Restored custom template: my-project-specific-session.md
  → Restoring work-in-progress sessions
    ✓ Restored: current-feature-work.md
    ✓ Restored WIP directory: feature-branch
  → Restoring project plans
    ✓ Restored active plan: current-project.md
    ✓ Restored completed plan: finished-project.md
  ✓ User content restoration complete
```

## What Gets Updated

Even though your custom work is preserved, framework components are refreshed:

- **Core contexts**: `master-context.md`, `code-workflow.md`, etc.
- **Backend/Frontend contexts**: Latest patterns and conventions
- **Framework templates**: Standard session templates get improvements
- **VS Code snippets**: Updated snippets and new shortcuts
- **Documentation**: READMEs and documentation are refreshed

## Best Practices

### Before Updating
- **Review your custom work**: Know what you've customized
- **Commit your changes**: Ensure all work is committed to git
- **Test in a branch**: Consider updating in a feature branch first

### Custom Template Naming
- **Use descriptive names**: `my-company-feature-template.md` instead of `feature.md`
- **Avoid framework names**: Don't name custom templates with framework template names
- **Use custom directory**: Place major customizations in `templates/custom/`

### WIP Management
- **Clean up regularly**: Remove outdated WIP files periodically
- **Use descriptive names**: `feature-auth-system.md` instead of `work.md`
- **Organize with subdirectories**: Group related WIP files in folders

## Troubleshooting

### Missing Content After Update
1. Check the backup directory: `ai-contexts.backup.YYYYMMDD_HHMMSS/`
2. Look for your files in the backup
3. Manually restore if needed: `cp backup/path/file.md ai-contexts/path/`

### Conflicting Template Names
If you have a custom template with the same name as a framework template:
1. The framework template takes precedence
2. Your custom template is preserved in the backup
3. Rename your custom template and restore manually

### Partial Restoration
If only some content was restored:
1. Check file permissions in the backup directory
2. Ensure files have `.md` extension (for most content)
3. Check console output for restoration messages

## Testing

You can test the preservation functionality using the included test script:

```bash
./tests/test-installer-preservation.sh
```

This creates a temporary project, installs the framework, adds custom content, updates the framework, and verifies all content is preserved correctly.

## Migration from Previous Versions

If you're upgrading from a version before preservation was implemented:

1. **Backup manually first**: `cp -r ai-contexts ai-contexts-manual-backup`
2. **Run the installer**: Let it create its own backup and update
3. **Compare results**: Verify your content was preserved
4. **Clean up**: Remove manual backup if everything looks good

The preservation system is backward-compatible and will work with any existing installation.