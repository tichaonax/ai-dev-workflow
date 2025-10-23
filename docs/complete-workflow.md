# Complete Workflow Guide - Two-Phase Process

**The definitive guide to using the AI-Assisted Development Workflow**

---

## 🎯 Overview: Two-Phase Workflow

The workflow has been designed as a **two-phase process** to ensure proper requirements gathering before AI begins work:

**Phase 1: Setup & Requirements** (`TASK START`)
- Choose appropriate template
- Create/edit context file with your requirements
- Human-driven requirements definition

**Phase 2: Execution** (`START`)  
- AI reads your completed requirements
- Creates comprehensive project plan
- Begins structured implementation

---

## 📋 Complete Command Reference

### Phase 1: Setup Commands

#### `TASK START {ticket-id} {description}`
**Purpose:** Initialize new task with template selection
**AI Behavior:**
- Shows numbered list of 9 available templates
- Asks user to choose template by number or name
- Creates context file: `ai-contexts/wip/{ticket-id}-{description}.md`
- **Stops and waits** for user to fill requirements
- Does NOT create project plan yet

**Example:**
```
You: TASK START PROJECT-123 user-authentication
AI: [Shows template menu, creates context file, waits for requirements]
```

#### Human Step: Fill Requirements
**Purpose:** Define your specific requirements in the context file
**Actions:**
1. Open: `ai-contexts/wip/PROJECT-123-user-authentication.md`
2. Fill in template sections with your specific needs
3. Save the file
4. Proceed to Phase 2

### Phase 2: Execution Commands

#### `START`
**Purpose:** Begin work after requirements are complete
**AI Behavior:**
- Reads completed context file
- Creates comprehensive project plan: `ai-contexts/project-plans/active/projectplan-{ticket-id}-{description}-{date}.md`
- Includes all 8 required sections
- Begins Phase 1 of implementation
- Shows progress summary

**Example:**
```
You: START
AI: [Reads context, creates project plan, begins Phase 1 work]
```

### Progress Management Commands

#### `TASK STATUS`
**Purpose:** Check current progress
**AI Behavior:**
- Reads actual project plan file
- Shows completion percentage with progress bar
- Lists completed and pending tasks
- Suggests next steps

#### `TASK UPDATE`  
**Purpose:** Update progress after completing work
**AI Behavior:**
- Reviews current project plan
- Marks completed tasks with [x]
- Updates progress percentage
- Shows updated summary

#### `TASK COMPLETE`
**Purpose:** Archive completed project
**AI Behavior:**
- Verifies all tasks are completed
- Archives project plan to `completed/{YYYY-MM}/`
- Creates git commit with summary
- Shows completion confirmation

#### `MOVE USER CONTEXT`
**Purpose:** Archive user context file
**AI Behavior:**
- Moves context file to `completed/{YYYY-MM}/`
- Adds "context-" prefix to filename
- Should only be used after TASK COMPLETE

---

## 🎯 Step-by-Step Walkthrough

### 1. Start New Task
```bash
TASK START HPP-5470 tailwind-conversion
```

**AI Response:**
```
🎯 TASK START: HPP-5470 tailwind-conversion

📋 Available Templates:
1. 🆕 feature-development 
2. 🐛 debugging  
3. ♻️ refactor-optimization (recommended for tailwind-conversion)
4. 🗄️ database-schema
5. 🔌 api-endpoint
6. 🎨 design-review
7. 📝 documentation
8. 🔒 security-review
9. 🔍 init-session

Which template would you like to use? (Enter number or name)
```

### 2. Choose Template
```bash
3
```

**AI Response:**
```
✅ Selected: refactor-optimization template

📝 Context File Status:
❌ File doesn't exist: ai-contexts/wip/HPP-5470-tailwind-conversion.md

🔄 Creating new context file from template...
✅ Created: ai-contexts/wip/HPP-5470-tailwind-conversion.md
📄 Based on: ai-contexts/templates/v1/refactor-optimization-session.md

📋 Next Steps:
1. 📂 Open file: ai-contexts/wip/HPP-5470-tailwind-conversion.md
2. ✏️  Fill in your specific requirements:
   - Current state description
   - Refactoring goals
   - Technical constraints
   - Success criteria
3. 💾 Save the file
4. 🚀 Type: START (to create project plan and begin work)

⏸️  **WORKFLOW PAUSED** - Waiting for you to complete your requirements.
```

### 3. Fill Requirements (Human Step)
Open `ai-contexts/wip/HPP-5470-tailwind-conversion.md` and fill in:
- What needs refactoring
- Why you're doing it  
- Specific goals and constraints
- Success criteria
- Any technical considerations

### 4. Begin Execution
```bash
START
```

**AI Response:**
```
🚀 START: Beginning project execution

📖 Reading requirements: ai-contexts/wip/HPP-5470-tailwind-conversion.md
✅ Context loaded successfully

🔄 Creating comprehensive project plan...
✅ Created: ai-contexts/project-plans/active/projectplan-HPP-5470-tailwind-conversion-2025-10-21.md

📋 Project Plan Summary:
- Total tasks: 34
- Implementation phases: 3
- Success criteria: 5
- Files to modify: 12

🎯 Phase 1: Analysis and Setup (8 tasks)
- [ ] Audit current styled-components usage
- [ ] Install Tailwind CSS dependencies
- [ ] Configure Tailwind build process
- [ ] Create utility class mapping strategy
- [ ] Set up component conversion checklist
- [ ] Document breaking changes approach
- [ ] Create rollback plan
- [ ] Set up testing strategy

Ready to begin Phase 1? I'll start with auditing the current styled-components.
```

### 5. Check Progress
```bash
TASK STATUS
```

**AI Response:**
```
📊 AI Task Status - Project Progress
==================================
   Plan: projectplan-HPP-5470-tailwind-conversion-2025-10-21.md
   
📈 Progress Summary:
   Total tasks: 34
   Completed: 3
   Pending: 31
   Progress: 9%

   Progress: [██------------------] 9%

✅ Completed Tasks:
   ✓ Audit current styled-components usage
   ✓ Install Tailwind CSS dependencies  
   ✓ Configure Tailwind build process

⏳ Pending Tasks:
   ○ Create utility class mapping strategy
   ○ Set up component conversion checklist
   ... and 29 more

🎯 Suggested Next Steps:
   • Continue working on pending tasks
   • Run: TASK UPDATE (to mark completed tasks)
```

### 6. Complete Project
```bash
TASK COMPLETE
```

**AI Response:**
```
🎯 Task completion process initiated

✅ All tasks verified complete (34/34)
📁 Archiving to: ai-contexts/project-plans/completed/2025-10/
💾 Creating git commit...

✅ Project successfully completed!
📊 Final Summary:
   - Duration: 3 days
   - Tasks completed: 34
   - Files modified: 12
   - Zero breaking changes

🎯 Next: MOVE USER CONTEXT (to archive requirements file)
```

---

## 🛡️ Safety Features

### Dry-Run Default
All shell scripts default to dry-run mode:
```bash
./tools/ai-task-complete         # Shows what would happen
./tools/ai-task-complete --yes   # Actually executes
```

### Human Checkpoints
- Template selection (human choice)
- Requirements definition (human input)
- Phase approvals (human oversight)
- Task completion verification (human validation)

### Rollback Protection
- Project plans include rollback sections
- Git commits for all major changes
- Easy reversion of incomplete work

---

## 🎯 Success Indicators

### Proper Two-Phase Flow
✅ TASK START shows template menu (doesn't create project plan)  
✅ User fills requirements in context file  
✅ START creates project plan and begins work  
✅ Clear separation between setup and execution

### Quality Project Plans
✅ 8 required sections included  
✅ Specific, actionable tasks with checkboxes  
✅ Clear success criteria  
✅ Risk assessment and mitigation  
✅ Comprehensive testing strategy

### Effective Progress Tracking
✅ Accurate task completion percentages  
✅ Visual progress bars  
✅ Clear next steps identification  
✅ Proper file archival organization

---

## 🚨 Common Issues & Solutions

### Issue: AI Creates Project Plan During TASK START
**Problem:** AI doesn't wait for requirements, jumps to execution
**Solution:** Retrain AI with master-context.md, emphasize two-phase process

### Issue: Template Selection Skipped
**Problem:** AI assumes which template to use
**Solution:** Explicitly remind AI to show template menu first

### Issue: Requirements Not Gathered
**Problem:** AI starts work without reading context file
**Solution:** Ensure AI shows "Type START when ready" message

### Issue: Progress Tracking Inaccurate
**Problem:** Task counts or percentages are wrong
**Solution:** Run `./tools/ai-task-status` to get accurate shell-based progress

---

## 💡 Pro Tips

1. **Template Matching:** Choose template that best matches your work type
2. **Detailed Requirements:** More specific context = better project plans
3. **Incremental Progress:** Use TASK UPDATE frequently for accurate tracking
4. **Shell Tools:** Use `./tools/` scripts for reliable file operations
5. **Git Integration:** Leverage automatic commits for change tracking

---

*This workflow ensures proper planning, human oversight, and structured execution for all AI-assisted development tasks.*