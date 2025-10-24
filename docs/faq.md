# Frequently Asked Questions (FAQ)

> Common questions about the AI Development Workflow System

---

## Table of Contents

- [General Questions](#general-questions)
- [Getting Started](#getting-started)
- [Using the Workflow](#using-the-workflow)
- [Templates & Contexts](#templates--contexts)
- [Team & Collaboration](#team--collaboration)
- [Troubleshooting](#troubleshooting)
- [Advanced Usage](#advanced-usage)

---

## General Questions

### What is the AI Development Workflow System?

A structured system that makes AI coding assistants follow your team's standards through context documents, enforced workflows, and approval checkpoints. It prevents AI from making wrong assumptions and ensures consistent, high-quality code.

### Which AI assistants does this work with?

- ✅ Claude (Anthropic)
- ✅ ChatGPT (OpenAI)
- ✅ GitHub Copilot Chat
- ✅ Cursor AI
- ✅ Codeium
- ✅ Any AI that can read context files

### Do I need to change my existing workflow?

Not drastically. The system adds structure:
- **Before:** "AI, add this feature" → AI codes immediately
- **After:** "AI, TASK START..." → Template → Plan → Approval → Code

You're still coding, just with better planning and safety gates.

### Is this only for teams or can solo developers use it?

**Both!** Solo developers benefit from:
- Better planning (less rework)
- Documentation for future you
- Consistent patterns
- Easy context switching

Teams additionally get:
- Handoff capability
- Shared knowledge
- Consistent code across developers

### What's the learning curve?

- **5 minutes:** Follow your first template
- **30 minutes:** Complete first task with workflow
- **1 hour:** Understand the full system
- **1 day:** Comfortable with all templates

Most people see value in their first session.

---

## Getting Started

### How do I install this in my project?

Three options:

**Option 1: Installer (Recommended)**
```bash
git clone https://github.com/tichaonax/ai-dev-workflow.git ~/ai-dev-workflow
cd ~/ai-dev-workflow
chmod +x install-ai-workflow.sh
./install-ai-workflow.sh /path/to/your/project
```

**Option 2: Direct Clone**
```bash
cd /path/to/your/project
git clone https://github.com/tichaonax/ai-dev-workflow.git ai-contexts
```

**Option 3: Download ZIP**
Download from GitHub releases, extract to `ai-contexts/` in your project.

See [Installation Guide](installation.md) for details.

### What gets installed?

The installer copies to `ai-contexts/`:
- Context documents (`contexts/`)
- Session templates (`templates/v1/`)
- VS Code integration (`integrations/vscode/`)
- Documentation and examples

Total size: ~2MB of markdown files.

### Do I need to install anything globally?

No. Everything is markdown files. No dependencies, no npm packages, no global installs.

### Can I install this in multiple projects?

Yes! Either:
- Use the installer for each project
- Clone into each project's `ai-contexts/` folder

### How do I update to newer versions?

```bash
cd ~/ai-dev-workflow
git pull
./install-ai-workflow.sh /path/to/your/project
# Automatically backs up your existing ai-contexts/ and updates
```

---

## Using the Workflow

### What's the basic workflow?

**Two-phase process:**

**Phase 1: Setup**
```
1. TASK START {ticket} {description}
2. Choose template
3. Fill in requirements
4. START
```

**Phase 2: Execution**
```
5. AI creates project plan
6. You approve
7. AI implements phase 1
8. You approve
9. Repeat until complete
10. TASK COMPLETE
```

See [Complete Workflow Guide](complete-workflow.md).

### Do I have to use all the templates?

No! Use what's relevant:
- **Most common:** feature-development, debugging
- **As needed:** database-schema, api-endpoint, refactor-optimization
- **Occasionally:** documentation, security-review, design-review

### Can I skip the planning step?

You can, but you shouldn't. The planning step:
- ✅ Catches wrong assumptions early
- ✅ Saves rework time (80% reduction observed)
- ✅ Creates documentation automatically
- ✅ Enables team handoffs

**Result:** 5-10 minutes planning saves hours of rework.

### What if AI doesn't follow the workflow?

**Reason:** AI hasn't learned the workflow commands yet.

**Fix:**
```
👤 Please read these files first:
   1. ai-contexts/contexts/master-context.md
   2. ai-contexts/contexts/code-workflow.md

   After reading, help me with: TASK START {ticket} {description}
```

Or use the VS Code snippet: `ai-train` + Tab

### How do I know if I'm using it correctly?

**Good signs:**
- ✅ AI creates project plan before coding
- ✅ AI waits for approval between phases
- ✅ AI updates checkboxes in project plan
- ✅ You have documentation for completed work

**Bad signs:**
- ❌ AI starts coding immediately
- ❌ No project plan created
- ❌ AI doesn't ask for approval

---

## Templates & Contexts

### What's the difference between a template and a context?

**Template:** A form you fill out with requirements for a specific task
- Used once per task
- Becomes a project plan
- Example: "Add user authentication" fills feature-development template

**Context:** Documentation of your team's standards
- Loaded at start of session
- Teaches AI your patterns
- Example: "How we structure React components"

### Can I create my own templates?

Yes! Copy an existing template structure:

```markdown
# My Custom Session Template
> **Template Type:** Brief Description
> **Version:** 1.0

## 🎯 Purpose
What this is for

## 📋 Required Context Documents
Which contexts to load

## 🚀 Session Objective
Fields to fill in

## ✅ Start Session
Instructions for AI
```

Save in `ai-contexts/templates/v1/my-custom-session.md`

See [Customization Guide](customization.md).

### Can I modify the existing contexts?

**Don't modify core contexts** (`master-context.md`, `code-workflow.md`)

**Instead:** Create additional contexts:
```
ai-contexts/contexts/custom/
└── my-team-standards.md
```

Load both:
```
1. ai-contexts/contexts/master-context.md
2. ai-contexts/contexts/custom/my-team-standards.md
```

### How many contexts should I load?

**Always:**
- master-context.md
- code-workflow.md

**As needed (2-3 max):**
- Module-specific contexts
- Tech stack contexts
- Domain contexts

**Total:** 3-5 contexts per session. More dilutes focus.

### Do contexts work for Python/Java/Go?

The existing contexts are JavaScript/TypeScript focused, but the principles apply to any language.

**To adapt:**
1. Copy a context
2. Replace examples with your language
3. Update patterns for your ecosystem
4. Share back to the project!

---

## Team & Collaboration

### How do multiple developers use this together?

**Each developer:**
1. Installs system in project (`ai-contexts/`)
2. Commits their project plans to git
3. References plans in PRs
4. Reviews completed work from teammates

**Benefits:**
- Consistent code across team
- Easy to pick up someone else's work
- Shared knowledge in project plans

### Can someone else continue my task?

Yes! That's a key feature:

```
Developer A:
1. TASK START HPP-123 user-auth
2. Creates project plan
3. Completes Phase 1
4. Commits project plan (50% complete)

Developer B:
1. Reads project plan
2. Sees Phase 1 done, Phase 2-3 pending
3. Continues with Phase 2
4. Updates checkboxes
```

### How do we share team-specific standards?

Create team contexts:

```
ai-contexts/contexts/custom/
├── team-code-style.md
├── team-testing-standards.md
└── team-api-patterns.md
```

Commit to git, everyone uses them.

### Should we commit ai-contexts/ to git?

**Two approaches:**

**Approach 1: Commit Everything (Recommended)**
```
git add ai-contexts/
git commit -m "Add AI workflow system"
```
- ✅ Everyone has same version
- ✅ Team contexts shared automatically
- ✅ Project plans preserved

**Approach 2: Gitignore ai-contexts/ (Each developer installs separately)**
```
# .gitignore
ai-contexts/
```
- ✅ Lighter repo
- ❌ Need to install separately
- ❌ Team contexts not shared

Most teams choose Approach 1.

### Do we commit project plans?

**Yes!** Project plans are valuable documentation:

```
git add ai-contexts/project-plans/active/
git add ai-contexts/project-plans/completed/
git commit -m "Add project plan for user authentication"
```

Benefits:
- Permanent record of decisions
- Easy PR reviews
- Historical reference
- Onboarding resource

---

## Troubleshooting

### AI isn't creating project plans

**Cause:** AI hasn't learned the workflow.

**Fix:**
```
👤 Please read these files:
   1. ai-contexts/contexts/master-context.md
   2. ai-contexts/contexts/code-workflow.md

These teach you our two-phase workflow.
Once you've read them, help me with: TASK START {ticket} {desc}
```

### AI starts coding immediately instead of waiting for approval

**Cause:** AI didn't learn approval checkpoint requirement.

**Reminder:**
```
👤 STOP. You must wait for my approval before implementing.
   Review code-workflow.md section on "Mandatory Approval Checkpoints."
   Show me the project plan and wait for my approval.
```

### Template not showing up

**Check:**
1. File is in `ai-contexts/templates/v1/`
2. File ends with `-session.md`
3. File follows template structure

### Context not being applied

**Verify:**
1. You asked AI to read the context file
2. File path is correct
3. AI confirmed it read the file

**Test:**
```
👤 What did you learn from component-context.md?
```

### Project plan checkboxes not updating

**Manual update:**
1. Open project plan file
2. Change `- [ ]` to `- [x]` for completed tasks
3. Save file

**AI should do this automatically**, but you can update manually if needed.

---

## Advanced Usage

### Can I use this with CI/CD?

Yes! Some ideas:

**Pre-commit hook:**
```bash
# Check if project plan exists for ticket
if ! find ai-contexts/project-plans -name "*${TICKET}*" ; then
  echo "Error: No project plan found for ${TICKET}"
  exit 1
fi
```

**PR validation:**
```yaml
# .github/workflows/validate-pr.yml
- name: Check for project plan
  run: |
    TICKET=$(echo ${{ github.event.pull_request.title }} | grep -oP '\w+-\d+')
    if [ ! -f ai-contexts/project-plans/*/${TICKET}* ]; then
      echo "Missing project plan for ${TICKET}"
      exit 1
    fi
```

### Can I automate template selection?

Create a wrapper script:

```bash
#!/bin/bash
# ai-task-helper.sh

TASK_TYPE=$1
TICKET=$2
DESC=$3

case $TASK_TYPE in
  feature)
    TEMPLATE="feature-development-session.md"
    ;;
  bug)
    TEMPLATE="debugging-session.md"
    ;;
  db)
    TEMPLATE="database-schema-session.md"
    ;;
esac

cp ai-contexts/templates/v1/$TEMPLATE ai-contexts/wip/$TICKET-$DESC.md
echo "Template ready: ai-contexts/wip/$TICKET-$DESC.md"
```

Usage:
```bash
./ai-task-helper.sh feature HPP-123 user-auth
```

### Can I track metrics across projects?

Create a metrics aggregation script:

```bash
#!/bin/bash
# aggregate-metrics.sh

echo "Project Plans Created: $(find ai-contexts/project-plans -name '*.md' | wc -l)"
echo "Completed This Month: $(find ai-contexts/project-plans/completed/$(date +%Y-%m) -name '*.md' | wc -l)"
echo "Active Tasks: $(find ai-contexts/project-plans/active -name '*.md' | wc -l)"
```

### Can this integrate with ticket system (JIRA, Linear, GitHub Issues)?

Not directly yet (planned for v2.0), but you can:

1. Use ticket IDs in filenames
2. Reference plans in JIRA comments
3. Create automation to update JIRA when plan completes

---

## Questions Not Answered Here?

- 📖 Check [Troubleshooting Guide](troubleshooting.md)
- 💬 Ask in [GitHub Discussions](https://github.com/tichaonax/ai-dev-workflow/discussions)
- 🐛 Report bugs in [GitHub Issues](https://github.com/tichaonax/ai-dev-workflow/issues)

---

[Back to README](../README.md) | [Troubleshooting](troubleshooting.md) | [Quick Start](quick-start.md)
