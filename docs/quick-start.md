# Quick Start Guide

**Get up and running with AI-Assisted Development Workflow in 5 minutes**

---

## 🎯 What You'll Learn

By the end of this guide (5 minutes), you'll:
- ✅ Understand the core workflow
- ✅ Know which files to use
- ✅ Complete your first AI-assisted task
- ✅ See immediate results

---

## 📋 Prerequisites

- ✅ An AI coding assistant (GitHub Copilot, Claude, ChatGPT, Cursor, etc.)
- ✅ A task you want to work on (feature, bug, refactor, etc.)
- ✅ 5 minutes of focused time

---

## 🚀 5-Minute Quick Start

### Step 1: Choose Your Template (30 seconds)

Pick the template that matches your work:

| Task Type | Template File |
|-----------|---------------|
| 🆕 **New feature** | `templates/v1/feature-development-session.md` |
| 🐛 **Bug fix** | `templates/v1/debugging-session.md` |
| ♻️ **Refactoring** | `templates/v1/refactor-optimization-session.md` |
| 🗄️ **Database** | `templates/v1/database-schema-session.md` |
| 🔌 **API** | `templates/v1/api-endpoint-session.md` |
| 🎨 **Design/UI** | `templates/v1/design-review-session.md` |
| 📝 **Documentation** | `templates/v1/documentation-session.md` |
| 🔒 **Security** | `templates/v1/security-review-session.md` |
| 🔍 **Exploration** | `templates/v1/init-session.md` |

**Not sure?** Use the template selector:
```bash
./tools/select-template.sh
```

---

### Step 2: Train Your AI (First Time Only) (2 minutes)

**🚨 Important:** AI assistants only learn workflow commands AFTER reading context files.

**Copy this message to your AI:**
```
👋 Hi! Please read these files to learn our development workflow:

📖 ai-contexts/contexts/master-context.md (workflow commands)
📖 ai-contexts/contexts/code-workflow.md (coding standards)

After reading them, you'll know the two-phase workflow:
- TASK START <ticket> <description> (setup & template selection)
- START (begin work after filling requirements)
- TASK STATUS, TASK UPDATE, TASK COMPLETE
- MOVE USER CONTEXT
- SHOW COMMANDS (list all available commands)

Ready to help with my task!
```

**💡 Pro Tip:** After training, type `SHOW COMMANDS` to see all available workflow commands anytime!

**Alternative:** Use VS Code snippets - type `task-start` + Tab for instant commands.

---

### Step 3: Read Core Contexts (30 seconds)

Quickly scan these files (AI will read them fully):

1. **`contexts/master-context.md`** (1 minute)
   - Core operating principles
   - What makes this different
   - Why it works

2. **`contexts/code-workflow.md`** (1 minute)
   - The workflow steps
   - Approval gates
   - What to expect

> 💡 **Tip:** You don't need to memorize them—just get familiar with the structure.

---

### Step 3: Fill Your Template (2 minutes)

Open your chosen template and fill in the sections:

**Example: Feature Development**

```markdown
## 📋 Feature Overview

**Feature Name:** User profile page
**JIRA Ticket:** HPP-1234
**Description:** Add a page where users can view/edit their profile

## 🎯 Objectives
- Display user information
- Allow editing name and email
- Save changes to backend

## 📁 Files Likely Affected
- `src/pages/ProfilePage.jsx` (new)
- `src/api/userApi.js` (update)
```

**Fill out just enough** to give AI context—you don't need every detail.

---

### Step 4: Start Your AI Session (30 seconds)

Copy this prompt to your AI assistant:

```
I need to work on a task. Please read the following contexts in this EXACT order:

1. FIRST: ai-contexts/contexts/master-context.md
2. SECOND: ai-contexts/contexts/code-workflow.md
3. THIRD: [path to your filled template]

After reading, create a detailed project plan following the workflow requirements.
Wait for my approval before making any code changes.
```

---

### Step 5: Review & Approve (ongoing)

The AI will:

1. **Read your contexts** ✅
2. **Create a project plan** with phases ✅
3. **WAIT for your approval** ⏸️

**You review the plan:**
- ✅ Does it make sense?
- ✅ Are the phases logical?
- ✅ Any missing considerations?

**Then approve or request changes:**
```
"Looks good! Proceed with Phase 1"
```

**AI implements Phase 1, shows results, waits again** ⏸️

**You review implementation:**
- ✅ Code quality good?
- ✅ Follows patterns?
- ✅ Tests included?

**Approve next phase:**
```
"Phase 1 approved. Proceed with Phase 2"
```

**Repeat until complete!** 🎉

---

## 📊 What to Expect

### ✅ Good Signs You'll See

1. **AI Creates Detailed Plans**
   - Breaks work into phases
   - Considers edge cases
   - Plans tests and documentation

2. **AI Waits for Approval**
   - Doesn't rush ahead
   - Shows work before continuing
   - Asks questions when unclear

3. **Incremental Progress**
   - Small, reviewable changes
   - Clear checkpoints
   - Easy to course-correct

4. **Complete Documentation**
   - Session document captures decisions
   - Code comments explain why
   - Living record of the work

---

## 🎯 Your First Session

**Try this simple task to get familiar:**

### Example: Add a Helper Function

**Template:** `init-session.md`

**Fill in:**
```markdown
## Task
Add a helper function to format currency values

## Context
- File: src/utils/formatters.js
- Should handle USD, EUR, GBP
- Include tests

## Success Criteria
- Function works for all currencies
- Tests pass
- Documentation added
```

**Prompt AI:**
```
Read:
1. ai-contexts/contexts/master-context.md
2. ai-contexts/contexts/code-workflow.md
3. [your filled template]

Create a plan for this task.
```

**AI will:**
1. Create a simple plan (maybe 2 phases)
2. Wait for your approval
3. Implement incrementally
4. Complete with tests and docs

**Time:** ~10-15 minutes total  
**Result:** Perfect helper function + documentation

---

## 💡 Pro Tips

### Do's ✅

- ✅ **Fill templates before starting** - Helps AI understand context
- ✅ **Review every approval checkpoint** - Catch issues early
- ✅ **Keep session documents** - Great reference later
- ✅ **Start small** - Build confidence with simple tasks first
- ✅ **Use examples** - Check `examples/` folder for reference

### Don'ts ❌

- ❌ **Don't skip context loading** - AI needs the contexts first
- ❌ **Don't rush approvals** - Quick review saves hours later
- ❌ **Don't skip templates** - They ensure consistency
- ❌ **Don't work without checkpoints** - Incremental is better
- ❌ **Don't forget documentation** - Future you will thank you

---

## 🎓 Learning Path

### Level 1: Beginner (Week 1)
- ✅ Complete 2-3 simple tasks
- ✅ Get comfortable with templates
- ✅ Understand approval checkpoints

### Level 2: Intermediate (Week 2-3)
- ✅ Try different template types
- ✅ Customize contexts for your project
- ✅ Add project-specific patterns

### Level 3: Advanced (Month 1+)
- ✅ Create custom templates
- ✅ Train team members
- ✅ Share success stories

---

## 📚 Next Steps

Now that you've completed your first session:

1. **Read full documentation:**
   - [Core Concepts](concepts.md) - Understand the "why"
   - [Best Practices](best-practices.md) - Level up your workflow
   - [Customization](customization.md) - Make it yours

2. **Explore examples:**
   - `examples/feature-development/` - See complete feature workflow
   - `examples/debugging/` - Learn debugging approach
   - `examples/refactoring/` - Study refactoring patterns

3. **Try more templates:**
   - Use debugging template for next bug
   - Try refactoring template for code cleanup
   - Use API template for endpoint work

4. **Share with team:**
   - Show results to teammates
   - Help others get started
   - Collect feedback and improve

---

## 🆘 Need Help?

### Common Issues

**"AI isn't following the workflow"**
- Make sure contexts loaded in correct order
- Check that master-context.md loaded FIRST
- Remind AI: "Please follow the workflow with approval gates"

**"Not sure which template to use"**
- Run `./tools/select-template.sh`
- Check examples folder for similar work
- When in doubt, use `init-session.md`

**"Template feels too detailed"**
- Fill what you know, skip what you don't
- AI will ask questions if it needs more
- Start minimal, add details as needed

**"AI is making changes without approval"**
- Stop and remind: "Please wait for approval after showing plan"
- Re-load code-workflow.md: "Read ai-contexts/contexts/code-workflow.md again"
- Be explicit: "STOP. Wait for my approval before coding."

### Get More Help

- 📖 [FAQ](faq.md) - Common questions answered
- 🔧 [Troubleshooting](troubleshooting.md) - Fix specific issues
- 💬 [Discussions](https://github.com/tichaonax/ai-dev-workflow/discussions) - Ask the community
- 🐛 [Issues](https://github.com/tichaonax/ai-dev-workflow/issues) - Report problems

---

## ✅ Quick Start Checklist

- [ ] Chose appropriate template
- [ ] Read master-context.md (1 min)
- [ ] Read code-workflow.md (1 min)
- [ ] Filled template with task details
- [ ] Started AI session with correct prompt
- [ ] AI created project plan
- [ ] Reviewed and approved plan
- [ ] AI implemented incrementally
- [ ] Reviewed each phase before approval
- [ ] Completed with documentation
- [ ] Saved session document for reference

---

## 🎉 Success!

You've completed your first AI-assisted workflow session!

**You should now have:**
- ✅ Working code that follows your patterns
- ✅ Complete documentation of the work
- ✅ Tests (if applicable)
- ✅ Confidence in the approach

**What's different from before:**
- ❌ No more "just start coding" and hope for the best
- ❌ No more AI making wrong assumptions
- ❌ No more hours of debugging AI mistakes
- ❌ No more missing documentation

**Instead:**
- ✅ Structured, planned approach
- ✅ AI understands your context
- ✅ Approval gates catch issues early
- ✅ Living documentation automatically created

---

**Ready for more?** Pick your next task and let's go! 🚀

[Installation Guide](installation.md) | [Core Concepts](concepts.md) | [Best Practices](best-practices.md) | [Examples](../examples/)
