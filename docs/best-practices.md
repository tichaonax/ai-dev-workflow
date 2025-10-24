# Best Practices

> Proven tips and techniques for getting the most out of the AI Development Workflow System

---

## Table of Contents

- [Context Loading](#context-loading)
- [Template Usage](#template-usage)
- [Project Planning](#project-planning)
- [Approval Checkpoints](#approval-checkpoints)
- [Task Management](#task-management)
- [Team Collaboration](#team-collaboration)
- [Common Mistakes to Avoid](#common-mistakes-to-avoid)
- [Pro Tips](#pro-tips)

---

## Context Loading

### ✅ DO: Load Contexts in Order

**Always load in this sequence:**
1. `master-context.md` (core principles)
2. `code-workflow.md` (workflow rules)
3. Module-specific contexts (as needed)

```
Good:
👤 Please read:
   1. ai-contexts/contexts/master-context.md
   2. ai-contexts/contexts/code-workflow.md
   3. ai-contexts/contexts/frontend/component-context.md

Bad:
👤 Read all the contexts in ai-contexts/
```

**Why:** AI needs to learn workflow commands first, then apply them to your specific work.

### ✅ DO: Load Only Relevant Contexts

```
For frontend work:
✅ master-context.md
✅ code-workflow.md
✅ frontend/component-context.md
✅ frontend/styling-context.md
❌ backend/backend-api-context.md (not needed)
❌ backend/database-schema-context.md (not needed)
```

**Why:** Too many contexts can confuse AI or dilute focus.

### ✅ DO: Use VS Code Snippets for Speed

Instead of manually typing context load requests:

```
Type: ai-train + Tab

Expands to:
👋 Hi! Please read these files to learn our workflow:
📖 ai-contexts/contexts/master-context.md
📖 ai-contexts/contexts/code-workflow.md
...
```

**Why:** Saves time and ensures consistency.

### ❌ DON'T: Skip Core Contexts

```
Bad:
👤 Add a new API endpoint for user profile

AI will not know to:
- Create a project plan first
- Wait for approval
- Update checkboxes
- Follow your team's API patterns
```

**Fix:** Always load master-context.md and code-workflow.md first.

---

## Template Usage

### ✅ DO: Choose the Right Template

| Your Task | Use Template |
|-----------|--------------|
| "Add user authentication" | feature-development |
| "Login button not working" | debugging |
| "Dashboard loads slowly" | refactor-optimization |
| "Add users table" | database-schema |
| "Create /api/users endpoint" | api-endpoint |

### ✅ DO: Fill Templates Completely

**Complete template:**
```markdown
**Ticket:** HPP-1234

**Goal:** Add user authentication with JWT

**Expected Outcome:** Users can register, login, logout

**Success Criteria:**
- Users can register with email/password
- Users receive JWT token on login
- Protected routes require valid JWT
- Passwords are hashed with bcrypt
```

**Incomplete template:**
```markdown
**Ticket:** HPP-1234
**Goal:** Add authentication
```

**Why:** Incomplete requirements lead to wrong assumptions.

### ✅ DO: Be Specific About Constraints

```markdown
**Constraints:**
- Must use existing User model (don't create new)
- Must maintain backward compatibility with mobile app
- Cannot use external auth services (Google, Facebook)
- Must complete by end of sprint (3 days)
```

**Why:** AI needs to know limitations upfront.

### ❌ DON'T: Mix Multiple Features in One Template

```
Bad:
**Goal:** Add user authentication AND admin dashboard AND email notifications

Good:
**Goal:** Add user authentication
(Create separate tasks for dashboard and emails)
```

**Why:** One project plan per feature keeps things manageable.

---

## Project Planning

### ✅ DO: Review Plans Before Approval

Check for:
- [ ] Are all required files listed?
- [ ] Is the approach correct for our codebase?
- [ ] Are edge cases considered?
- [ ] Is testing included?
- [ ] Is rollback plan realistic?

### ✅ DO: Ask Questions If Unclear

```
Good responses to project plan:
❓ "Why use Redis instead of in-memory cache?"
❓ "What happens if the email service is down?"
❓ "Should we add rate limiting to this endpoint?"
```

**Why:** This is your chance to catch issues before coding starts.

### ✅ DO: Request Changes to Plans

```
👤 The plan looks good, but:
   1. Use JWT library instead of custom implementation
   2. Add validation for password strength
   3. Include integration tests in Phase 3

   Update the plan and show me the revised version.
```

**Why:** Plans are meant to be refined.

### ❌ DON'T: Approve Plans You Don't Understand

```
Bad:
👤 Looks good, go ahead (when you don't actually understand)

Good:
👤 Can you explain why we need Redis for this?
   What's the alternative approach?
```

**Why:** You own the code quality.

---

## Approval Checkpoints

### ✅ DO: Review Code After Each Phase

**What to check:**
```
Phase 1 completed:
- [ ] Code matches project plan
- [ ] Tests are passing
- [ ] No unexpected files modified
- [ ] Follows team coding standards
```

### ✅ DO: Test Before Approving Next Phase

```
Good workflow:
1. AI completes Phase 1 (backend API)
2. You test the endpoints manually
3. You verify tests pass
4. You approve Phase 2 (frontend)

Bad workflow:
1. AI completes all phases without testing
2. You discover bugs at the end
3. More rework needed
```

**Why:** Catch issues early when they're easier to fix.

### ✅ DO: Give Specific Feedback

```
Good:
👤 Phase 1 looks good, but change the error messages to match
   our standard format from error-handling-context.md.
   After that fix, proceed to Phase 2.

Bad:
👤 There's something wrong with the errors.
```

**Why:** Specific feedback = faster fixes.

### ❌ DON'T: Skip Testing Between Phases

```
Bad:
👤 Looks good, keep going (without actually testing)

Results in:
- Multiple phases built on broken foundation
- Much harder to debug later
- More time wasted
```

---

## Task Management

### ✅ DO: Use Descriptive Ticket Names

```
Good:
TASK START HPP-1234 user-authentication-jwt

Bad:
TASK START HPP-1234 auth
TASK START HPP-1234 feature
```

**Why:** Clear names help when reviewing history.

### ✅ DO: Keep Project Plans Updated

```
As AI completes tasks, verify checkboxes are marked:

### Phase 1: Backend
- [x] Task 1.1: Create User model
- [x] Task 1.2: Add password hashing
- [ ] Task 1.3: Create login endpoint
```

**Why:** Anyone can see progress without reading chat history.

### ✅ DO: Archive Completed Work

```
After TASK COMPLETE:
1. Project plan → ai-contexts/project-plans/completed/2025-10/
2. Context file → ai-contexts/project-plans/completed/2025-10/
3. Commit both to git
```

**Why:** Permanent record of decisions and implementation.

### ✅ DO: Use TASK STATUS to Check Progress

```
👤 TASK STATUS

🤖 AI shows:
   - Current project plan
   - Completed tasks (8/12)
   - Next tasks to work on
   - Estimated time remaining
```

**Why:** Quick visibility into progress.

---

## Team Collaboration

### ✅ DO: Commit Project Plans with Code

```bash
git add ai-contexts/project-plans/active/projectplan-HPP-1234-*.md
git add src/auth/
git commit -m "feat: Add user authentication

Implemented JWT-based authentication system.

Project plan: projectplan-HPP-1234-user-auth-2025-10-22.md
All 12 tasks completed. Tests passing."
```

**Why:** Teammates can see the plan when reviewing your PR.

### ✅ DO: Share Templates for Common Tasks

```
If your team frequently:
- Migrates databases → Share database-schema template workflow
- Fixes performance issues → Share refactor-optimization examples
- Adds API endpoints → Share api-endpoint best practices
```

**Why:** Consistent quality across the team.

### ✅ DO: Review Completed Plans for Learning

```
Monthly team practice:
1. Review ai-contexts/project-plans/completed/2025-10/
2. Discuss what went well
3. Identify patterns
4. Share lessons learned
```

**Why:** Continuous improvement.

### ❌ DON'T: Modify Someone Else's Active Plan

```
Bad:
Teammate has active plan, you edit their checkboxes

Good:
If helping teammate, add comments:
<!-- John: I helped with Phase 2, tasks 2.3-2.5 completed -->
```

**Why:** Avoid confusion about who did what.

---

## Common Mistakes to Avoid

### Mistake 1: Skipping the Two-Phase Workflow

```
❌ Wrong:
👤 Add user authentication
🤖 *starts coding immediately*

✅ Correct:
👤 TASK START HPP-1234 user-authentication
🤖 Choose template...
👤 *fills template*
👤 START
🤖 Creates plan, waits for approval
```

### Mistake 2: Vague Requirements

```
❌ Vague:
"Make it faster"
"Fix the bug"
"Add the feature"

✅ Specific:
"Dashboard loads in 5 seconds, should be under 1 second"
"Login fails with error 'Invalid credentials' when password is correct"
"Add ability for users to upload profile pictures (max 5MB, PNG/JPG only)"
```

### Mistake 3: Approving Without Understanding

```
❌ Blind approval:
👤 Looks good! (didn't actually review)

✅ Informed approval:
👤 I reviewed:
   - Approach makes sense for our architecture
   - Edge cases covered
   - Testing plan is adequate
   Proceed with implementation.
```

### Mistake 4: Not Using Version Control

```
❌ Bad:
Project plans not committed to git
Lost when AI session ends

✅ Good:
git add ai-contexts/project-plans/
git commit -m "Add project plan for user auth feature"
```

### Mistake 5: Too Large Tasks

```
❌ Too large:
TASK START HPP-1234 complete-user-management-system

✅ Smaller tasks:
TASK START HPP-1234 user-authentication
TASK START HPP-1235 user-profile-page
TASK START HPP-1236 user-settings-page
```

---

## Pro Tips

### Tip 1: Use VS Code Snippets

Install snippets for instant access to workflow commands:

```
ai-train + Tab     → AI training message
task-start + Tab   → TASK START command
start + Tab        → START command
task-status + Tab  → TASK STATUS command
```

Location: `ai-contexts/integrations/vscode/ai-workflow-commands.code-snippets`

### Tip 2: Create Project-Specific Contexts

```
ai-contexts/contexts/custom/
└── payment-processing-context.md  (your specific logic)
└── notification-system-context.md (your patterns)
```

Load these for relevant tasks.

### Tip 3: Keep a Team Examples Folder

```
ai-contexts/examples/team/
├── EXAMPLE-our-best-api-endpoint.md
├── EXAMPLE-our-database-migration.md
└── EXAMPLE-our-component-refactor.md
```

Reference in templates: "Follow pattern from EXAMPLE-our-best-api-endpoint.md"

### Tip 4: Use FIND WORK to Learn

```
👤 FIND WORK authentication

🤖 Shows all past authentication-related project plans

Review these to see:
- How others approached similar problems
- What worked well
- What to avoid
```

### Tip 5: Monthly Cleanup

```bash
# First Monday of each month:
👤 CLEAN WIP

Removes old context files from wip/
Keeps workspace organized
```

### Tip 6: Standardize Ticket Naming

```
Team convention:
{PROJECT}-{NUMBER} {verb}-{noun}-{detail}

Examples:
HPP-1234 add-user-authentication
HPP-1235 fix-login-timeout
HPP-1236 refactor-dashboard-queries
```

### Tip 7: Use Dry Run for Experiments

```
👤 Let's create a project plan but don't implement yet.
   I want to review the approach first.

Good for:
- Evaluating multiple approaches
- Learning how AI would solve it
- Discussing with team before committing
```

### Tip 8: Reference Existing Code

```
In templates, add:
**Existing Pattern:**
See auth/login.ts for similar implementation
Follow same error handling pattern

**Why:** AI can reference actual code in your project
```

### Tip 9: Document Decisions in Plans

```
Add notes to project plan:
## Decision Log
- 2025-10-22: Chose JWT over sessions (mobile app requirement)
- 2025-10-23: Using bcrypt rounds=10 (security team approved)
```

**Why:** Future you will thank present you.

### Tip 10: Celebrate Wins

```
After TASK COMPLETE:
- Share metrics (time saved, bugs prevented)
- Highlight what the workflow caught
- Thank AI for good work
- Share with team in standup
```

**Why:** Positive reinforcement for good practices.

---

## Measuring Success

### Track These Metrics

**Before/After Comparison:**
```
Metric: Hours of rework per task
Before workflow: 4 hours
After workflow: 0.5 hours
Improvement: 87.5% reduction
```

**Quality Indicators:**
- Number of bugs found in code review
- PR review iterations needed
- Breaking changes introduced
- Documentation completeness

**Team Indicators:**
- Onboarding time for new developers
- Time to context-switch between tasks
- Knowledge retention (can pickup old work)

---

## Next Steps

- Read [Core Concepts](concepts.md) for deeper understanding
- Review [Examples](../examples/) for real workflows
- Try [Quick Start](quick-start.md) on a task
- Share your own tips with the team

---

[Back to README](../README.md) | [Core Concepts](concepts.md) | [Quick Start](quick-start.md)
