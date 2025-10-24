# Session Restoration & Team Handoff Workflow

> **Critical Feature:** Resume AI work after interruptions, computer shutdown, or team handoffs

---

## 🎯 Problem Statement

### Common Scenarios

**Scenario 1: Daily Work Interruption**
```
Day 1, 5:00 PM: AI is 50% through implementing a feature
                Computer shuts down for the day
Day 2, 9:00 AM: Open VS Code - AI has no context
                Need to restore: commands, progress, current task
```

**Scenario 2: Team Handoff**
```
Developer A: Starts feature, completes 3 of 5 phases
             Goes on vacation, pushes code to git
Developer B: Pulls code, opens VS Code
             AI has no idea where Developer A left off
             Needs: commands, requirements, plan, current progress
```

**Scenario 3: Multi-Day Projects**
```
Monday:    AI creates plan, implements Phase 1 and 2
Tuesday:   AI has no memory of Monday's work
           Needs to understand what's done, what's next
```

---

## ✅ Solution: RESUME Command

A single command that bootstraps AI with full context and continues work exactly where it left off.

### What RESUME Does

```
User: RESUME

AI Actions:
1. ✅ Relearn all workflow commands (master-context.md, code-workflow.md)
2. ✅ Find active project plan in project-plans/active/
3. ✅ Read requirements from wip/ folder
4. ✅ Analyze completed tasks (checked [x] boxes)
5. ✅ Identify current task (first unchecked [ ] box)
6. ✅ Review recent git commits for context
7. ✅ Present status summary and ask how to proceed
```

---

## 📋 RESUME Command Specification

### Command Syntax

```bash
RESUME                           # Resume most recent active project
RESUME {ticket}                  # Resume specific project by ticket
RESUME {project-plan-filename}   # Resume by exact filename
```

### AI Response Format

```markdown
🔄 Resuming AI Development Session...

📚 Loading Contexts:
✅ master-context.md - Workflow commands loaded
✅ code-workflow.md - Development process loaded
✅ [Custom contexts loaded based on project type]

📋 Active Project Plan:
📁 projectplan-TICKET-123-user-auth-2025-10-24.md
🎯 Feature: User authentication with JWT tokens
📅 Started: 2025-10-24 09:00 AM
📅 Last updated: 2025-10-24 16:45 PM

📝 Requirements Context:
📁 wip/TICKET-123-user-auth.md
🔄 Sync Status: IN SYNC (last synced: 2025-10-24 10:25 AM)

📊 Progress Summary:
✅ Phase 1: Database Schema (COMPLETE - 5/5 tasks)
✅ Phase 2: Authentication Endpoints (COMPLETE - 6/6 tasks)
🔄 Phase 3: JWT Token Management (IN PROGRESS - 2/4 tasks)
   ✅ Task 3.1: Implement JWT token generation
   ✅ Task 3.2: Add token expiration logic
   ⏳ Task 3.3: Create token refresh endpoint (NEXT)
   ⏸️ Task 3.4: Add token validation middleware
⏸️ Phase 4: Testing (NOT STARTED - 0/3 tasks)

📂 Files Modified (from git log):
- src/models/User.ts (created)
- src/routes/auth.ts (created)
- src/middleware/auth.ts (modified)
- src/utils/jwt.ts (created)

💻 Last Commit:
e716ac8 - "feat: Implement JWT token generation and expiration"
Author: Developer A
Date: 2025-10-24 16:45 PM

🎯 Current Status:
Phase 3 is 50% complete (2/4 tasks done)
Next task: Task 3.3 - Create token refresh endpoint

🔍 Code Context:
I can see you've implemented:
- User model with password hashing
- Login/register endpoints with validation
- JWT token generation with 24-hour expiration

Ready to continue with Task 3.3 (token refresh endpoint).

---

✅ Session restored! I'm up to date with your progress.

How would you like to proceed?
1. Continue with Task 3.3 (token refresh endpoint)
2. Review what's been done so far
3. Make changes to the plan
4. Run tests on completed work

Type: CONTINUE, REVIEW, REPLAN, or TEST
```

---

## 🎬 Complete Workflow Examples

### Example 1: Daily Work Resume (Same Developer)

**End of Day 1:**
```
Developer: [Working with AI, completes Phase 1 and 2]
Developer: [Computer shuts down at 5 PM]
```

**Start of Day 2:**
```
Developer: [Opens VS Code, starts new chat with AI]
Developer: RESUME

AI: 🔄 Resuming AI Development Session...
    [Shows complete status as above]
    ✅ Session restored! Ready to continue with Phase 3, Task 3.3.

Developer: CONTINUE

AI: 🔧 Continuing with Task 3.3: Create token refresh endpoint...
    [Implements the task]
```

### Example 2: Team Handoff (Different Developers)

**Developer A (Before Vacation):**
```
Developer A: [Completes Phase 1, 2, and half of Phase 3]
Developer A: TASK UPDATE
Developer A: git add . && git commit -m "feat: Implement user auth Phases 1-2, partial Phase 3"
Developer A: git push origin feature/user-auth
Developer A: [Goes on vacation]
```

**Developer B (Taking Over):**
```
Developer B: git pull origin feature/user-auth
Developer B: git checkout feature/user-auth
Developer B: [Opens VS Code, starts chat with AI]
Developer B: RESUME TICKET-123

AI: 🔄 Resuming AI Development Session...

    📋 Active Project Plan:
    📁 projectplan-TICKET-123-user-auth-2025-10-24.md

    👤 Previous Developer: Developer A (last commit: 2025-10-24)
    👤 Current Developer: Developer B (taking over)

    📊 Progress Summary:
    ✅ Phase 1: Database Schema (COMPLETE)
    ✅ Phase 2: Authentication Endpoints (COMPLETE)
    🔄 Phase 3: JWT Token Management (IN PROGRESS - 2/4 tasks)
       ⏳ Task 3.3: Create token refresh endpoint (NEXT)

    🎯 Handoff Notes:
    Developer A left off at Task 3.3 (token refresh endpoint).
    All tests passing for completed phases.
    No blockers noted in plan.

    ✅ Session restored! Ready for you to continue where Developer A left off.

Developer B: Show me the implementation so far

AI: 📂 Current Implementation Review:
    [Shows code snippets from completed tasks]
    [Explains architectural decisions]
    [Points out any TODOs or notes]

Developer B: CONTINUE

AI: 🔧 Continuing with Task 3.3: Create token refresh endpoint...
```

### Example 3: Multi-Day Complex Project

**Monday:**
```
Developer: TASK START PROJECT-456 payment-gateway-integration
Developer: [Fills requirements]
Developer: START
AI: [Creates plan with 8 phases, 45 tasks, estimated 5 days]
Developer: [Completes Phase 1 and 2]
Developer: TASK UPDATE
Developer: [End of day]
```

**Tuesday:**
```
Developer: RESUME

AI: 🔄 Resuming AI Development Session...
    📋 Project: Payment Gateway Integration
    📊 Progress: 22% (10/45 tasks complete)
    🎯 Current: Phase 3 - API Integration
    ⏳ Next: Task 3.1 - Set up Stripe SDK

Developer: CONTINUE
```

**Friday:**
```
Developer: RESUME

AI: 🔄 Resuming AI Development Session...
    📊 Progress: 95% (43/45 tasks complete)
    🎯 Current: Phase 8 - Final Testing
    ⏳ Only 2 tasks remaining!

Developer: CONTINUE
```

---

## 🔧 Implementation Details

### Project Plan Enhancement

Add session tracking section to project plans:

```markdown
## Session Tracking

**Created:** 2025-10-24 09:00 AM
**Last Updated:** 2025-10-24 16:45 PM
**Status:** IN PROGRESS

**Developers:**
- Developer A (2025-10-24 09:00 - 16:45)

**Sessions:**
1. Session 1: 2025-10-24 09:00-12:00 (Phases 1-2 completed)
2. Session 2: 2025-10-24 13:00-16:45 (Phase 3 started, 2/4 tasks done)

**Current Task:** Phase 3, Task 3.3 - Create token refresh endpoint

**Next Session:** Continue with Task 3.3
```

### Git Integration

RESUME command analyzes git history:

```bash
# AI runs these commands internally:
git log --oneline -10 --author="*" -- [files-in-plan]
git diff HEAD~5..HEAD -- [files-in-plan]
git status
```

### Context Loading Priority

1. **Core Contexts** (Always load):
   - `master-context.md` - Commands
   - `code-workflow.md` - Process

2. **Project-Specific Contexts** (Auto-detect from plan):
   - If plan mentions "API endpoints" → load `backend-api-context.md`
   - If plan mentions "React components" → load `component-context.md`
   - If plan mentions "database" → load `database-schema-context.md`

3. **Requirements & Plan**:
   - `wip/{ticket}-{description}.md` - Requirements
   - `project-plans/active/projectplan-{ticket}-*.md` - Current plan

---

## 📝 RESUME Command Definition (for master-context.md)

```markdown
### `RESUME`
**Purpose:** Restore AI session and continue work from where it left off
**When:** Start of new day, after interruption, or team handoff

**AI Actions:**
1. Load core contexts: master-context.md, code-workflow.md
2. Find active project plan in `ai-contexts/project-plans/active/`
3. Read requirements from `ai-contexts/wip/`
4. Analyze project plan checkboxes ([x] completed, [ ] pending)
5. Identify current phase and next task
6. Review recent git commits (last 10 commits on related files)
7. Review git diff to understand recent changes
8. Auto-detect and load relevant contexts based on project type
9. Check requirements-plan sync status
10. Present comprehensive status summary
11. Ask user how to proceed (CONTINUE, REVIEW, REPLAN, TEST)

**Optional Parameters:**
- `RESUME {ticket}` - Resume specific project by ticket number
- `RESUME {filename}` - Resume by exact project plan filename

**Example Response:**
```
🔄 Resuming AI Development Session...

📚 Contexts Loaded:
✅ master-context.md
✅ code-workflow.md
✅ backend-api-context.md (auto-detected)

📋 Active Project: TICKET-123 User Authentication
📊 Progress: 60% (12/20 tasks)
🎯 Current Phase: Phase 3 - JWT Implementation
⏳ Next Task: Task 3.3 - Create token refresh endpoint

✅ Session restored! Ready to continue.

Type: CONTINUE, REVIEW, REPLAN, or TEST
```

**If Multiple Active Projects:**
```
🔄 Multiple active projects found:

1. 📋 projectplan-TICKET-123-user-auth-2025-10-24.md
   📊 Progress: 60% (12/20 tasks)
   📅 Last updated: 2025-10-24 16:45 PM

2. 📋 projectplan-TICKET-456-payment-gateway-2025-10-23.md
   📊 Progress: 25% (5/20 tasks)
   📅 Last updated: 2025-10-23 17:30 PM

Which project would you like to resume? (1 or 2)
Or type: RESUME TICKET-123
```
```
---

## 🎨 VS Code Snippet

```json
{
  "resume-session": {
    "prefix": "resume",
    "description": "Resume AI session and continue work",
    "body": [
      "RESUME",
      "",
      "Please:",
      "1. Load core contexts (master-context.md, code-workflow.md)",
      "2. Find active project plan in ai-contexts/project-plans/active/",
      "3. Read requirements from ai-contexts/wip/",
      "4. Analyze completed vs pending tasks",
      "5. Review recent git commits for context",
      "6. Present status summary with next task",
      "7. Ask how to proceed (CONTINUE, REVIEW, REPLAN, TEST)"
    ]
  },

  "resume-specific": {
    "prefix": "resume-ticket",
    "description": "Resume specific project by ticket",
    "body": [
      "RESUME ${1:TICKET-123}",
      "",
      "Please restore this specific project and show status."
    ]
  }
}
```

---

## 🤝 Team Handoff Best Practices

### For Developer Handing Off

**Before leaving:**

1. ✅ Update project plan checkboxes (TASK UPDATE)
2. ✅ Commit all work with descriptive messages
3. ✅ Push to git remote
4. ✅ Add handoff notes to project plan (optional):

```markdown
## Handoff Notes (Developer A → Developer B)

**Date:** 2025-10-24
**Handoff From:** Developer A
**Handoff To:** Developer B

**Status:**
- Completed Phases 1-2 (all tests passing)
- Started Phase 3 (2/4 tasks done)
- Next: Task 3.3 - Create token refresh endpoint

**Important Notes:**
- Used bcrypt rounds=10 for password hashing (documented in requirements)
- JWT tokens expire in 24 hours (configurable in .env)
- Rate limiting implemented: 5 failed attempts = 15min lockout

**Blockers:** None

**Questions for Next Developer:**
- Should we add refresh token rotation?
- OAuth integration priority?
```

### For Developer Taking Over

**When starting:**

1. ✅ Pull latest code: `git pull origin feature/branch`
2. ✅ Open VS Code in project root
3. ✅ Start AI chat and type: `RESUME TICKET-123`
4. ✅ AI loads everything and shows status
5. ✅ Type `REVIEW` to understand what's been done
6. ✅ Type `CONTINUE` to resume work

---

## 🔄 Related Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| `RESUME` | Restore session | New AI session, handoff |
| `TASK STATUS` | Check progress | During active session |
| `PLAN STATUS` | Check sync status | Before continuing work |
| `REVIEW` | Understand completed work | After RESUME, before continuing |
| `CONTINUE` | Proceed with next task | After RESUME, ready to code |

---

## 💡 Pro Tips

### For Solo Developers

- ✅ Run `RESUME` at start of each day
- ✅ Keeps AI aligned with your progress
- ✅ No need to explain what you did yesterday

### For Teams

- ✅ Always commit before handoff
- ✅ Run `TASK UPDATE` before leaving
- ✅ Add handoff notes in project plan (optional but helpful)
- ✅ New developer just types `RESUME {ticket}`

### For Long Projects

- ✅ `RESUME` works after weeks/months
- ✅ AI reads all checkboxes and git history
- ✅ Provides accurate status no matter how long ago

---

## 🎯 Benefits

### For Individual Developers

✅ **No Context Loss**: AI remembers everything from checkboxes and git
✅ **Fast Startup**: One command instead of explaining history
✅ **Accurate Status**: AI knows exactly what's done and what's next

### For Teams

✅ **Seamless Handoffs**: Developer B picks up exactly where Developer A left off
✅ **No Knowledge Loss**: All context in git + project plan
✅ **Parallel Work**: Multiple developers can resume different projects

### For Projects

✅ **Long-Running Projects**: Resume after days, weeks, or months
✅ **Multi-Session Continuity**: Works across any number of sessions
✅ **Historical Context**: AI reviews git commits for full picture

---

## 🚀 Quick Reference

```bash
# Start new day
RESUME                    # AI finds active project, shows status

# Team handoff
RESUME TICKET-123        # AI loads specific project by ticket

# After reviewing status
CONTINUE                 # Resume implementation
REVIEW                   # Review completed work first
REPLAN                   # Make changes to plan
TEST                     # Run tests on completed work

# Multiple projects
RESUME                   # Shows list of active projects
RESUME projectplan-TICKET-456-*.md  # Resume specific file
```

---

## 📊 Success Metrics

Track handoff effectiveness:

**Before RESUME Command:**
- ⏱️ 30-60 minutes explaining context to AI
- ❌ Risk of missing details
- ❌ Manual review of all completed work

**After RESUME Command:**
- ⏱️ 30 seconds to restore full context
- ✅ AI reads checkboxes + git automatically
- ✅ Complete and accurate status

---

[Back to README](../README.md) | [Workflow Commands](../contexts/workflow-commands-reference.md)
