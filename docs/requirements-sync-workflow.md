# Requirements-Plan Synchronization Workflow

> **New Feature:** Formal requirements and project plan synchronization loop

---

## 🎯 Purpose

Ensure requirements and project plans stay synchronized through an iterative refinement process before implementation begins. This prevents scope drift and ensures QA has complete, accurate requirements.

---

## 🔄 The Synchronization Loop

### Phase 1: Initial Requirements → Project Plan

```
User: Creates requirements (wip/TICKET-feature.md)
      ↓
User: START
      ↓
AI: Creates initial project plan
      ↓
User: Reviews, asks questions, suggests changes
      ↓
AI: Updates project plan based on feedback
      ↓
**SYNC CHECKPOINT** ← Requirements may now be outdated
```

### Phase 2: Sync Requirements with Plan

```
User: SYNC REQUIREMENTS
      ↓
AI: Analyzes project plan details
AI: Updates requirements context to match plan
AI: Shows what was added/updated
      ↓
User: Reviews synchronized requirements
```

### Phase 3: Iteration (if needed)

```
User: Updates requirements manually with new ideas
      ↓
User: REPLAN
      ↓
AI: Re-analyzes updated requirements
AI: Updates project plan
AI: Shows changes to plan
      ↓
User: Reviews updated plan
      ↓
**SYNC CHECKPOINT** ← Sync again if plan changed
```

### Phase 4: Implementation

```
User: APPROVE PLAN (or START PHASE 1)
      ↓
AI: Requirements and plan are now locked
AI: Begins implementation
```

---

## 📋 New Commands

### `SYNC REQUIREMENTS`

**Purpose:** Update requirements context to match the current project plan

**When to Use:**
- After creating initial project plan and making changes to it
- Before starting implementation (AI will prompt if not synced)
- After any significant plan updates

**What AI Does:**
1. Read current project plan
2. Extract all requirements, constraints, and details
3. Update requirements context file in wip/
4. Show diff of what changed
5. Ask for confirmation

**Example:**
```
User: SYNC REQUIREMENTS

AI: 📋 Syncing requirements with project plan...

   Reading: projectplan-TICKET-123-user-auth-2025-10-24.md
   Updating: wip/TICKET-123-user-auth.md

   📝 Changes to Requirements:

   ✅ Added:
   - JWT token expiration: 24 hours (from Phase 2 analysis)
   - Password strength: min 8 chars, 1 uppercase, 1 number
   - Rate limiting: 5 failed attempts = 15min lockout
   - Database: users table needs 'locked_until' column

   ✏️ Updated:
   - Success Criteria: Added "passwords must be hashed with bcrypt rounds=10"
   - Testing Requirements: Added integration tests for lockout

   🔍 Review updated requirements?
   wip/TICKET-123-user-auth.md

   ✅ Requirements now match project plan. Ready to proceed!
```

---

### `REPLAN`

**Purpose:** Re-analyze requirements and update project plan

**When to Use:**
- After manually updating requirements with new ideas
- When scope changes significantly
- When you discover missing requirements

**What AI Does:**
1. Read updated requirements context
2. Perform fresh impact analysis
3. Update project plan with changes
4. Show what changed in the plan
5. Mark as needing sync review

**Example:**
```
User: [Manually updates wip/TICKET-123-user-auth.md]
      [Adds: "Must support OAuth2 Google login"]

User: REPLAN

AI: 📋 Re-analyzing requirements...

   Reading: wip/TICKET-123-user-auth.md
   Updating: projectplan-TICKET-123-user-auth-2025-10-24.md

   📝 Changes to Project Plan:

   ✅ Added Tasks:
   - Phase 2, Task 2.5: Integrate Google OAuth2 library
   - Phase 2, Task 2.6: Create /auth/google/callback endpoint
   - Phase 4, Task 4.5: Test Google login flow

   ✏️ Updated:
   - Risk Assessment: Added dependency on Google OAuth service
   - Testing Plan: Added OAuth integration tests
   - Files Affected: Added oauth-config.ts

   ⚠️ Impact: +2 hours estimated time

   📊 Updated Plan Status:
   - Phases: 4 → 4 (unchanged)
   - Tasks: 15 → 18 (+3 tasks)
   - Estimated Time: 2 days → 2.5 days

   🔍 Review updated plan?
   projectplan-TICKET-123-user-auth-2025-10-24.md

   ⚠️ Requirements and plan may be out of sync.
   Run SYNC REQUIREMENTS after reviewing changes.
```

---

### `APPROVE PLAN`

**Purpose:** Lock requirements and plan, begin implementation

**When to Use:**
- After requirements and plan are synchronized
- When you're confident in the design
- Ready to start coding

**What AI Does:**
1. Check if requirements and plan are in sync
2. If not synced, prompt to SYNC REQUIREMENTS first
3. If synced, mark plan as "Approved" and lock it
4. Begin Phase 1 implementation

**Example:**
```
User: APPROVE PLAN

AI: ✅ Checking synchronization status...

   Requirements: wip/TICKET-123-user-auth.md
   Last modified: 2025-10-24 10:15 AM

   Project Plan: projectplan-TICKET-123-user-auth-2025-10-24.md
   Last modified: 2025-10-24 10:20 AM

   ⚠️ Plan was modified after requirements.

   Would you like to SYNC REQUIREMENTS first?
   This ensures QA has complete requirements.

   Options:
   1. SYNC REQUIREMENTS (recommended)
   2. APPROVE ANYWAY (skip sync)
   3. CANCEL (review plan first)
```

**If Already Synced:**
```
User: APPROVE PLAN

AI: ✅ Synchronization verified!

   Requirements and plan last synced: 2025-10-24 10:25 AM
   No changes since sync.

   📋 Plan Summary:
   - 4 Phases
   - 18 Tasks
   - Estimated: 2.5 days
   - All risks documented
   - Tests planned

   🔒 Locking plan for implementation...

   ✅ Plan approved and locked!

   🚀 Starting Phase 1: Database Schema Setup

   Phase 1 Tasks:
   - [1.1] Create users table
   - [1.2] Add authentication columns
   - [1.3] Create migration script

   Proceeding with Task 1.1...
```

---

### `PLAN STATUS`

**Purpose:** Check synchronization status and plan details

**When to Use:**
- Anytime you want to check sync status
- Before running APPROVE PLAN
- To see what's changed since last sync

**What AI Does:**
1. Show last modification times
2. Check if sync is needed
3. Display plan progress
4. Show any warnings

**Example:**
```
User: PLAN STATUS

AI: 📊 Project Plan Status

   📋 Plan: projectplan-TICKET-123-user-auth-2025-10-24.md
   📝 Requirements: wip/TICKET-123-user-auth.md

   🔄 Synchronization:
   ✅ Last synced: 2025-10-24 10:25 AM
   ✅ Requirements: No changes since sync
   ✅ Plan: No changes since sync
   ✅ Status: IN SYNC

   📈 Progress:
   - Phase 1: [████████░░] 80% (4/5 tasks)
   - Phase 2: [░░░░░░░░░░] 0% (0/6 tasks)
   - Phase 3: [░░░░░░░░░░] 0% (0/4 tasks)
   - Phase 4: [░░░░░░░░░░] 0% (0/3 tasks)

   Overall: 22% complete (4/18 tasks)

   🎯 Current: Phase 1, Task 1.5 - Test user table creation
   ⏭️ Next: Phase 2, Task 2.1 - Implement registration endpoint

   ✅ Ready to proceed!
```

**If Out of Sync:**
```
User: PLAN STATUS

AI: 📊 Project Plan Status

   📋 Plan: projectplan-TICKET-123-user-auth-2025-10-24.md
   📝 Requirements: wip/TICKET-123-user-auth.md

   🔄 Synchronization:
   ⚠️ Last synced: 2025-10-24 09:00 AM
   ⚠️ Requirements: Modified 10:15 AM (75 min ago)
   ⚠️ Plan: Modified 10:20 AM (70 min ago)
   ❌ Status: OUT OF SYNC

   🔍 Detected Changes:
   - Requirements: Added OAuth requirement
   - Plan: Added 3 new tasks for OAuth

   ⚠️ Recommendation: Run SYNC REQUIREMENTS before implementation

   📈 Progress:
   Overall: 0% complete (0/18 tasks)

   🎯 Status: Planning phase
   ⏭️ Next: Sync requirements, then APPROVE PLAN
```

---

## 🎬 Complete Workflow Example

### Scenario: Adding User Authentication

**Step 1: Create Requirements**
```
User: TASK START TICKET-123 user-authentication
AI: [Shows template selection]
User: 1 (feature-development)
AI: ✅ Created: wip/TICKET-123-user-authentication.md

User: [Fills in basic requirements]
      - Users can register with email/password
      - Users can login
      - Sessions expire after 1 hour
```

**Step 2: Generate Initial Plan**
```
User: START

AI: ✅ Reading requirements...
    📋 Creating project plan...

    Created: projectplan-TICKET-123-user-authentication-2025-10-24.md

    4 Phases, 15 tasks, ~2 days

    🔍 Review plan?
```

**Step 3: Iterate on Plan**
```
User: "The session expiry should be 24 hours, not 1 hour.
       Also add rate limiting for login attempts."

AI: ✅ Updated project plan:
    - Changed session expiry to 24 hours
    - Added Phase 2, Task 2.6: Implement rate limiting
    - Added risk: Need to track failed login attempts

    ⚠️ Requirements context now out of sync.
```

**Step 4: Sync Requirements**
```
User: SYNC REQUIREMENTS

AI: 📋 Syncing...

    ✅ Added to requirements:
    - Session expiry: 24 hours (was 1 hour)
    - Rate limiting: 5 attempts = 15min lockout
    - Database needs: failed_login_attempts column

    ✅ Requirements now match plan!
```

**Step 5: User Adds New Requirement**
```
User: [Edits wip/TICKET-123-user-authentication.md]
      [Adds: "Must support OAuth2 Google login"]
```

**Step 6: Update Plan**
```
User: REPLAN

AI: 📋 Re-analyzing...

    ✅ Added to project plan:
    - Phase 2, Task 2.7: Google OAuth integration
    - Phase 4, Task 4.6: OAuth tests
    - +3 hours estimated time

    ⚠️ Run SYNC REQUIREMENTS to update requirements with analysis details.
```

**Step 7: Sync Again**
```
User: SYNC REQUIREMENTS

AI: ✅ Added to requirements:
    - OAuth: Google OAuth2 flow details
    - Redirect URI: /auth/google/callback
    - Required: Google Cloud project setup

    ✅ Synced! Ready for approval.
```

**Step 8: Verify and Approve**
```
User: PLAN STATUS

AI: ✅ Status: IN SYNC
    📊 18 tasks, 2.5 days
    ✅ Ready to implement

User: APPROVE PLAN

AI: ✅ Plan approved and locked!
    🚀 Starting Phase 1...
```

---

## 💡 Best Practices

### When to SYNC REQUIREMENTS

✅ **Do sync:**
- After creating initial project plan
- After making changes to project plan
- Before starting implementation (APPROVE PLAN)
- When you need QA to test against complete requirements

❌ **Don't sync:**
- In the middle of editing requirements
- During active implementation (plan is locked)

### When to REPLAN

✅ **Do replan:**
- After adding new requirements
- When scope changes significantly
- When you discover missing functionality

❌ **Don't replan:**
- For minor wording changes
- During active implementation (would reset progress)
- If you just want to update plan directly

### Sync Frequency

**Recommended pattern:**
```
1. START → Creates plan
2. Review & iterate on plan (ask questions, suggest changes)
3. SYNC REQUIREMENTS (once plan is good)
4. Realize you forgot something
5. Update requirements manually
6. REPLAN (updates plan based on new requirements)
7. SYNC REQUIREMENTS (brings requirements up to date with plan analysis)
8. APPROVE PLAN (lock and implement)
```

---

## 🔒 Plan Locking Behavior

### Before APPROVE PLAN
- ✅ Can update requirements freely
- ✅ Can REPLAN anytime
- ✅ Can SYNC REQUIREMENTS anytime
- ✅ Plan is editable

### After APPROVE PLAN
- ❌ Cannot REPLAN (plan is locked)
- ❌ Cannot SYNC REQUIREMENTS (already locked)
- ✅ Can still update requirements for documentation
- ⚠️ To change scope: Complete current work, then start new task

### To Unlock Plan (Change Scope Mid-Implementation)
```
User: UNLOCK PLAN

AI: ⚠️ Warning: This will reset implementation progress.

    Current progress will be lost:
    - Phase 1: 80% complete (4/5 tasks)

    Are you sure? (yes/no)

User: yes

AI: ✅ Plan unlocked.
    ⚠️ Progress reset to planning phase.

    You can now:
    - Update requirements
    - REPLAN
    - SYNC REQUIREMENTS
    - APPROVE PLAN again
```

---

## 📊 Tracking Changes

### Sync History (Future Enhancement)

AI maintains sync log in project plan:

```markdown
## Sync History

- 2025-10-24 09:00 AM - Initial plan created
- 2025-10-24 09:15 AM - SYNC REQUIREMENTS (added session expiry details)
- 2025-10-24 10:00 AM - REPLAN (added OAuth requirement)
- 2025-10-24 10:05 AM - SYNC REQUIREMENTS (added OAuth flow details)
- 2025-10-24 10:10 AM - APPROVE PLAN (locked for implementation)
```

---

## 🎯 Benefits

### For Developers
✅ Confidence that requirements match design
✅ No surprises during implementation
✅ Clear scope boundaries

### For QA
✅ Complete, accurate requirements for testing
✅ Requirements include implementation details
✅ Can write test cases before code is complete

### For Team
✅ Requirements document becomes single source of truth
✅ Easy handoffs (requirements = plan)
✅ Reduced scope creep

---

## 🔗 Related Commands

- **TASK START** - Begin new task, create requirements
- **START** - Generate initial project plan
- **TASK STATUS** - Check implementation progress
- **TASK COMPLETE** - Finish task, archive

---

[Back to README](../README.md) | [Workflow Commands](workflow-commands-reference.md)
