#  AI Dev Workflow - Installation Guide

**Minimal Local Copy Strategy**

---

## 🎯 Installation Philosophy

This workflow uses a **"clone, copy, and own"** approach (copy essential files into your project):

1. **Clone** the workflow repository (temporary)
2. **Copy** only essential files to your project
3. **Own** the files as part of your project repository
4. **Customize** freely without affecting the source
5. **Update** periodically when new features are released

**Benefits:**
- ✅ Files become part of your project (team gets them automatically)
- ✅ No ongoing linked-repo complexity (prefer installer/clone)
- ✅ Customize freely for project needs
- ✅ Version controlled with your code
- ✅ Update on your schedule

---

## 📦 What Gets Installed (Minimal Copy)

### Files Copied to Your Project:

```
your-project/
└── ai-contexts/              (~50 files, no docs/examples)
    ├── README.md            (project-specific readme)
    ├── .workflow-version    (tracks version)
    ├── .gitignore          (ignores wip/ folder)
    │
    ├── contexts/            (AI learning documents)
    │   ├── master-context.md
    │   ├── code-workflow.md
    │   ├── general-problem-solving-context.md
    │   ├── backend/
    │   │   ├── backend-api-context.md
    │   │   └── database-schema-context.md
    │   └── frontend/
    │       ├── component-context.md
    │       ├── styling-context.md
    │       ├── ui-context.md
    │       └── unit-testing-context.md
    │
    ├── templates/           (Session templates)
    │   └── v1/
    │       ├── feature-development-session.md
    │       ├── debugging-session.md
    │       ├── refactor-optimization-session.md
    │       ├── database-schema-session.md
    │       ├── api-endpoint-session.md
    │       ├── design-review-session.md
    │       ├── documentation-session.md
    │       ├── security-review-session.md
    │       └── init-session.md
    │
    └── wip/                 (your work-in-progress sessions)
        (gitignored - keep work private until ready)
```

### NOT Copied (Keep in Source Repo):

- ❌ docs/ (documentation - reference online)
- ❌ examples/ (examples - reference online)
- ❌ presentations/ (presentations - reference online)
- ❌ integrations/ (optional installs)
- ❌ tools/ (optional)
- ❌ LICENSE, CONTRIBUTING.md (source repo files)

**Why minimal?**
- Keeps your project lean
- Reduces merge conflicts on updates
- Documentation changes don't affect your project
- You only track what you use

---

## 🚀 Installation Methods

### Method 1: Local-run Installer (Recommended)

If you cloned this repository locally, the local-run installer is the recommended, low-friction way to copy the minimal workflow files into an existing project. It uses the local repository files as the source of truth and does not fetch remote copies.

```bash
# From the workflow repo root:
cd /path/to/ai-dev-workflow
chmod +x install-ai-workflow.sh
./install-ai-workflow.sh /path/to/your/project

# Preview only (dry-run):
./install-ai-workflow.sh --dry-run /path/to/your/project
```

Note: The installer expects the target project directory to already exist. It will copy contexts, templates, and supporting README/gitkeep files into `ai-contexts/` under your project.
---

### Method 2: Manual Copy (Alternative)

If you prefer manual control (for advanced use or automation), you can clone the repository to a temporary location and copy only the files you want into your project. This is effectively what the installer does but gives you manual oversight.

```bash
# 1. Clone to a temporary location
git clone https://github.com/tichaonax/ai-dev-workflow.git /tmp/ai-workflow

# 2. Copy desired files into your project
cp /tmp/ai-workflow/contexts/*.md /path/to/your-project/ai-contexts/contexts/
cp /tmp/ai-workflow/templates/v1/*-session.md /path/to/your-project/ai-contexts/templates/v1/

# 3. Create .workflow-version and .gitignore as needed
echo "workflow_version=1.0.0" > /path/to/your-project/ai-contexts/.workflow-version
echo "wip/" > /path/to/your-project/ai-contexts/.gitignore

# 4. Clean up
rm -rf /tmp/ai-workflow

# 5. Commit
cd /path/to/your-project
git add ai-contexts/
git commit -m "Add AI development workflow v1.0.0"
```

---

## 📝 Post-Installation

### 1. Verify Installation

```bash
cd your-project

# Check structure
ls -la ai-contexts/

# Should see:
# contexts/
# templates/
# wip/
# README.md
# .workflow-version
# .gitignore

# Count files
find ai-contexts -name "*.md" | wc -l
# Should show ~15-20 files
```

### 2. Add to Git

```bash
git add ai-contexts/
git status

# Review what will be committed
git commit -m "Add AI development workflow v1.0.0

- Core contexts (master, code-workflow, backend, frontend)
- 9 session templates
- Version tracking
- Project README"

git push
```

### 3. Team Members Get It Automatically

When team members clone or pull:

```bash
# New team member clones
git clone https://github.com/your-org/your-project.git
cd your-project

# ai-contexts/ is already there! ✅
ls ai-contexts/
```

No special linked-repo commands needed — use the installer or clone-and-commit approach instead.

---

## ✏️ Customization

### Add Project-Specific Contexts

```bash
# Create custom contexts folder
mkdir -p ai-contexts/contexts/custom

# Add project patterns
cat > ai-contexts/contexts/custom/project-patterns.md << 'EOF'
# Project-Specific Patterns

## Our Tech Stack
- React 20 with TypeScript
- Node.js backend with Express
- PostgreSQL database with Prisma
- Tailwind CSS for styling

## Our Conventions
- Feature branches: feature/123-description
- Component naming: PascalCase
- File naming: kebab-case
- Test files: *.test.ts

## Our Patterns
[Add your patterns here]
EOF

# Commit
git add ai-contexts/contexts/custom/
git commit -m "Add project-specific context patterns"
git push
```

**Structure with customizations:**

```
ai-contexts/
├── contexts/
│   ├── master-context.md          ← From workflow
│   ├── code-workflow.md           ← From workflow
│   ├── backend/                   ← From workflow
│   ├── frontend/                  ← From workflow
│   └── custom/                    ← YOUR CUSTOMIZATIONS
│       ├── project-patterns.md    ← Won't be overwritten
│       ├── api-standards.md       ← Won't be overwritten
│       └── team-conventions.md    ← Won't be overwritten
```

---

## 🔄 Updating to Newer Versions

### When to Update

Check for updates:
- Quarterly (recommended)
- When new features announced
- When bug fixes released

### Update Process

```bash
# 1. Check current version
cat ai-contexts/.workflow-version

# Example output:
# workflow_version=1.0.0
# installed_date=2025-10-20

# 2. Clone latest workflow
git clone https://github.com/tichaonax/ai-dev-workflow.git /tmp/workflow-latest

# 3. Check what's new
cd /tmp/workflow-latest
cat CHANGELOG.md

# Look for new features you want

# 4. Backup your customizations
cd your-project
cp -r ai-contexts/contexts/custom /tmp/custom-backup

# 5. Copy updated files you want
# Option A: Update specific file
cp /tmp/workflow-latest/contexts/master-context.md ai-contexts/contexts/

# Option B: Update all contexts (careful with customizations!)
cp -r /tmp/workflow-latest/contexts/*.md ai-contexts/contexts/

# Option C: Update templates
cp /tmp/workflow-latest/templates/v1/*-session.md ai-contexts/templates/v1/

# 6. Restore your customizations
cp -r /tmp/custom-backup/* ai-contexts/contexts/custom/

# 7. Update version file
echo "workflow_version=1.1.0" > ai-contexts/.workflow-version
echo "installed_date=$(date +%Y-%m-%d)" >> ai-contexts/.workflow-version
echo "updated_from=1.0.0" >> ai-contexts/.workflow-version

# 8. Test
# Make sure everything still works

# 9. Commit
git add ai-contexts/
git commit -m "Update AI workflow from v1.0.0 to v1.1.0

Updated:
- master-context.md
- code-workflow.md
- All templates

Kept:
- Custom project patterns
- Team conventions"

git push

# 10. Clean up
rm -rf /tmp/workflow-latest /tmp/custom-backup
```

---

## 🎯 Multiple Projects Strategy

### Each Project Gets Its Own Copy

```
Project A (E-commerce)
└── ai-contexts/
    ├── contexts/ (workflow + ecommerce customizations)
    └── templates/

Project B (Internal Tools)  
└── ai-contexts/
    ├── contexts/ (workflow + internal-tools customizations)
    └── templates/

Project C (Mobile API)
└── ai-contexts/
    ├── contexts/ (workflow + mobile customizations)
    └── templates/
```

**Process for each:**
1. Run installer: `./install-ai-workflow.sh /path/to/project`
2. Add project customizations to `contexts/custom/`
3. Commit to that project's repo
4. Update independently when needed

---

<!-- Removed legacy linked-repo comparison per project policy. Recommended approaches: local-run installer (preferred), manual clone, or download. -->

---

## 🛡️ Best Practices

### Do's ✅

1. **Do add customizations to `custom/` folders**
   ```
   contexts/custom/
   templates/v1/custom/
   ```

2. **Do document your customizations**
   ```bash
   echo "## Project Customizations" >> ai-contexts/README.md
   echo "- Added payment gateway patterns" >> ai-contexts/README.md
   ```

3. **Do commit workflow files with your project**
   ```bash
   git add ai-contexts/
   git commit -m "Clear description of changes"
   ```

4. **Do track version updates**
   ```bash
   # Update .workflow-version file
   echo "updated_from=1.0.0 to=1.1.0 date=$(date)" >> ai-contexts/.workflow-version
   ```

5. **Do test after updates**
   ```bash
   # Try a simple AI session to verify
   ```

### Don'ts ❌

1. **Prefer installer or clone**
   - Not necessary with this approach
   - Adds unnecessary complexity

2. **Don't modify workflow files directly** (unless you mean to)
   - Instead, create custom files in `custom/` folders
   - Easier to update later

3. **Don't commit `wip/` folder**
   - Already in .gitignore
   - Keep work-in-progress private

4. **Don't update without backing up customizations**
   ```bash
   # Always backup first
   cp -r ai-contexts/contexts/custom /tmp/backup
   ```

---

## 🆘 Troubleshooting

### Issue: Installer Fails

**Error:** "Directory does not exist"

**Solution:** Ensure your target project directory exists, then run the installer from the workflow repo root and pass the project path:

```bash
# Create project directory first (if needed)
mkdir -p /path/to/project

# From the workflow repo root (where install-ai-workflow.sh is located):
cd /path/to/ai-dev-workflow
./install-ai-workflow.sh /path/to/project
```

### Issue: Files Already Exist

**Error:** "ai-contexts/ already exists"

**Solution:**
```bash
# Installer will offer to backup
# Or manually:
mv ai-contexts ai-contexts.backup.$(date +%Y%m%d)
./install-ai-workflow.sh /path/to/project
```

### Issue: Want to Reinstall

**Cleanly reinstall:**
```bash
# 1. Backup customizations
cp -r ai-contexts/contexts/custom /tmp/custom-backup
cp -r ai-contexts/wip /tmp/wip-backup

# 2. Remove current
rm -rf ai-contexts

# 3. Reinstall
./install-ai-workflow.sh /path/to/project

# 4. Restore customizations
cp -r /tmp/custom-backup ai-contexts/contexts/custom
cp -r /tmp/wip-backup/* ai-contexts/wip/

# 5. Commit
git add ai-contexts/
git commit -m "Reinstall workflow, restored customizations"
```

---

## 📚 Next Steps

After installation:

1. **Read the quick start:**
   ```bash
   cat ai-contexts/README.md
   ```

2. **Try first session:**
   - Pick a template
   - Start AI session
   - Follow workflow

3. **Add customizations:**
   - Create `contexts/custom/project-patterns.md`
   - Document your standards

4. **Share with team:**
   - Commit and push
   - Team gets it automatically

5. **Check for updates quarterly:**
   - Review CHANGELOG
   - Update when beneficial

---

## 📖 Full Documentation

For complete docs, examples, and guides:

**Source Repository:** https://github.com/tichaonax/ai-dev-workflow

- 📚 Examples
- 🎓 Presentations
- 🔧 Tools
- 💡 Best Practices

---

**Questions?** Check the source repo or open an issue!

**Happy AI-assisted coding!** 🚀
