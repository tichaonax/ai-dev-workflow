# How to Enforce YOUR Project Standards with AI

**Problem:** AI makes assumptions and doesn't follow your specific naming conventions, ORM choices, or patterns.

**Solution:** Define your standards in context documents that AI reads BEFORE starting work.

---

## ✅ What We Just Did

Updated `contexts/backend/database-schema-context.md` with YOUR specific rules:

### 🎯 Your Mandatory Standards Now Enforced:

1. **Model Names:** PascalCase (e.g., `ExpenseCategory`)
2. **Table Names:** snake_case (e.g., `expense_categories`)
3. **Column Names:** camelCase (e.g., `firstName`, `createdAt`)
4. **ORM:** Prisma ONLY (no raw SQL without approval)
5. **Migrations:** Generated via `npx prisma migrate dev` (no manual editing)

---

## 📋 How AI Will Now Behave

### Before (Without Context):
```
You: "Add a new User table"

AI: *Creates whatever it wants*
- Maybe uses snake_case columns
- Maybe uses integer IDs instead of UUIDs
- Might write raw SQL
- Might use Sequelize or TypeORM instead of Prisma
```

### After (With Your Context):
```
You: "Add a new User table"

AI: *Reads contexts/backend/database-schema-context.md*

AI Response:
"I'll create a User table following project standards:
- Model: User (PascalCase)
- Table: user (snake_case via @@map)
- Columns: userId (camelCase), firstName (camelCase), etc.
- Standard fields: id (UUID), createdAt, updatedAt
- Using Prisma schema
- Migration via: npx prisma migrate dev --name add_user_table

Here's the schema:
[Shows Prisma schema following YOUR rules]

Should I proceed?"
```

---

## 🚀 How to Use This in Practice

### Method 1: Load Contexts in Every Session

**When starting any database-related task:**

```
You: "I need to add expense categories to the database"

AI: "I'll help with that. Let me read the required contexts first."

You: "Please read these contexts in order:
1. contexts/master-context.md
2. contexts/code-workflow.md
3. contexts/backend/database-schema-context.md

Then create a plan for adding expense categories."

AI: [Reads all contexts, understands your standards]
AI: [Creates plan following PascalCase models, snake_case tables, camelCase columns]
AI: [Uses Prisma, generates migrations properly]
```

### Method 2: Use Templates (Automatic Context Loading)

**Templates already reference the correct contexts:**

```
You: TASK START PROJ-123 add-user-management

AI: [Shows template menu]

You: 1 (feature-development template)

AI: [Creates context file]
[Context file already says to load database-schema-context.md]

You: [Fill context file with requirements]

You: START

AI: [Reads contexts automatically because template told it to]
AI: [Follows all your naming conventions]
```

---

## 📝 Customize for YOUR Project

### Step 1: Review the Updated File

```bash
# Open and review:
contexts/backend/database-schema-context.md
```

**Check:**
- ✅ Naming conventions match your project
- ✅ Required fields match your standards
- ✅ Migration process matches your workflow
- ✅ Examples are relevant

### Step 2: Adjust If Needed

**Example: If you use different ID strategy**

Current:
```prisma
id String @id @default(uuid())  // UUID
```

Change to:
```prisma
id String @id @default(cuid())  // CUID instead
```

**Example: If you use different timestamp naming**

Current:
```prisma
createdAt DateTime @default(now())
updatedAt DateTime @updatedAt
```

Change to:
```prisma
created_at DateTime @default(now())  // Your style
updated_at DateTime @updatedAt
```

### Step 3: Add More Domain-Specific Rules

**Add sections for:**
- Your specific business rules
- Required indexes
- Audit trail patterns
- Multi-tenancy patterns
- Soft delete strategies

---

## 🎯 Other Context Files You Can Customize

### Frontend Standards

**File:** `contexts/frontend/component-context.md`

**Add your rules for:**
- Component naming (e.g., must use `.tsx` extension)
- Props naming (e.g., camelCase always)
- State management (e.g., must use Zustand, not Redux)
- Styling approach (e.g., Tailwind only, no CSS-in-JS)

### API Standards

**File:** `contexts/backend/backend-api-context.md`

**Add your rules for:**
- Endpoint naming (e.g., `/api/v1/resource-name`)
- Response format (e.g., always return `{ data, error, meta }`)
- Error codes (e.g., use RFC 7807 Problem Details)
- Authentication (e.g., JWT in Authorization header)

### Testing Standards

**File:** `contexts/frontend/unit-testing-context.md`

**Add your rules for:**
- Test file naming (e.g., `Component.test.tsx`)
- Test coverage requirements (e.g., minimum 80%)
- Testing library (e.g., Vitest not Jest)
- Assertion style (e.g., expect().toBe() format)

---

## 💡 Pro Tips

### Tip 1: Be Specific with Examples

**Weak:**
```markdown
Use consistent naming
```

**Strong:**
```markdown
Model names MUST be PascalCase:
✅ CORRECT: UserProfile, ExpenseCategory
❌ WRONG: user_profile, expenseCategory
```

### Tip 2: Show Wrong vs Right

**Effective pattern:**
```markdown
// ❌ WRONG - AI will avoid this
model user_profile { }

// ✅ CORRECT - AI will do this
model UserProfile { }
```

### Tip 3: Explain the "Why"

```markdown
Why PascalCase for models?
- Matches TypeScript class naming conventions
- Distinguishes models from variables
- Consistent with Prisma best practices
```

### Tip 4: Add Checklists

```markdown
Before creating database code, verify:
- [ ] Model is PascalCase
- [ ] Table has @@map with snake_case
- [ ] All columns are camelCase
```

---

## 🚨 Common Scenarios

### Scenario 1: AI Suggests Breaking Convention

**AI says:**
```
"I notice the project uses camelCase for columns, but for this
particular table, snake_case would be better because [reason].
Should I deviate from the standard?"
```

**You can:**
- ✅ Approve deviation: "Yes, proceed with snake_case for this table"
- ✅ Reject: "No, follow camelCase standard"
- ✅ Clarify: "Why would snake_case be better here?"

### Scenario 2: AI Doesn't Know a Convention

**AI asks:**
```
"I don't see a standard for enum naming in the database context.
Should I use SCREAMING_SNAKE_CASE or PascalCase?"
```

**You:**
```
"Use PascalCase for enums. Add this to the context:
Enum values: PascalCase (e.g., 'Active', 'Inactive')"
```

**Then update the context file so AI remembers for next time.**

### Scenario 3: New Developer Joins Team

**New dev:**
```
"Should I use snake_case or camelCase for column names?"
```

**You:**
```
"Read contexts/backend/database-schema-context.md
It has all our standards with examples."
```

**Result:** Documentation becomes your team knowledge base.

---

## 📊 Example: Full Database Task with Standards

### 1. User Starts Task
```
You: TASK START PROJ-456 add-user-roles

AI: Which template?
1. feature-development
2. database-schema
[...]

You: 2

AI: Created context file: wip/PROJ-456-add-user-roles.md
Please fill in requirements and type START when ready.
```

### 2. User Fills Context
```markdown
## Session Objective
Add role-based permissions system for users

## Requirements
- Users can have multiple roles
- Roles have specific permissions
- Default role: "User"
```

### 3. User Starts Execution
```
You: START

AI: [Reads contexts in order]
1. master-context.md ✅
2. code-workflow.md ✅
3. database-schema-context.md ✅

AI: Creating project plan following standards:
- Model: UserRole (PascalCase)
- Table: user_roles (snake_case)
- Columns: userId, roleId (camelCase)
- Standard fields: id, createdAt, updatedAt
- Using Prisma schema
- Migration: npx prisma migrate dev --name add_user_roles

[Shows complete plan]

Approval needed to proceed.
```

### 4. AI Follows Standards Exactly
```prisma
model UserRole {
  id        String   @id @default(uuid())
  userId    String
  roleId    String
  createdAt DateTime @default(now())
  updatedAt DateTime @updatedAt

  user User @relation(fields: [userId], references: [id])
  role Role @relation(fields: [roleId], references: [id])

  @@unique([userId, roleId])
  @@map("user_roles")
}
```

**No guessing. No wrong conventions. Just follows YOUR rules.**

---

## ✅ Summary

1. **Your standards are now documented** in `contexts/backend/database-schema-context.md`

2. **AI will read this** before any database work (via templates or manual loading)

3. **AI will follow exactly** or ask for approval to deviate

4. **You can customize** any context file for your specific needs

5. **Team benefits** from documented standards that AI enforces

---

## 🎓 Next Steps

### Immediate:
1. Review `contexts/backend/database-schema-context.md`
2. Adjust any rules that don't match your project
3. Try a simple database task to test

### This Week:
1. Review other context files (API, frontend, testing)
2. Add your project-specific rules
3. Share with team

### Ongoing:
1. Update contexts when standards change
2. Add examples as you discover patterns
3. Use contexts as team documentation

---

**Remember:** The context files are YOUR project's source of truth. AI reads them, follows them, and asks when unsure. Keep them updated and your code stays consistent! 🚀
