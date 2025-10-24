# AI Workflow Commands

This document defines standardized commands that users can give to AI to streamline repetitive workflow operations.

## 🎯 Command Philosophy

Instead of explaining the full process each time, users can type simple commands that trigger standardized AI behaviors. This ensures consistency and reduces cognitive load.

## 📋 Core Commands

### **Task Management**

#### `TASK START {ticket} {description}`
**Purpose:** Create new project plan and begin work
**AI Actions:**
1. Read user context file from `wip/{ticket}-{description}.md`
2. Create project plan: `project-plans/active/projectplan-{ticket}-{description}-{date}.md`
3. Include all 8 required sections (overview, files, impact, checklist, risk, testing, rollback, review)
4. Begin Phase 1 execution
5. Confirm project plan created

**Example:**
```
User: "TASK START NOTKT tailwind-conversion"
AI: ✅ Created projectplan-NOTKT-tailwind-conversion-2025-10-21.md
    📁 Location: ai-contexts/project-plans/active/
    🎯 Beginning Phase 1: Setup and Dependencies
```

#### `TASK UPDATE`
**Purpose:** Update project plan checkboxes based on completed work
**AI Actions:**
1. Review current project plan
2. Update checkboxes [x] for completed tasks
3. Add notes on challenges or decisions
4. Show progress summary
5. Identify next tasks

**Example:**
```
User: "TASK UPDATE"
AI: ✅ Updated project plan:
    Phase 1: Setup [3/3] ✅ Complete
    Phase 2: Components [2/5] 🔄 In Progress
    📊 Overall Progress: 62% complete
    🎯 Next: Convert Card component
```

#### `TASK COMPLETE`
**Purpose:** Archive completed work and generate documentation
**AI Actions:**
1. Verify all checkboxes marked [x]
2. Add review summary with lessons learned
3. Create monthly folder: `completed/YYYY-MM/`
4. Move project plan from `active/` to `completed/`
5. Generate descriptive commit message
6. Execute git commit
7. Provide completion metrics

**Example:**
```
User: "TASK COMPLETE"
AI: ✅ Task NOTKT completed successfully!
    📁 Archived to: project-plans/completed/2025-10/
    💾 Committed: "Complete NOTKT: Convert 15 components to Tailwind CSS"
    📊 Results: 15 components converted, -12KB bundle size, 100% tests passing
```

#### `TASK STATUS`
**Purpose:** Show current progress and next steps
**AI Actions:**
1. Display current project plan progress
2. List completed [x] and pending [ ] tasks
3. Calculate completion percentage
4. Estimate remaining work
5. Highlight blockers
6. Suggest next steps

### **File Management**

#### `MOVE USER CONTEXT`
**Purpose:** Move wip/ context file to completed documentation
**AI Actions:**
1. Find related context file in `wip/`
2. Move to `completed/YYYY-MM/`
3. Rename with `context-` prefix
4. Add to same commit as project plan
5. Confirm archival

#### `ARCHIVE PROJECT`
**Purpose:** Archive both project plan and user context together
**AI Actions:**
1. Move project plan to `completed/YYYY-MM/`
2. Move context file to `completed/YYYY-MM/`
3. Rename context with `context-` prefix
4. Generate comprehensive commit message
5. Commit both files together

#### `CLEAN WIP`
**Purpose:** Clean up completed items from wip/ folder
**AI Actions:**
1. List files in `wip/`
2. Identify which have completed project plans
3. Request permission for each removal
4. Move to completed/ or delete
5. Confirm cleanup

### **Documentation & Reporting**

#### `DOCUMENT WORK`
**Purpose:** Generate commit message from current project plan
**AI Actions:**
1. Read current project plan
2. Extract key accomplishments
3. Generate conventional commit message
4. Include metrics and impact
5. Present for review

#### `SUMMARY WEEK`
**Purpose:** Show this week's completed work
**AI Actions:**
1. List completed plans from this week
2. Summarize key accomplishments
3. Calculate productivity metrics
4. Highlight major deliverables

#### `SUMMARY MONTH`
**Purpose:** Show this month's completed work
**AI Actions:**
1. List all plans in `completed/YYYY-MM/`
2. Group by type (feature, bug, refactor)
3. Show completion trends
4. Generate accomplishment report

#### `FIND WORK {keyword}`
**Purpose:** Search historical work by keyword
**AI Actions:**
1. Search `completed/` folders for keyword
2. Look in filenames and content
3. Show matching plans with dates
4. Provide summary of each match

### **Advanced Commands**

#### `ROLLBACK TASK`
**Purpose:** Move project plan back to active development
**AI Actions:**
1. Move plan from `completed/` to `active/`
2. Reset checkboxes if needed
3. Add rollback note with reason
4. Update dates
5. Confirm active status

#### `DUPLICATE PLAN {new-ticket}`
**Purpose:** Copy project plan for similar work
**AI Actions:**
1. Copy specified project plan
2. Update with new ticket number
3. Reset checkboxes to [ ]
4. Update dates and filenames
5. Customize for new requirements

#### `TEMPLATE SAVE {name}`
**Purpose:** Save current project plan as reusable template
**AI Actions:**
1. Copy project plan structure
2. Remove specific references
3. Add placeholder variables
4. Save to `templates/project-plans/`
5. Document usage

## 🎛️ Command Behavior Standards

### **Consistency Rules**
- Always confirm action before executing
- Provide status updates during multi-step operations
- Show clear success/failure messages
- Include relevant metrics when available
- Ask for permission before destructive operations

### **Error Handling**
- Check file existence before operations
- Validate git repository state
- Provide helpful error messages
- Suggest corrective actions
- Gracefully handle missing files

### **Progress Feedback**
```
✅ Action completed successfully
🔄 Operation in progress  
⚠️ Warning or attention needed
❌ Error or failure
📊 Metrics or data
📁 File/folder operations
💾 Git operations
🎯 Next steps
```

## 🚀 Usage Examples

### **Complete Feature Development Workflow**
```bash
# 1. Start new task
TASK START hpp-5480 api-pagination

# 2. Work on implementation...
TASK UPDATE

# 3. Continue development...  
TASK UPDATE

# 4. Complete and archive
TASK COMPLETE
MOVE USER CONTEXT
```

### **Project Review Workflow**
```bash
# Review recent work
SUMMARY WEEK

# Find related historical work
FIND WORK pagination

# Check current status
TASK STATUS
```

### **Template Management**
```bash
# Save successful pattern
TEMPLATE SAVE api-feature-development

# Reuse for similar work
DUPLICATE PLAN hpp-5485
```

## 🎯 Benefits

### **For Users**
- ✅ Reduced cognitive load
- ✅ Consistent operations  
- ✅ Faster workflow execution
- ✅ Less room for error
- ✅ Easy to remember commands

### **For AI**
- ✅ Clear behavioral expectations
- ✅ Standardized responses
- ✅ Consistent file operations
- ✅ Predictable workflows
- ✅ Better user experience

### **For Teams**
- ✅ Shared command vocabulary
- ✅ Consistent documentation
- ✅ Easier onboarding
- ✅ Predictable processes
- ✅ Better collaboration

## 🛠️ Shell Script Implementation

The command framework includes three POSIX shell scripts that complement the AI commands with direct file operations.

### **ai-task-status**
**Purpose:** Show current project plan progress with visual indicators

```bash
# Show status of current project plan
./tools/ai-task-status

# Example output:
📊 AI Task Status - Project Progress
==================================
   Plan: projectplan-EXAMPLE-123-command-framework-2025-10-21.md
   Progress: [===-----------------] 19%
   
✅ Completed Tasks:
   ✓ Create VS Code snippets file with basic commands
   ✓ Add command definitions to master-context.md
   
⏳ Pending Tasks:
   ○ Test snippet expansion in VS Code
   ○ Add usage examples to docs
```

**Features:**
- Visual progress bars and completion percentages
- Next steps suggestions
- Read-only operation (never modifies files)
- Works with any project plan in `active/`

### **ai-task-complete**
**Purpose:** Archive completed project plans with git commit

```bash
# Dry-run (shows what would happen)
./tools/ai-task-complete

# Actually complete the task
./tools/ai-task-complete --yes

# Complete specific plan
./tools/ai-task-complete --yes --plan "projectplan-ABC-123.md"
```

**Safety Features:**
- **Dry-run by default** - requires `--yes` flag for actual operations
- Validates git repository status before operations
- Warns about unchecked tasks (suggests TASK UPDATE first)
- Auto-generates descriptive commit messages
- Creates dated archive directories (`completed/YYYY-MM/`)
- Comprehensive logging to `tools/logs/`

### **ai-move-context**
**Purpose:** Archive user session context files

```bash
# Dry-run (shows what would happen)
./tools/ai-move-context

# Actually move the context
./tools/ai-move-context --yes

# Move specific context file
./tools/ai-move-context --yes --context "session-context-20251021.md"
```

**Features:**
- Auto-detects most recent context file in `wip/`
- Adds "context-" prefix for easy identification
- Creates monthly archive directories
- Structured output with operation preview

### **Safety Framework**

All shell scripts implement comprehensive safety controls:

#### **Dry-Run Mode**
- All destructive operations default to dry-run
- Shows exactly what operations would be performed
- No files are modified until `--yes` flag is used
- Complete preview of all changes

#### **Comprehensive Logging**
- All operations logged to `tools/logs/` with timestamps
- Permanent audit trail for all file operations
- Includes source/destination paths and results
- Daily log files with descriptive names

#### **Validation & Error Handling**
- File existence checks before operations
- Git repository status validation
- Clear error messages with suggested fixes
- Graceful failure with cleanup
- No partial operations (atomic commits)

### **Directory Structure Management**

The scripts automatically manage this structure:

```
ai-contexts/
├── project-plans/
│   ├── active/              # Current project plans
│   └── completed/
│       ├── 2025-10/        # Monthly archives (auto-created)
│       ├── 2025-11/        # Scripts create as needed
│       └── ...
└── wip/                    # Work-in-progress context files

tools/logs/                 # Operation logs
├── ai-task-complete-20251021.log
├── ai-move-context-20251021.log
└── ...
```

### **Integration with AI Commands**

The shell scripts work seamlessly with AI commands:

1. **AI Command**: `TASK COMPLETE` (reviews work, updates checkboxes)
2. **Shell Script**: `./tools/ai-task-complete --yes` (performs file operations)
3. **Result**: Project archived with proper git commit

### **VS Code Snippets Integration**

Type these prefixes in VS Code markdown files and press Tab:

| Prefix | Expands To | Description |
|--------|------------|-------------|
| `task-start` | TASK START command | Begin new project plan |
| `task-complete` | TASK COMPLETE command | Archive completed project |
| `task-update` | TASK UPDATE command | Update progress |
| `task-status` | TASK STATUS command | Show current progress |
| `move-context` | MOVE USER CONTEXT command | Archive session context |

### **Quick Start Guide**

1. **Setup**: Ensure scripts are executable: `chmod +x tools/ai-*`
2. **Check Status**: `./tools/ai-task-status`
3. **Work with AI**: Use VS Code snippets for TASK commands
4. **Complete Work**: `./tools/ai-task-complete --yes`
5. **Archive Context**: `./tools/ai-move-context --yes`

### **Troubleshooting**

**Common Issues:**
- **"No project plans found"**: Check you're in workspace root with `ai-contexts/` directory
- **"Git repository not found"**: Run from git repository root directory
- **"Permission denied"**: Make scripts executable with `chmod +x tools/ai-*`
- **"Context files not found"**: Ensure context files exist in `ai-contexts/wip/`

**Recovery:**
- All operations are logged - check `tools/logs/` for details
- Git operations are committed - use `git log` and `git revert` if needed
- Always test with dry-run mode first

---

## 🎯 Complete Workflow Integration

The framework provides three complementary approaches:

1. **VS Code Snippets**: Quick AI command expansion while coding
2. **AI Commands**: Structured prompts for complex workflow operations  
3. **Shell Scripts**: Direct file operations with safety controls

**Example Complete Workflow:**
```bash
1. Type `task-start` [Tab] in VS Code → AI creates project plan
2. Work on implementation...
3. Type `task-update` [Tab] → AI updates checkboxes
4. Continue development...
5. Type `task-complete` [Tab] → AI reviews and confirms completion
6. Run `./tools/ai-task-complete --yes` → Script archives with git commit
7. Run `./tools/ai-move-context --yes` → Script archives context file
```

**Next Steps:** The command framework is fully implemented and ready for use. Test with real project work and iterate based on usage patterns.