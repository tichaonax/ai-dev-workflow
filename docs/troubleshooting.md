# Troubleshooting Guide

> Solutions to common issues when using the AI Development Workflow System

---

## Table of Contents

- [Installation Issues](#installation-issues)
- [Context Loading Problems](#context-loading-problems)
- [Workflow Command Issues](#workflow-command-issues)
- [Template Problems](#template-problems)
- [Project Plan Issues](#project-plan-issues)
- [AI Behavior Problems](#ai-behavior-problems)
- [Integration Issues](#integration-issues)
- [Performance Issues](#performance-issues)

---

## Installation Issues

### Error: "ai-contexts/ folder not found"

**Symptom:**
```
❌ Error: ai-contexts/ folder not found
```

**Cause:** Running workflow commands in wrong directory

**Solution:**
```bash
# Navigate to project root (where ai-contexts/ exists)
cd /path/to/your/project

# Verify ai-contexts exists
ls ai-contexts/

# If it doesn't exist, install it
git clone https://github.com/tichaonax/ai-dev-workflow.git ~/ai-dev-workflow
cd ~/ai-dev-workflow
./install-ai-workflow.sh /path/to/your/project
```

---

### Installer says "permission denied"

**Symptom:**
```
bash: ./install-ai-workflow.sh: Permission denied
```

**Solution:**
```bash
# Make installer executable
chmod +x install-ai-workflow.sh

# Then run it
./install-ai-workflow.sh /path/to/your/project
```

---

### Files not copying during installation

**Symptom:**
Installation completes but files are missing

**Check:**
```bash
# Verify source files exist
ls -la ~/ai-dev-workflow/contexts/
ls -la ~/ai-dev-workflow/templates/

# Check target directory permissions
ls -la /path/to/your/project/

# Try with verbose output
./install-ai-workflow.sh --dry-run /path/to/your/project
```

**Solution:**
- Ensure you have write permissions to target directory
- Check disk space: `df -h`
- Try manual copy: `cp -r contexts/ /path/to/your/project/ai-contexts/`

---

## Context Loading Problems

### AI says "I can't access that file"

**Symptom:**
```
👤 Read ai-contexts/contexts/master-context.md
🤖 I don't have access to that file
```

**Cause:** AI assistant doesn't have file system access

**Solution - Option 1: Copy-Paste Content**
```
👤 Here's the master-context.md content:

[Paste entire file content]
```

**Solution - Option 2: Use AI with File Access**
- Claude Code (VS Code extension) - has file access
- Cursor AI - has file access
- Some AI tools require you to upload files explicitly

---

### AI not applying context standards

**Symptom:**
AI generates code that doesn't follow your patterns

**Diagnosis:**
```
👤 What did you learn from component-context.md?
```

If AI can't summarize it, it didn't actually read/retain it.

**Solutions:**

**1. Reload context in same message as request:**
```
👤 Review component-context.md, then help me create a Button component
```

**2. Be more explicit:**
```
👤 Following the patterns in component-context.md (specifically the
   functional component pattern on line 45), create a Button component
```

**3. Reference specific sections:**
```
👤 Use the export pattern from component-context.md section "Export Patterns"
```

---

### Context file path not found

**Symptom:**
```
Error: File not found: ai-contexts/contexts/master-context.md
```

**Check file exists:**
```bash
ls ai-contexts/contexts/master-context.md
```

**If missing, reinstall:**
```bash
cd ~/ai-dev-workflow
git pull
./install-ai-workflow.sh /path/to/your/project
```

**Check file path format:**
- ✅ `ai-contexts/contexts/master-context.md`
- ❌ `./ai-contexts/contexts/master-context.md`
- ❌ `/ai-contexts/contexts/master-context.md`

Use relative path from project root.

---

## Workflow Command Issues

### "TASK START" command not recognized

**Symptom:**
```
👤 TASK START HPP-123 user-auth
🤖 I'm not sure what you mean by TASK START
```

**Cause:** AI hasn't learned workflow commands

**Solution:**
```
👤 Please read these files first to learn our workflow commands:
   1. ai-contexts/contexts/master-context.md
   2. ai-contexts/contexts/code-workflow.md

   After reading them, help me with: TASK START HPP-123 user-auth
```

---

### AI skips template selection

**Symptom:**
AI creates project plan immediately without showing templates

**Expected behavior:**
```
🤖 Choose a template:
   1. feature-development
   2. debugging
   ...
```

**Fix:**
```
👤 STOP. Review master-context.md section on "TASK START" command.
   You must show template selection menu and wait for my choice.
   Start over: TASK START HPP-123 user-auth
```

---

### AI doesn't wait for approval

**Symptom:**
AI creates project plan and immediately starts coding

**Fix:**
```
👤 STOP all code changes. Review code-workflow.md section
   "Mandatory Approval Checkpoints." You must wait for explicit
   approval before writing any code.

   Show me the project plan and wait for my approval.
```

---

### Commands work in one session but not another

**Cause:** Each new AI session starts with no memory of previous sessions

**Solution:**
Load contexts at the start of every new session:

```
# Start of every session:
👤 Please read:
   1. ai-contexts/contexts/master-context.md
   2. ai-contexts/contexts/code-workflow.md

# Or use VS Code snippet:
ai-train + Tab
```

**Pro tip:** Create a snippet so you don't have to type this every time.

---

## Template Problems

### Template file corrupted or invalid format

**Symptoms:**
- Template shows garbled text
- Sections missing
- Invalid markdown

**Solution:**
```bash
# Restore from source
cd ~/ai-dev-workflow
git pull
cp templates/v1/{template-name}.md /path/to/your/project/ai-contexts/templates/v1/
```

---

### Can't find custom template

**Check:**
```bash
# List all templates
ls ai-contexts/templates/v1/

# Verify naming convention
# Should be: {name}-session.md
# ✅ feature-development-session.md
# ❌ feature-development.md
# ❌ my-template.md
```

**Fix:**
```bash
# Rename to correct format
mv ai-contexts/templates/v1/my-template.md \
   ai-contexts/templates/v1/my-template-session.md
```

---

### Template fields not clear

**Symptom:**
Not sure what to fill in for template fields

**Solution:**
Look at examples:

```bash
# View filled examples
ls examples/EXAMPLE-*-filled.md

# Read a similar example
cat examples/EXAMPLE-feature-development-session-filled.md
```

Or ask AI:
```
👤 I'm filling out the feature-development template.
   What should I put for "Integration Points"?
```

---

## Project Plan Issues

### Project plan not created

**Symptom:**
After typing START, no project plan file appears

**Check:**
```bash
ls ai-contexts/project-plans/active/
```

**Possible causes:**

**1. Didn't fill template:**
```
You must fill the template before typing START
```

**2. AI needs reminder:**
```
👤 Create the project plan document as specified in code-workflow.md,
   using format: projectplan-HPP-123-user-auth-2025-10-22.md
```

**3. Wrong directory:**
```bash
# Should create in:
ai-contexts/project-plans/active/

# Not in:
ai-contexts/project-plans/  (root - wrong)
./  (project root - wrong)
```

---

### Checkboxes not updating

**Symptom:**
AI says task is complete but checkboxes still show `- [ ]`

**Manual fix:**
```bash
# Edit project plan file
vi ai-contexts/project-plans/active/projectplan-HPP-123-*.md

# Change:
- [ ] Task 1.1: Do something
# To:
- [x] Task 1.1: Do something
```

**Prevent in future:**
```
👤 After completing each task, you MUST update the project plan
   file checkboxes from [ ] to [x]. This is mandatory per
   code-workflow.md section "Task Tracking and Status Updates."
```

---

### Project plan in wrong format

**Symptom:**
Project plan missing required sections or poorly formatted

**Required sections (all 8):**
1. Task Overview
2. Files Affected
3. Impact Analysis
4. To-Do Checklist
5. Risk Assessment
6. Testing Plan
7. Rollback Plan
8. Review Summary

**Fix:**
```
👤 This project plan is missing sections. Review code-workflow.md
   section "Plan Document Structure" and recreate the plan with
   all 8 required sections.
```

---

### Can't find completed project plans

**Check location:**
```bash
# Should be organized by month:
ai-contexts/project-plans/completed/2025-10/
ai-contexts/project-plans/completed/2025-11/
```

**If in wrong location:**
```bash
# Move to correct folder
mkdir -p ai-contexts/project-plans/completed/2025-10
mv ai-contexts/project-plans/projectplan-*.md \
   ai-contexts/project-plans/completed/2025-10/
```

---

## AI Behavior Problems

### AI makes assumptions instead of asking

**Symptom:**
AI chooses approach without consulting you

**Prevention:**
Fill template completely with all constraints:

```markdown
**Constraints:**
- Must use existing Authentication library (don't install new)
- Must work with IE11 (no ES6+ features)
- Must complete in 3 days (choose simple approach)
```

**In the moment:**
```
👤 STOP. Don't assume [X]. Ask me whether to [option A] or [option B].
```

---

### AI deviates from approved plan

**Symptom:**
AI implements something different than the approved project plan

**Fix:**
```
👤 This doesn't match the approved project plan. Review:
   ai-contexts/project-plans/active/projectplan-HPP-123-*.md

   Revert these changes and implement exactly as planned.
   If you need to deviate, explain why and request approval.
```

---

### AI generates code without tests

**Symptom:**
Code implemented but no tests written

**Prevention:**
Include in template:

```markdown
**Testing Requirements:**
**Unit Tests:**
- Test successful login
- Test invalid credentials
- Test locked account

**Coverage Required:** 80% minimum
```

**Fix:**
```
👤 Code-workflow.md requires tests for all code. Add unit tests
   for the authentication logic you just implemented.
```

---

### AI skips documentation

**Fix:**
```
👤 Update project plan section "Review Summary" with:
   - What worked well
   - What could be improved
   - Lessons learned
```

---

## Integration Issues

### VS Code snippets not working

**Check installation:**
```bash
# Snippets should be in project .vscode/
ls .vscode/ai-workflow-commands.code-snippets
```

**If missing:**
```bash
cp ai-contexts/integrations/vscode/ai-workflow-commands.code-snippets \
   .vscode/
```

**Restart VS Code:**
- Cmd+Shift+P (Mac) or Ctrl+Shift+P (Windows)
- Type: "Reload Window"
- Press Enter

**Test snippet:**
- Create new file
- Type: `ai-train`
- Press Tab
- Should expand to full training message

**If still not working:**
- Check VS Code version (needs >= 1.50)
- Check file is valid JSON: `cat .vscode/ai-workflow-commands.code-snippets`
- Check VS Code settings don't disable snippets

---

### Git conflicts in ai-contexts/

**Symptom:**
```
CONFLICT (content): Merge conflict in ai-contexts/project-plans/active/projectplan-*.md
```

**Solution:**
```bash
# Check what's conflicting
git status

# For project plans, usually want to keep both
git checkout --ours ai-contexts/project-plans/active/projectplan-*.md  # Your version
# or
git checkout --theirs ai-contexts/project-plans/active/projectplan-*.md  # Their version

# For contexts, usually want latest
git checkout --theirs ai-contexts/contexts/master-context.md

# After resolving
git add ai-contexts/
git commit
```

---

## Performance Issues

### AI sessions are slow

**Symptom:**
AI takes long time to respond

**Causes & Solutions:**

**1. Too many contexts loaded:**
```
❌ Loading all 9 contexts
✅ Load only 3-4 relevant contexts
```

**2. Very long conversation:**
```
✅ Start new session for new task
✅ Don't carry over 100+ messages
```

**3. Large files in context:**
```
❌ Asking AI to read 5000-line file
✅ Point AI to specific functions/sections
```

**4. Complex project plans:**
```
✅ Break large features into smaller tasks
✅ One project plan per feature (not mega-plan)
```

---

### Context files too large

**Symptom:**
Markdown files growing very large

**Solutions:**

**1. Split into modules:**
```
Instead of:
contexts/all-backend-patterns.md (10,000 lines)

Use:
contexts/backend/api-patterns.md (1,000 lines)
contexts/backend/database-patterns.md (1,000 lines)
contexts/backend/auth-patterns.md (1,000 lines)
```

**2. Use links instead of duplication:**
```markdown
## Authentication
See detailed patterns in: auth-patterns-context.md
```

**3. Remove outdated content:**
```
Review contexts quarterly
Remove deprecated patterns
Archive old versions
```

---

## Still Having Issues?

### Get Help

1. **Check documentation:**
   - [FAQ](faq.md)
   - [Best Practices](best-practices.md)
   - [Complete Workflow](complete-workflow.md)

2. **Search GitHub Issues:**
   - [https://github.com/tichaonax/ai-dev-workflow/issues](https://github.com/tichaonax/ai-dev-workflow/issues)
   - Someone may have had same issue

3. **Ask in Discussions:**
   - [https://github.com/tichaonax/ai-dev-workflow/discussions](https://github.com/tichaonax/ai-dev-workflow/discussions)
   - Community can help

4. **Report a Bug:**
   - [https://github.com/tichaonax/ai-dev-workflow/issues/new](https://github.com/tichaonax/ai-dev-workflow/issues/new)
   - Include:
     - What you were trying to do
     - What happened instead
     - Steps to reproduce
     - Your setup (AI tool, OS, etc.)

---

## Common Error Messages

### Quick Reference

| Error Message | Solution |
|---------------|----------|
| "ai-contexts/ folder not found" | Navigate to project root or install system |
| "Permission denied" | Run `chmod +x install-ai-workflow.sh` |
| "File not found: master-context.md" | Reinstall or check file path |
| "TASK START not recognized" | AI needs to read master-context.md first |
| "Template not found" | Check template name ends with `-session.md` |
| "Cannot access file" | Use AI with file system access or copy-paste content |

---

[Back to README](../README.md) | [FAQ](faq.md) | [Best Practices](best-practices.md)
