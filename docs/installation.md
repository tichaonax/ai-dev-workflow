# Installation Guide

**Complete guide to installing AI-Assisted Development Workflow in your project**

---

## 📋 Table of Contents

- [Installation Methods](#installation-methods)
- [Method 1: Local-run Installer (Recommended)](#method-1-local-run-installer-recommended)
- [Method 2: Clone Repository](#method-2-clone-repository)
- [Method 3: Manual Download](#method-3-manual-download)
- [Method 4: Symlink](#method-4-symlink)
- [Post-Installation Setup](#post-installation-setup)
- [Team Installation](#team-installation)
- [Verification](#verification)
- [Troubleshooting](#troubleshooting)

---

## 🎯 Installation Methods

Choose the method that best fits your workflow:

| Method | Best For | Pros | Cons |
|--------|----------|------|------|
| **Local-run Installer** | Local repository users | Minimal files copied, simple updates | Requires local clone |
| **Clone** | Single project | Simple, full control | Manual updates |
| **Download** | Quick try-out | Fastest start | No version tracking |
| **Symlink** | Multi-project | Share across projects | Platform-specific |


## Method 1: Local-run Installer (Recommended)

The installer copies only the minimal workflow files into your existing project. **Keep the cloned repository for updates and contributions.**

### Step 1: Clone the AI Workflow Repository

```bash
# Clone to a permanent location (e.g., your home directory)
git clone https://github.com/tichaonax/ai-dev-workflow.git ~/ai-dev-workflow
cd ~/ai-dev-workflow
```

**Important:** Don't delete this clone! You'll use it for:
- Getting updates (`git pull`)
- Installing to multiple projects
- Contributing improvements

### Step 2: Run the Installer

```bash
# Make installer executable
chmod +x install-ai-workflow.sh

# Run installer (dry-run first to preview)
./install-ai-workflow.sh --dry-run /path/to/your/existing-project

# Install for real
./install-ai-workflow.sh /path/to/your/existing-project
```

### Step 3: Get Updates (When Available)

```bash
# Pull latest updates from GitHub
cd ~/ai-dev-workflow
git pull

# Re-run installer to update your project(s)
./install-ai-workflow.sh /path/to/your/existing-project
```

**Smart Update Detection:**
- Installer detects existing `ai-contexts/` directory
- Automatically creates timestamped backup: `ai-contexts.backup.YYYYMMDD_HHMMSS/`
- Asks for confirmation before overwriting
- Preserves any custom folders you created

### Installer Flags:
- `--dry-run` : Preview actions without changing files
- `-y|--yes` : Non-interactive mode, assume yes to prompts (auto-backup)
- `--list-templates` : List available templates and exit

### What Gets Installed:

The installer copies these directories to `your-project/ai-contexts/`:
- `contexts/` - AI context documents
- `templates/` - Session templates
- `integrations/` - VS Code snippets and other integrations
- `docs/` - Documentation
- `examples/` - Real-world examples

### Multiple Projects:

Install to as many projects as you need from the same clone:

```bash
cd ~/ai-dev-workflow
./install-ai-workflow.sh /path/to/project-1
./install-ai-workflow.sh /path/to/project-2
./install-ai-workflow.sh /path/to/project-3
```

**Note:** This method keeps your project repos lean by copying only essential files, not the entire repository.

## Method 2: Clone Directly Into Your Project

**Best for:** Single developer, full customization, want entire repository

### Step 1: Clone Into Your Project

```bash
# Navigate to your project root
cd /path/to/your/project

# Clone the repository as ai-contexts directory
git clone https://github.com/tichaonax/ai-dev-workflow.git ai-contexts
```

### Step 2: Remove Git History (Optional)

If you want to make it part of your project (not track upstream):

```bash
# Remove the git history
cd ai-contexts
rm -rf .git
cd ..

# Add to your project's git
git add ai-contexts/
git commit -m "Add AI workflow system"
```

### Updating

If you kept the git history (didn't remove .git), you can update:

```bash
cd ai-contexts
git pull origin main
# Resolve any conflicts with your customizations
```

### Advantages ✅
- ✅ Simple to understand
- ✅ Full control over files
- ✅ Easy to customize

### Disadvantages ❌
- ❌ Manual updates
- ❌ Harder to sync with team
- ❌ Can't easily track upstream changes

---

## Method 3: Manual Download

**Best for:** Quick evaluation, no git

### Step 1: Download

```bash
# Download ZIP from GitHub
# Visit: https://github.com/tichaonax/ai-dev-workflow/archive/refs/heads/main.zip
# Or use wget/curl:
curl -L https://github.com/tichaonax/ai-dev-workflow/archive/refs/heads/main.zip -o ai-workflow.zip
```

### Step 2: Extract and Rename

```bash
# Extract the ZIP file
unzip ai-workflow.zip

# Navigate to your project
cd /path/to/your/project

# Move and rename to ai-contexts
mv ~/Downloads/ai-dev-workflow-main ./ai-contexts
```

### Step 3: Add to Your Repo

```bash
git add ai-contexts/
git commit -m "Add AI workflow system"
git push
```

### Updating

Download new version and replace files:

```bash
# Backup your customizations first!
cp -r ai-contexts ai-contexts-backup

# Download new version, extract, replace
# ...then restore customizations
```

### Advantages ✅
- ✅ Fastest to start
- ✅ No git knowledge needed
- ✅ Works anywhere

### Disadvantages ❌
- ❌ No version tracking
- ❌ Difficult updates
- ❌ Hard to track changes


## Method 4: Symlink

**Best for:** Working on multiple projects, central location

### Step 1: Clone Centrally

```bash
# Clone to a central location
mkdir -p ~/ai-tools
cd ~/ai-tools
git clone https://github.com/tichaonax/ai-dev-workflow.git
```

### Step 2: Symlink to Projects

```bash
# In each project
cd /path/to/project1
ln -s ~/ai-tools/ai-dev-workflow ai-contexts

cd /path/to/project2
ln -s ~/ai-tools/ai-dev-workflow ai-contexts
```

### Step 3: Update Centrally

```bash
# Update once, affects all projects
cd ~/ai-tools/ai-dev-workflow
git pull origin main
```

### Advantages ✅
- ✅ Single source of truth
- ✅ One update affects all projects
- ✅ Saves disk space

### Disadvantages ❌
- ❌ Platform-specific (Unix/Linux/Mac)
- ❌ Breaks if central location moves
- ❌ Harder for team coordination


## Post-Installation Setup

### 1. Verify Installation

```bash
# Check structure
ls -la ai-contexts/

# Should see:
# - contexts/
# - templates/
# - examples/
# - docs/
# - integrations/
# - tools/
```

### 2. Install VS Code Snippets (Optional)

```bash
# Copy snippets to VS Code
cp ai-contexts/integrations/vscode/ai-workflow-snippets.code-snippets \
   ~/.vscode/snippets/

# Or for workspace-specific:
mkdir -p .vscode
cp ai-contexts/integrations/vscode/ai-workflow-snippets.code-snippets \
   .vscode/
```

### 3. Install GitHub Templates (Optional)

```bash
# Copy PR template
mkdir -p .github
cp ai-contexts/integrations/github/PULL_REQUEST_TEMPLATE.md .github/

# Copy issue template
cp ai-contexts/integrations/github/ISSUE_TEMPLATE.md .github/
```

### 4. Add to .gitignore

```bash
# Add to your .gitignore
echo "ai-contexts/wip/" >> .gitignore
echo "ai-contexts/personal/" >> .gitignore
```

This keeps work-in-progress sessions private.


## Team Installation

### For Team Lead

1. Install the workflow into the main repository using the local-run installer (preferred) or clone the repo and commit the `ai-contexts/` folder.

```bash
# From workflow repo root (local-run installer)
./install-ai-workflow.sh /path/to/your/main-repo

# Or in the main repo, clone and commit the ai-contexts folder
cd /path/to/your/main-repo
# Clone the upstream repo into `ai-contexts/` if you prefer to maintain a full copy of the workflow instead of using the local installer.
git add ai-contexts/
git commit -m "Add AI workflow system"
git push
```

2. Create team documentation that points to `ai-contexts/docs/quick-start.md` and any project-specific customizations.

3. Announce the workflow and usage steps to the team (Slack, docs, or training session).

### For Team Members

1. Update your clone by pulling changes (if the repo keeps `ai-contexts/` tracked directly, a regular `git pull` is sufficient). If your team uses the local-run installer, team leads should update the repository and push the committed files.

```bash
# Just pull changes
git pull
```

2. Read the quick start:

```bash
cat ai-contexts/docs/quick-start.md
```

3. Try your first session: pick a template and follow the quick start guide.


## Verification

### Check Installation

```bash
# Run verification script
./ai-contexts/tools/select-template.sh

# Should show menu of templates
```

### Test with AI

```bash
# Start AI session
cat ai-contexts/contexts/master-context.md

# AI should be able to read and understand
```

### Verify Structure

```bash
# Check all folders exist
[ -d "ai-contexts/contexts" ] && echo "✓ Contexts"
[ -d "ai-contexts/templates" ] && echo "✓ Templates"
[ -d "ai-contexts/examples" ] && echo "✓ Examples"
[ -d "ai-contexts/docs" ] && echo "✓ Docs"
[ -d "ai-contexts/integrations" ] && echo "✓ Integrations"
```


## Customization After Installation

### Add Project-Specific Contexts

```bash
# Create custom contexts
mkdir -p ai-contexts/contexts/custom

# Add your project patterns
echo "# My Project Patterns" > ai-contexts/contexts/custom/project-patterns.md
```

### Create Custom Templates

```bash
# Copy and customize
cp ai-contexts/templates/v1/feature-development-session.md \
   ai-contexts/templates/v1/custom-my-feature-template.md

# Edit for your needs
```

### Add Tech Stack Contexts

```bash
# Example: Python context
cat > ai-contexts/contexts/custom/python-patterns.md << 'EOF'
# Python Coding Patterns

## Style
- PEP 8 compliant
- Type hints required
- Docstrings in Google format

## Testing
- pytest framework
- 80%+ coverage required
EOF
```


## Troubleshooting

### Issue: Installer/Clone Not Set Up Correctly

**Problem:** After running the installer or cloning, `ai-contexts/` is missing or incomplete.

**Solution:**
```bash
# If you ran the installer, ensure you ran it from the workflow repo root and passed an existing project path.
cd /path/to/ai-dev-workflow
./install-ai-workflow.sh /path/to/project

# If you cloned, make sure the clone completed and the folder exists
ls -la ai-contexts/
```

### Issue: Permission Denied on Script

**Problem:** Can't run `./tools/select-template.sh`

**Solution:**
```bash
chmod +x ai-contexts/tools/select-template.sh
```

### Issue: AI Can't Read Files

**Problem:** AI says "file not found"

**Solution:**
```bash
# Use absolute path
pwd  # Get current directory
# Then: ai-contexts/contexts/master-context.md from that path
```

### Issue: Conflicts When Updating Copied Files

**Problem:** Local changes in `ai-contexts/` conflict with an attempted update from a new copy.

**Solution:**
```bash
# Backup your customizations first
cp -r ai-contexts/contexts/custom /tmp/custom-backup

# Copy updated files from a fresh clone (or run installer locally)
git clone https://github.com/tichaonax/ai-dev-workflow.git /tmp/workflow-latest
cp /tmp/workflow-latest/contexts/master-context.md ai-contexts/contexts/

# Restore your customizations
cp -r /tmp/custom-backup/* ai-contexts/contexts/custom/
```

### Issue: Team Member Can't Access

**Problem:** Other developers don't see ai-contexts/

**Solution:**
```bash
# They need to:
git pull
```


## Uninstallation

If you installed via the local-run installer or by cloning, simply remove the `ai-contexts/` folder and commit the change:

```bash
rm -rf ai-contexts/
git add -A
git commit -m "Remove AI workflow"
```


## Next Steps

✅ **Installation Complete!**

Now:
1. 📚 Read [Quick Start Guide](quick-start.md) (5 minutes)
2. 💡 Review [Core Concepts](concepts.md) (10 minutes)
3. 🎯 Try your first session with a small task
4. 📖 Study [Best Practices](best-practices.md) when ready


## Platform-Specific Notes

### macOS
```bash
# All methods work natively
# Symlinks fully supported
```

### Linux
```bash
# All methods work natively
# Symlinks fully supported
```

### Windows

**Git Bash (Recommended):**
```bash
# Use the same installer or clone approach as macOS/Linux
# From a local clone of this repo, run the installer or clone into ai-contexts/
./install-ai-workflow.sh /path/to/your-project
# Or: clone the repo into `ai-contexts/` if you prefer that workflow (see repository URL)
```

**PowerShell:**
```powershell
# For symlinks, run as Administrator:
New-Item -ItemType SymbolicLink -Path "ai-contexts" -Target "C:\ai-tools\ai-dev-workflow"
```

**WSL (Best Experience):**
```bash
# Same as Linux
```


**Need help?** Check [FAQ](faq.md) or [Troubleshooting](troubleshooting.md)

[← Back to Docs](../README.md) | [Quick Start →](quick-start.md)
