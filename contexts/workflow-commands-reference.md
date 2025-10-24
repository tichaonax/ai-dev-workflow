# AI Workflow Command Framework

This document defines standardized commands that users can give to AI to perform common workflow operations efficiently.

## 🎯 Command Philosophy

Instead of explaining the full workflow every time, users can use simple commands that AI understands and executes consistently. This makes the workflow faster and more predictable.

## 📋 Core Commands Reference

### **Session Management Commands**

#### `RESUME`
**Purpose:** Restore AI session after interruption, computer shutdown, or team handoff
**AI Actions:**
1. Load core contexts (`master-context.md`, `code-workflow.md`)
2. Find active project plan in `ai-contexts/project-plans/active/`
3. Read requirements context from `ai-contexts/wip/`
4. Analyze completed ([x]) vs pending ([ ]) tasks
5. Identify current phase and next task
6. Review recent git commits (last 10) for context
7. Auto-detect and load relevant contexts based on project type
8. Check requirements-plan sync status
9. Present comprehensive status summary
10. Ask how to proceed (CONTINUE, REVIEW, REPLAN, TEST)

**Variants:**
- `RESUME` - Resume most recent active project
- `RESUME {ticket}` - Resume specific project by ticket (e.g., `RESUME TICKET-123`)
- `RESUME {filename}` - Resume by exact project plan filename

**Example:**
```
User: "RESUME"
AI: 🔄 Resuming AI Development Session...

    📚 Contexts Loaded:
    ✅ master-context.md
    ✅ code-workflow.md
    ✅ backend-api-context.md (auto-detected)

    📋 Active Project: TICKET-123 User Authentication
    📊 Progress: 60% (12/20 tasks)
    🎯 Current Phase: Phase 3 - JWT Implementation
    ⏳ Next Task: Task 3.3 - Create token refresh endpoint

    ✅ Session restored! Ready to continue.

    How would you like to proceed?
    1. CONTINUE - Resume implementation
    2. REVIEW - Review completed work
    3. REPLAN - Make changes to plan
    4. TEST - Run tests on completed work
```

#### `CONTINUE`
**Purpose:** Resume implementation after RESUME command
**AI Actions:**
1. Identify next unchecked task from project plan
2. Execute that task (code, tests, documentation)
3. Update project plan checkboxes
4. Present work summary
5. Ask for approval before next task

#### `REVIEW`
**Purpose:** Review all completed work in detail
**AI Actions:**
1. List all completed tasks ([x] checkboxes)
2. Show code snippets from completed work
3. Explain architectural decisions made
4. Highlight any TODOs or notes
5. Present summary for user understanding

### **Task Management Commands**

#### `TASK START {ticket} {description}`
**Purpose:** Create new project plan and begin structured work
**AI Actions:**
1. Read user context file: `ai-contexts/wip/{ticket}-{description}.md` (if exists)
2. Create project plan: `ai-contexts/project-plans/active/projectplan-{ticket}-{description}-YYYY-MM-DD.md`
3. Include all 8 required sections:
   - Task Overview
   - Files Affected
   - Impact Analysis
   - To-Do Checklist (with [ ] checkboxes)
   - Risk Assessment
   - Testing Plan
   - Rollback Plan
   - Review Summary (placeholder)
4. Begin Phase 1 after plan creation
5. Confirm project plan created and location

**Example:**
```
User: "TASK START NOTKT tailwind-conversion"
AI: ✅ Created projectplan-NOTKT-tailwind-conversion-2025-10-21.md
    📁 Location: ai-contexts/project-plans/active/
    🎯 Ready to begin Phase 1: Analysis and Setup
```

#### `TASK UPDATE`
**Purpose:** Update project plan with current progress
**AI Actions:**
1. Mark completed tasks with [x]
2. Add any new tasks discovered during work
3. Update time estimates if scope changed
4. Note challenges, decisions, or blockers
5. Show updated progress percentage
6. Identify next 3 tasks to work on

#### `TASK COMPLETE`
**Purpose:** Finish current task and archive documentation
**AI Actions:**
1. Verify all checkboxes marked [x] in current project plan
2. Add review summary with lessons learned and metrics
3. Create folder: `ai-contexts/project-plans/completed/YYYY-MM/`
4. Move project plan from `active/` to `completed/YYYY-MM/`
5. Generate descriptive commit message based on completed work
6. Stage and commit: `git add ai-contexts/project-plans/completed/ && git commit -m "message"`
7. Provide completion summary with key metrics

#### `TASK STATUS`
**Purpose:** Show current progress and next steps
**AI Actions:**
1. Display current project plan name and location
2. Show completion progress: "X of Y tasks completed (Z%)"
3. List completed [x] tasks with brief descriptions
4. List pending [ ] tasks prioritized by importance
5. Estimate remaining work time
6. Highlight any blockers or dependencies
7. Suggest immediate next steps

### **Requirements-Plan Synchronization Commands**

#### `SYNC REQUIREMENTS`
**Purpose:** Update requirements context to match current project plan
**AI Actions:**
1. Read current project plan in `ai-contexts/project-plans/active/`
2. Extract all requirements, constraints, and implementation details from analysis
3. Update requirements context file in `ai-contexts/wip/`
4. Show diff of what was added/updated in requirements
5. Mark sync timestamp in both files
6. Confirm requirements now match project plan

**Example:**
```
User: "SYNC REQUIREMENTS"
AI: 📋 Syncing requirements with project plan...

    ✅ Added to requirements:
    - JWT token expiration: 24 hours
    - Password requirements: min 8 chars, 1 uppercase, 1 number
    - Rate limiting: 5 failed attempts = lockout

    ✅ Requirements now match project plan!
```

#### `REPLAN`
**Purpose:** Re-analyze requirements and update project plan
**AI Actions:**
1. Read updated requirements context from `ai-contexts/wip/`
2. Perform fresh impact analysis
3. Update project plan in `ai-contexts/project-plans/active/`
4. Show what changed (added tasks, updated estimates, new risks)
5. Mark as needing sync review
6. Recommend running SYNC REQUIREMENTS after review

**Example:**
```
User: [Updates requirements manually]
User: "REPLAN"
AI: 📋 Re-analyzing requirements...

    ✅ Added 3 new tasks for OAuth integration
    ⏱️ Estimated time increased by 2 hours

    ⚠️ Run SYNC REQUIREMENTS to update requirements with analysis details
```

#### `APPROVE PLAN`
**Purpose:** Lock requirements and plan, begin implementation
**AI Actions:**
1. Check if requirements and plan are in sync (compare timestamps)
2. If not synced, prompt user to run SYNC REQUIREMENTS first
3. If synced, show plan summary (phases, tasks, estimates, risks)
4. Mark plan as "Approved" and lock it
5. Begin Phase 1 implementation
6. Update project plan with approval timestamp

**Example:**
```
User: "APPROVE PLAN"
AI: ✅ Synchronization verified!
    🔒 Plan approved and locked!

    📋 Plan Summary:
    - 4 Phases, 18 tasks
    - Estimated: 2.5 days

    🚀 Starting Phase 1: Database Schema Setup
```

#### `PLAN STATUS`
**Purpose:** Check synchronization status and plan details
**AI Actions:**
1. Show last modification times for requirements and plan
2. Check if sync is needed (compare timestamps)
3. Display plan progress (phases completed, tasks done)
4. Show any warnings or recommendations
5. Display current task and next task

**Example:**
```
User: "PLAN STATUS"
AI: 📊 Project Plan Status

    🔄 Synchronization:
    ✅ Status: IN SYNC
    ✅ Last synced: 2025-10-24 10:25 AM

    📈 Progress: 22% complete (4/18 tasks)
    🎯 Current: Phase 1, Task 1.5
```

#### `UNLOCK PLAN`
**Purpose:** Reset to planning phase (emergency scope change)
**AI Actions:**
1. Warn user that implementation progress will be reset
2. Show current progress that will be lost
3. Require confirmation
4. If confirmed, unlock plan and reset to planning phase
5. Allow REPLAN and SYNC REQUIREMENTS again
6. Mark plan as "Unlocked" with reason and timestamp

**Example:**
```
User: "UNLOCK PLAN"
AI: ⚠️ Warning: This will reset implementation progress.
    Phase 1: 80% complete will be lost

    Are you sure? (yes/no)
```

### **File Management Commands**

#### `MOVE USER CONTEXT`
**Purpose:** Archive user context file with project documentation
**AI Actions:**
1. Find related user context file in `ai-contexts/wip/`
2. Create completed folder if needed: `ai-contexts/project-plans/completed/YYYY-MM/`
3. Move context file with descriptive name: `context-{ticket}-{description}.md`
4. Add to same git commit as project plan
5. Confirm both files archived together

#### `ARCHIVE PROJECT`
**Purpose:** Archive both project plan and user context together
**AI Actions:**
1. Move project plan from `active/` to `completed/YYYY-MM/`
2. Move related context file from `wip/` to `completed/YYYY-MM/`
3. Rename context file with `context-` prefix for clarity
4. Generate comprehensive commit message including:
   - Brief summary (50 chars max)
   - Detailed description
   - Files modified
   - Impact and benefits
   - Testing completed
5. Commit both files with meaningful message
6. Provide archival summary with file locations

#### `CLEAN WIP`
**Purpose:** Clean up completed work from wip folder
**AI Actions:**
1. List all files in `ai-contexts/wip/`
2. Check if corresponding project plans exist in `completed/`
3. Ask user permission before removing each completed context file
4. Either move to `completed/` or delete based on user preference
5. Show before/after file counts
6. Confirm wip folder only contains active work

### **Documentation & Analysis Commands**

#### `DOCUMENT WORK`
**Purpose:** Generate documentation and commit messages from project plan
**AI Actions:**
1. Read current project plan checklist and review summary
2. Generate conventional commit message format:
   - `feat(component): brief description`
   - Detailed body with bullet points
   - Breaking changes if any
   - Closes #{ticket-number}
3. Include key metrics (files changed, performance impact, etc.)
4. Suggest additional documentation if complex changes
5. Format ready for `git commit -m "message"`

#### `SUMMARY WEEK`
**Purpose:** Show this week's productivity and accomplishments
**AI Actions:**
1. List all project plans completed in past 7 days
2. Show ticket numbers, features, and completion dates
3. Summarize key accomplishments by category
4. Calculate productivity metrics (tasks/day, features delivered)
5. Highlight major features, bug fixes, or improvements
6. Note patterns or learnings from the week

#### `SUMMARY MONTH`
**Purpose:** Generate monthly productivity report
**AI Actions:**
1. List all projects in `ai-contexts/project-plans/completed/YYYY-MM/`
2. Group by project type (features, bugs, refactoring, infrastructure)
3. Show completion dates and estimated effort
4. Calculate monthly velocity and trends
5. Highlight major deliverables and their impact
6. Identify successful patterns and areas for improvement
7. Generate executive summary for reviews

#### `FIND WORK {keyword}`
**Purpose:** Search historical work for reference or context
**AI Actions:**
1. Search all files in `ai-contexts/project-plans/completed/` for keyword
2. Look in file names, descriptions, checklists, and review summaries
3. Show matching projects with dates and brief summaries
4. Include file paths and relevant line numbers
5. Suggest related work that might provide helpful context
6. Format results for easy copy/reference

### **Advanced Workflow Commands**

#### `ROLLBACK TASK {project-name}`
**Purpose:** Move completed work back to active development
**AI Actions:**
1. Find specified project plan in `completed/` folder
2. Move back to `ai-contexts/project-plans/active/`
3. Reset checkboxes that need rework from [x] to [ ]
4. Add rollback section with:
   - Reason for rollback
   - Date of rollback
   - What needs to be redone
5. Update git to reflect the move
6. Confirm project ready for continued development

#### `DUPLICATE PLAN {new-ticket}`
**Purpose:** Copy existing project plan for similar work
**AI Actions:**
1. Copy current or specified project plan structure
2. Update ticket number to new value
3. Reset all checkboxes to [ ]
4. Update dates to current
5. Modify task descriptions for new requirements
6. Save as new project plan in `active/` folder
7. Confirm template ready for new work

#### `TEMPLATE SAVE {template-name}`
**Purpose:** Save current project plan as reusable template
**AI Actions:**
1. Copy current project plan structure and format
2. Remove specific ticket numbers, dates, and file names
3. Reset all checkboxes to [ ]
4. Add placeholder variables: `{ticket}`, `{feature}`, `{date}`
5. Generalize task descriptions to be reusable
6. Save in `templates/project-plans/{template-name}.md`
7. Update template documentation with usage guide

### **Help Commands**

#### `SHOW COMMANDS`
**Purpose:** Display all available workflow commands with descriptions
**AI Actions:**
1. Display formatted table of all available commands
2. Include command syntax with placeholders
3. Show brief description of each command's purpose
4. Organize by category (Task Management, File Management, Reporting, Advanced, Help)
5. Highlight most commonly used commands
6. Provide examples of typical command combinations
7. Include note about VS Code snippets availability

**Example Output:**
```
📋 AI Workflow Commands

SESSION MANAGEMENT:
  RESUME                      - Restore session after interruption/handoff
  RESUME {ticket}             - Resume specific project by ticket
  CONTINUE                    - Continue implementation after RESUME
  REVIEW                      - Review completed work in detail

TASK MANAGEMENT:
  TASK START {ticket} {desc}  - Create project plan and begin work
  TASK UPDATE                 - Update progress and checkboxes
  TASK COMPLETE               - Archive completed work with documentation
  TASK STATUS                 - Show current progress and next steps

REQUIREMENTS-PLAN SYNC:
  SYNC REQUIREMENTS           - Update requirements to match project plan
  REPLAN                      - Re-analyze requirements and update plan
  APPROVE PLAN                - Lock requirements/plan and begin implementation
  PLAN STATUS                 - Check synchronization status
  UNLOCK PLAN                 - Reset to planning phase (emergency)

FILE MANAGEMENT:
  MOVE USER CONTEXT           - Archive context file with project plan
  ARCHIVE PROJECT             - Archive both plan and context together
  CLEAN WIP                   - Remove completed work from wip folder

REPORTING:
  DOCUMENT WORK               - Generate commit message from current work
  SUMMARY WEEK                - Show this week's completed tasks
  SUMMARY MONTH               - Show this month's productivity metrics
  FIND WORK {keyword}         - Search completed work history

ADVANCED:
  ROLLBACK TASK {project}     - Move completed work back to active
  DUPLICATE PLAN {ticket}     - Copy existing plan for similar work
  TEMPLATE SAVE {name}        - Save current plan as reusable template

HELP:
  SHOW COMMANDS               - Display this command reference

💡 TIP: All commands available as VS Code snippets with 'ai-' prefix
📖 Full documentation: contexts/workflow-commands-reference.md
```

## 🔄 Typical Command Workflow

### Basic Workflow (Without Sync)
```
1. User: "TASK START NOTKT tailwind-conversion"
   AI: Creates project plan, ready for Phase 1

2. User: works on implementation...
   User: "TASK UPDATE"
   AI: Updates checkboxes, shows progress

3. User: continues work...
   User: "TASK STATUS"
   AI: Shows 65% complete, next 3 tasks

4. User: completes all work...
   User: "TASK COMPLETE"
   AI: Archives plan, commits documentation

5. User: "MOVE USER CONTEXT"
   AI: Archives context file with project plan
```

### Complete Workflow (With Requirements-Plan Sync)
```
1. User: "TASK START TICKET-123 user-authentication"
   AI: Creates requirements context file in wip/

2. User: Fills in basic requirements
   User: "START"
   AI: Creates project plan with analysis

3. User: Reviews plan, asks questions, suggests changes
   AI: Updates project plan with feedback

4. User: "SYNC REQUIREMENTS"
   AI: Updates requirements to match analyzed plan details

5. User: Adds new requirement to wip/ file
   User: "REPLAN"
   AI: Re-analyzes requirements, updates plan

6. User: "SYNC REQUIREMENTS"
   AI: Syncs requirements with updated plan analysis

7. User: "PLAN STATUS"
   AI: Shows IN SYNC status, ready for implementation

8. User: "APPROVE PLAN"
   AI: Locks plan, begins Phase 1 implementation

9. User: works through phases...
   User: "TASK UPDATE"
   AI: Updates checkboxes, shows progress

10. User: "TASK COMPLETE"
    AI: Archives plan and context, commits documentation
```

## 💡 Command Best Practices

### **For Users:**
- Use commands consistently for predictable results
- Check `TASK STATUS` regularly to track progress
- Use `FIND WORK` before starting similar tasks
- Archive with `TASK COMPLETE` when truly done

### **For AI:**
- Always confirm command understood before executing
- Provide clear status updates during execution
- Show file locations and git commands used
- Ask for confirmation on destructive operations (delete, move)
- Generate descriptive commit messages
- Maintain consistent file naming conventions

### **Error Handling:**
- If command unclear, ask for clarification
- If files missing, suggest alternatives
- If git operations fail, provide troubleshooting
- Always confirm successful completion

## 🎯 Command Integration

### **VS Code Snippets**
All commands available as VS Code snippets with `ai-` prefix:
- Type `task-complete` → expands to full command
- Includes placeholders for customization
- Works with GitHub Copilot Chat integration

### **Context Integration**
Commands reference this document in `master-context.md`:
- AI learns command patterns and behaviors
- Consistent execution across different AI sessions
- Extensible for project-specific commands

### **Shell Scripts** (Future)
Planned executable commands:
- `ai-task-complete` → runs full workflow
- `ai-task-status` → shows current progress
- `ai-find-work keyword` → searches completed work

## 📚 Quick Reference

| Command | Purpose | Result |
|---------|---------|--------|
| `RESUME` | Restore session | Loads contexts, shows status |
| `RESUME {ticket}` | Resume specific project | Restores by ticket |
| `CONTINUE` | Resume implementation | Continues next task |
| `REVIEW` | Review completed work | Shows detailed review |
| `TASK START {ticket} {desc}` | Begin new work | Creates project plan |
| `TASK UPDATE` | Show progress | Updates checkboxes |
| `TASK COMPLETE` | Finish work | Archives & commits |
| `TASK STATUS` | Check progress | Shows completion % |
| `SYNC REQUIREMENTS` | Update requirements to match plan | Syncs wip/ with plan |
| `REPLAN` | Re-analyze and update plan | Updates plan from requirements |
| `APPROVE PLAN` | Lock plan and start coding | Locks requirements & plan |
| `PLAN STATUS` | Check sync status | Shows sync state |
| `UNLOCK PLAN` | Emergency scope change | Resets to planning |
| `MOVE USER CONTEXT` | Archive context | Moves wip/ → completed/ |
| `ARCHIVE PROJECT` | Archive all | Moves both files |
| `CLEAN WIP` | Clean workspace | Removes old files |
| `DOCUMENT WORK` | Generate docs | Creates commit message |
| `SUMMARY WEEK` | Weekly report | Shows accomplishments |
| `SUMMARY MONTH` | Monthly report | Detailed productivity |
| `FIND WORK {keyword}` | Search history | Finds past work |
| `ROLLBACK TASK` | Undo completion | Move back to active |
| `DUPLICATE PLAN {ticket}` | Copy structure | New plan from template |
| `TEMPLATE SAVE {name}` | Save template | Reusable plan structure |
| `SHOW COMMANDS` | List commands | Displays command reference |

---

**This command framework transforms the AI workflow from verbose explanations to simple, predictable commands that both users and AI understand consistently.** 🚀