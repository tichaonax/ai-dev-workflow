# Core Concepts

> Understanding the principles behind the AI Development Workflow System

---

## Table of Contents

- [The GRIP Principle](#the-grip-principle)
- [Key Components](#key-components)
- [The Two-Phase Workflow](#the-two-phase-workflow)
- [Context Documents](#context-documents)
- [Session Templates](#session-templates)
- [Project Plans](#project-plans)
- [Approval Checkpoints](#approval-checkpoints)
- [Creating Custom Contexts](#creating-contexts)
- [Creating Custom Templates](#creating-templates)

---

## The GRIP Principle

**GRIP** = **G**ive **R**ight context, **I**mplement **P**rocess

The foundation of this system is built on three pillars:

### 1. Give AI the Right Context

AI assistants need to understand:
- Your coding standards and conventions
- Your project architecture
- Your team's patterns and practices
- Domain-specific knowledge

**How we do it:** Context documents that AI reads before starting work

### 2. Implement the Right Process

Without structure, AI will:
- Skip planning and dive straight into coding
- Make wrong assumptions
- Miss edge cases
- Create inconsistent code

**How we do it:** Mandatory two-phase workflow with approval gates

### 3. Get the Right Results

With the right context and process:
- ✅ Code matches your standards
- ✅ All edge cases considered
- ✅ Complete documentation
- ✅ No breaking changes
- ✅ Minimal rework

---

## Key Components

### 1. Context Documents (`contexts/`)

These are markdown files that teach AI your standards:

```
contexts/
├── master-context.md              # Core principles (always load first)
├── code-workflow.md               # Workflow rules (always load second)
├── general-problem-solving-context.md
├── backend/
│   ├── backend-api-context.md
│   └── database-schema-context.md
└── frontend/
    ├── component-context.md
    ├── styling-context.md
    └── unit-testing-context.md
```

**Purpose:** Provide AI with your team's knowledge base

### 2. Session Templates (`templates/v1/`)

Pre-configured templates for different types of work:

- **feature-development-session.md** - New features
- **debugging-session.md** - Bug fixes
- **refactor-optimization-session.md** - Code improvements
- **database-schema-session.md** - Database changes
- **api-endpoint-session.md** - API development
- **design-review-session.md** - UI/UX review
- **documentation-session.md** - Documentation tasks
- **security-review-session.md** - Security audits
- **init-session.md** - General purpose

**Purpose:** Guide users to provide complete requirements

### 3. Project Plans (`ai-contexts/project-plans/`)

Detailed implementation plans created by AI:

```
project-plans/
├── active/                        # Currently in progress
│   └── projectplan-{ticket}-{feature}-{date}.md
└── completed/                     # Archived finished work
    └── 2025-10/
        └── projectplan-{ticket}-{feature}-{date}.md
```

**Purpose:** Document what will be done, track progress, enable handoffs

### 4. WIP Directory (`ai-contexts/wip/`)

User context files during active development:

```
wip/
└── {ticket}-{feature}.md         # Your filled requirements
```

**Purpose:** Store session requirements before they become project plans

---

## The Two-Phase Workflow

### Phase 1: Template Selection & Requirements Gathering

**Command:** `TASK START {ticket} {description}`

**What happens:**
1. AI presents template selection menu
2. User chooses appropriate template (or AI recommends)
3. AI creates context file in `wip/` from chosen template
4. User fills in their specific requirements
5. User types `START` when ready

**Why this matters:**
- Forces you to think through requirements before coding
- Ensures AI has all necessary information
- Prevents scope creep and missing requirements

### Phase 2: Project Plan Creation & Execution

**Command:** `START`

**What happens:**
1. AI reads your filled context file
2. AI creates detailed project plan with:
   - Task overview
   - Files to be modified/created
   - Impact analysis
   - Detailed to-do checklist
   - Risk assessment
   - Testing plan
   - Rollback plan
3. AI **waits for approval** before coding
4. After approval, AI implements phase by phase
5. AI **waits for approval** after each phase

**Why this matters:**
- You review the plan before any code is written
- You can catch issues early (wrong approach, missing considerations)
- You control the pace of implementation
- You can stop or adjust at any phase

---

## Context Documents

### What Are Context Documents?

Context documents are markdown files that contain:
- Coding standards
- Best practices
- Common patterns
- Examples to follow
- Things to avoid

### How AI Uses Them

When you ask AI to read a context document:
1. AI learns your standards
2. AI applies those standards to all code it generates
3. AI references the context when making decisions

### Core Contexts (Always Load These)

**1. master-context.md**
- GRIP principle
- General operating principles
- Workflow commands
- Example adherence requirements

**2. code-workflow.md**
- Mandatory planning requirements
- Project plan structure
- Task tracking rules
- Approval checkpoint process

**3. general-problem-solving-context.md**
- Debugging methodology
- Problem analysis approach
- Solution validation

### Module-Specific Contexts (Load As Needed)

**Backend:**
- `backend-api-context.md` - API development standards
- `database-schema-context.md` - Database design patterns

**Frontend:**
- `component-context.md` - Component structure
- `styling-context.md` - CSS/styling standards
- `ui-context.md` - UI/UX consistency
- `unit-testing-context.md` - Testing requirements

---

## Session Templates

### What Are Session Templates?

Templates are pre-filled context files that guide you to provide:
- Problem description
- Success criteria
- Technical requirements
- Constraints
- Testing requirements

### How Templates Work

1. **Template Selection:** Choose the template that matches your task type
2. **Copy to WIP:** Template is copied to `wip/{ticket}-{feature}.md`
3. **Fill Requirements:** You complete the template with your specifics
4. **AI Reads:** AI reads your filled template to create project plan

### When to Use Each Template

| Template | Use When | Example |
|----------|----------|---------|
| **feature-development** | Adding new functionality | User authentication, dashboard widgets |
| **debugging** | Fixing bugs | Login failing, data not saving |
| **refactor-optimization** | Improving existing code | N+1 queries, slow API responses |
| **database-schema** | Database changes | New tables, migrations, schema updates |
| **api-endpoint** | API work | New endpoints, API updates |
| **design-review** | UI/UX changes | Component redesign, accessibility |
| **documentation** | Writing docs | API docs, user guides |
| **security-review** | Security tasks | Vulnerability fixes, audits |
| **init-session** | General/exploration | Learning codebase, experiments |

---

## Project Plans

### What Is a Project Plan?

A project plan is a detailed document created by AI that includes:

1. **Task Overview** - What will be done
2. **Files Affected** - Which files will change
3. **Impact Analysis** - What could break
4. **To-Do Checklist** - Atomic tasks with checkboxes
5. **Risk Assessment** - What could go wrong
6. **Testing Plan** - How to verify it works
7. **Rollback Plan** - How to undo if needed
8. **Review Summary** - Lessons learned (added at end)

### Naming Convention

```
projectplan-{TICKET}-{feature-name}-{YYYY-MM-DD}.md
```

**Examples:**
- `projectplan-HPP-1234-user-auth-2025-10-22.md`
- `projectplan-NOTKT-refactor-api-2025-10-22.md`

### Project Plan Lifecycle

```
1. Created → ai-contexts/project-plans/active/
2. AI updates checkboxes as work progresses
3. Completed → moved to ai-contexts/project-plans/completed/YYYY-MM/
4. Committed to git for permanent record
```

---

## Approval Checkpoints

### Why Approval Checkpoints?

Approval checkpoints prevent:
- ❌ AI making wrong assumptions
- ❌ Wasted time on incorrect approaches
- ❌ Breaking changes sneaking in
- ❌ Missing edge cases

### When Approvals Happen

**Checkpoint 1: Before Any Code**
- AI presents complete project plan
- You review the approach
- You approve or request changes

**Checkpoint 2: After Each Phase**
- AI completes one phase
- AI shows what was implemented
- You review and approve next phase

### How to Give Approval

Simple responses work:
- "Looks good, proceed"
- "Approved"
- "Go ahead with Phase 2"
- "Yes, continue"

### How to Request Changes

Be specific:
- "Use JWT instead of sessions for auth"
- "Add error handling for network failures"
- "Include unit tests in Phase 2"

---

## Creating Contexts

### When to Create a Custom Context

Create a context document when:
- You have team-specific coding patterns
- You use a library/framework not covered
- You have domain-specific logic
- You want to enforce certain practices

### Context Structure

```markdown
# Context Name

## Purpose
Brief description of what this context teaches

## Standards
- Standard 1
- Standard 2

## Patterns to Follow
```typescript
// Example of correct pattern
```

## Patterns to Avoid
```typescript
// Example of what NOT to do
```

## Best Practices
1. Practice 1
2. Practice 2

## Examples
Full working examples
```

### Naming Convention

- Use descriptive names: `payment-processing-context.md`
- Group by domain: `backend/`, `frontend/`, `domain/`
- Version if needed: `contexts/v2/`

### Where to Store

```
ai-contexts/contexts/
└── custom/
    ├── payment-processing-context.md
    ├── notification-system-context.md
    └── analytics-tracking-context.md
```

---

## Creating Templates

### When to Create a Custom Template

Create a template when:
- You have a recurring type of task
- Your team has a specific workflow
- You want to standardize how requirements are gathered

### Template Structure

```markdown
# {Task Type} Session Template

> **Template Type:** {Description}
> **Version:** 1.0
> **Last Updated:** {Date}

## 🎯 Purpose
What this template is for

## 📋 Required Context Documents
Which contexts should AI load

## 🚀 Session Objective
**Ticket:**
**Goal:**
**Expected Outcome:**
**Success Criteria:**

## 📐 Technical Specifications
**Technologies:**
**Dependencies:**
**Integration Points:**

## 🧪 Testing Requirements
**Unit Tests:**
**Integration Tests:**

## ✅ Start Session
Instructions for AI
```

### Naming Convention

```
templates/v1/{task-type}-session.md
```

### Where to Store

```
ai-contexts/templates/
└── v1/
    └── my-custom-session.md
```

---

## Best Practices

### For Context Documents

1. **Be Specific:** Include actual code examples
2. **Show Don't Tell:** Provide working examples
3. **Explain Why:** Context behind the rules
4. **Keep Updated:** Review and update regularly
5. **Version When Needed:** Use v1, v2 folders if standards change

### For Templates

1. **Required Fields Only:** Don't add optional fields
2. **Clear Instructions:** Tell AI what to do
3. **Relevant Contexts:** List which contexts to load
4. **Success Criteria:** Define what "done" means
5. **Test First:** Try it on a real task before sharing

### For Project Plans

1. **One Plan Per Task:** Don't combine multiple features
2. **Update Checkboxes:** Mark tasks complete as you go
3. **Add Notes:** Document decisions and why
4. **Archive When Done:** Move to completed/ folder
5. **Commit to Git:** Keep permanent record

---

## Common Patterns

### Starting a New Feature

```
1. TASK START HPP-123 user-profile
2. Choose: feature-development template
3. Fill in requirements
4. START
5. Review project plan
6. Approve
7. Review each phase
8. TASK COMPLETE when done
```

### Fixing a Bug

```
1. TASK START HPP-456 login-bug-fix
2. Choose: debugging template
3. Document reproduction steps
4. START
5. Review root cause analysis
6. Approve fix approach
7. TASK COMPLETE when fixed
```

### Optimizing Code

```
1. TASK START HPP-789 optimize-dashboard
2. Choose: refactor-optimization template
3. Document performance issues
4. START
5. Review optimization plan
6. Approve
7. TASK COMPLETE when improved
```

---

## Next Steps

- Read [Best Practices](best-practices.md) for tips
- Review [Examples](../examples/) for real workflows
- Try [Quick Start](quick-start.md) on a small task
- Explore [Complete Workflow](complete-workflow.md) guide

---

[Back to README](../README.md) | [Quick Start](quick-start.md) | [Best Practices](best-practices.md)
