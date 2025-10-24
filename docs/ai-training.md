# AI Training & Bootstrapping Guide

**How to teach AI assistants the workflow commands for the first time**

---

## 🔄 The Bootstrapping Challenge

When using this workflow system, there's a natural "chicken and egg" problem:

- 🤖 **AI needs to know workflow commands** to use the system effectively
- 📚 **Commands are defined in `master-context.md`** 
- 🔍 **AI only learns them AFTER reading the context file**

**Question:** How do you teach the AI the first time?

---

## 💡 Solutions for First-Time Training

### 🥇 Method 1: Manual Context Loading (Recommended)

**Best for:** First time setup, comprehensive training

Copy this message to your AI assistant:

```
👋 Hi! Please read these files to learn our AI development workflow:

📖 ai-contexts/contexts/master-context.md
📖 ai-contexts/contexts/code-workflow.md
📖 ai-contexts/custom/*.md (if any team-specific contexts exist)

These files teach you:
- RESUME: Continue existing work after interruptions/handoffs
- TASK START: Begin new feature or task
- START: Create project plan and begin implementation
- Approval checkpoints and project plan tracking
- Team-specific standards and conventions (from custom/)

What would you like to do?
• RESUME - Continue existing work
• TASK START <ticket> <description> - Start new work
```

**Why this works:**
- ✅ AI learns complete workflow in one session
- ✅ Works for both NEW work and RESUMING work
- ✅ Gets full context about your standards
- ✅ Remembers commands for entire conversation
- ✅ Can immediately use all workflow features (RESUME, TASK START, SYNC REQUIREMENTS, etc.)

---

### 🥈 Method 2: VS Code Snippets (Instant Access)

**Best for:** Quick access, experienced users

The workflow includes pre-configured VS Code snippets:

| Snippet | Expands To | Usage |
|---------|------------|-------|
| `taskstart` | Full TASK START command structure | Beginning a new task |
| `taskstatus` | TASK STATUS command | Checking progress |
| `taskupdate` | TASK UPDATE command | Marking progress |
| `taskcomplete` | TASK COMPLETE command | Finishing a task |
| `movecontext` | MOVE USER CONTEXT command | Archiving context |
| `taskdryrun` | Dry-run variants | Testing commands |

**How to use:**
1. Type snippet name (e.g., `taskstart`)
2. Press Tab
3. Fill in the placeholders
4. Send to AI

**Example:**
```
Type: taskstart + Tab
Expands to: TASK START ${1:TICKET-ID} ${2:short-description}

Based on user context: ${3:context-file}

Please create a detailed project plan for this ${4:feature/bug/refactor} that includes:
- Comprehensive task breakdown
- Clear success criteria  
- Files that need modification
- Implementation phases with approval checkpoints
- Risk assessment and mitigation strategies
```

---

### 🥉 Method 3: Command Reference Card

**Best for:** Copy-paste convenience, team onboarding

Keep this reference handy:

```bash
# Essential Workflow Commands (copy-paste ready)

# Start a new task
TASK START <ticket-id> <short-description>

# Check task progress  
TASK STATUS

# Update task progress (after marking checkboxes)
TASK UPDATE

# Complete and archive task
TASK COMPLETE

# Archive user context file
MOVE USER CONTEXT

# Shell script commands (with safety)
./tools/ai-task-status          # View progress
./tools/ai-task-complete --yes  # Archive project  
./tools/ai-move-context --yes   # Move context
```

---

### 🚀 Method 4: Progressive Training

**Best for:** Learning the system gradually

**Session 1: Template Selection**
```
Hi! I'm using an AI development workflow. For now, just help me with:

TASK START PROJECT-123 user-authentication

(AI shows template selection menu, creates context file)
```

**Session 2: Add Full Context**
```
Please read ai-contexts/contexts/master-context.md to learn our full workflow commands.

I've filled in my requirements. Now: START
```

**Session 3: Full Integration**
```
Read ai-contexts/contexts/code-workflow.md for coding standards.

Ready for full workflow integration!
```

---

## 🎯 Training Verification

After training, verify the AI learned correctly:

### ✅ Test Two-Phase Workflow Understanding
```
You: TASK START ABC-123 login-system
AI: Should show template selection menu, NOT create project plan immediately
```

### ✅ Test Template Selection
```
AI Response should include: "Available Templates:" and numbered list
AI should ask: "Which template would you like to use?"
```

### ✅ Test Requirements Phase
```
After template selection, AI should:
- Create/show context file for editing
- Tell you to fill in requirements
- Say "Type START when ready"
- NOT create project plan yet
```

### ✅ Test Execution Phase
```
You: START
AI: Should read context file and create detailed project plan
```

### ✅ Test Progress Commands
```
You: TASK STATUS
AI: Should show progress tracking, not ask "what do you mean?"
```

---

## 🔧 Troubleshooting Training Issues

### 🚨 AI Doesn't Recognize Commands

**Symptoms:**
- AI responds "I don't understand TASK START"
- AI asks for clarification on workflow commands
- AI jumps straight to coding without planning

**Solutions:**
1. ✅ Explicitly ask AI to read `master-context.md`
2. ✅ Use VS Code snippets to provide full command structure
3. ✅ Copy-paste command examples from this guide

### 🚨 AI Ignores Workflow Structure

**Symptoms:**
- AI creates code without project plans
- AI skips approval checkpoints  
- AI doesn't mention TASK STATUS or progress tracking

**Solutions:**
1. ✅ Ensure AI read `code-workflow.md`
2. ✅ Remind AI: "Follow the workflow process, don't skip planning"
3. ✅ Use explicit commands: "TASK START first, then create plan"

### 🚨 AI Forgets Commands Mid-Session

**Symptoms:**
- AI knew commands earlier but now doesn't
- AI reverts to basic coding responses
- Workflow structure breaks down

**Solutions:**
1. ✅ Remind AI: "Remember our workflow commands from master-context.md"
2. ✅ Re-paste key command structures
3. ✅ Start new session with full context loading

---

## 📚 Training Resources

### For Team Onboarding
- **[Quick Start Guide](quick-start.md)** - 5-minute introduction
- **[VS Code Snippets](../integrations/vscode/ai-workflow-commands.code-snippets)** - Ready-to-use snippets
- **[Command Reference](../contexts/master-context.md)** - Complete command definitions

### For Advanced Users  
- **[Workflow Customization](customization.md)** - Adapt commands to your needs
- **[Context Creation](concepts.md#creating-contexts)** - Add new context documents
- **[Shell Script Reference](../tools/)** - Direct tool usage

---

## 🎯 Success Indicators

You've successfully trained your AI when:

- ✅ AI consistently recognizes all workflow commands
- ✅ AI creates project plans before coding
- ✅ AI suggests using TASK STATUS for progress tracking
- ✅ AI follows approval checkpoints and safety measures
- ✅ AI maintains workflow structure throughout sessions

**Remember:** Once trained in a session, AI retains knowledge for that entire conversation!

---

## 💡 Pro Tips

1. **Bookmark the training message** - Save the context loading message for quick reuse
2. **Use snippets for speed** - VS Code snippets are fastest for experienced users  
3. **Train incrementally** - You don't need full workflow knowledge for simple tasks
4. **Share with team** - Everyone can use the same training approach
5. **Update context files** - Keep `master-context.md` current as workflow evolves

---

*This guide solves the bootstrapping challenge so you can start using AI workflow commands immediately, even on the very first session.*