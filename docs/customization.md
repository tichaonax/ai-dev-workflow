# Customization Guide

> How to adapt the AI Development Workflow System to your team's needs

---

## Table of Contents

- [Overview](#overview)
- [Customizing Contexts](#customizing-contexts)
- [Creating Custom Templates](#creating-custom-templates)
- [Adapting Workflow Commands](#adapting-workflow-commands)
- [Team-Specific Standards](#team-specific-standards)
- [Integration Customization](#integration-customization)
- [Examples](#examples)

---

## Overview

The AI Development Workflow System is designed to be customizable. You can:

- ✅ Add your own context documents
- ✅ Create custom session templates
- ✅ Modify existing contexts for your stack
- ✅ Add team-specific conventions
- ✅ Customize VS Code snippets
- ✅ Adapt for different programming languages

**Golden Rule:** Don't modify core contexts (`master-context.md`, `code-workflow.md`). Instead, create additional contexts that complement them.

---

## Customizing Contexts

### Adding Team-Specific Contexts

Create new contexts in `ai-contexts/contexts/custom/`:

```bash
mkdir -p ai-contexts/contexts/custom
```

**Example: Payment Processing Context**

```markdown
# Payment Processing Context

## Purpose
Guidelines for implementing payment features using Stripe

## Our Stripe Integration Pattern

### Always Use Idempotency Keys
```typescript
// ✅ Correct: Always include idempotency key
const payment = await stripe.paymentIntents.create({
  amount: 1000,
  currency: 'usd'
}, {
  idempotencyKey: `payment_${orderId}_${Date.now()}`
});
```

### Error Handling Pattern
```typescript
// ✅ Our standard error handling
try {
  const payment = await processPayment(order);
} catch (error) {
  if (error.type === 'StripeCardError') {
    // User-facing error
    return { error: error.message };
  } else {
    // Log and alert ops team
    logger.error('Payment processing failed', { error, orderId });
    alertOps('Payment failure', { orderId });
    return { error: 'Payment processing failed' };
  }
}
```

## Webhook Verification
Always verify webhook signatures...

## Testing
Use Stripe test mode with these test cards...
```

**Save as:** `ai-contexts/contexts/custom/payment-processing-context.md`

### Adding Tech Stack Contexts

**Example: Your Specific Framework**

```markdown
# Next.js App Router Context

## Purpose
Our Next.js 14 App Router conventions and patterns

## File Structure
```
app/
├── (dashboard)/           # Route groups
│   ├── layout.tsx        # Shared layout
│   └── page.tsx          # Dashboard page
├── api/
│   └── users/
│       └── route.ts      # API route handler
└── layout.tsx            # Root layout
```

## Server Components (Default)
```typescript
// ✅ Server component - fetch data directly
async function UserList() {
  const users = await db.user.findMany();
  return <div>{users.map(...)}</div>
}
```

## Client Components (When Needed)
```typescript
'use client';  // ✅ Must be first line

import { useState } from 'react';

export function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(count + 1)}>{count}</button>
}
```

## Our Conventions
- Use server components by default
- Client components only for interactivity
- Server actions for mutations
- Parallel routes for modals
```

**Save as:** `ai-contexts/contexts/frontend/nextjs-app-router-context.md`

### Customizing Existing Contexts

**Don't edit:** The original context files
**Instead:** Create override files

```markdown
# Component Context Overrides

## Purpose
Team-specific additions to component-context.md

## Additional Requirements

### Component File Naming
```
✅ UserProfile.tsx       (PascalCase, matches component name)
❌ user-profile.tsx
❌ UserProfileComponent.tsx
```

### Props Interface Naming
```typescript
✅ interface UserProfileProps { ... }
❌ interface Props { ... }
❌ interface IUserProfileProps { ... }
```

### Export Pattern
```typescript
// ✅ Named export (not default)
export function UserProfile(props: UserProfileProps) {
  ...
}
```
```

**Save as:** `ai-contexts/contexts/custom/component-overrides-context.md`

**Load both:**
```
1. ai-contexts/contexts/frontend/component-context.md
2. ai-contexts/contexts/custom/component-overrides-context.md
```

---

## Creating Custom Templates

### When to Create a Template

Create a custom template when:
- Your team has a recurring task type
- You want to standardize requirements gathering
- You have a specific workflow

### Template Structure

```markdown
# {Task Type} Session Template

> **Template Type:** {Brief Description}
> **Version:** 1.0
> **Last Updated:** {Date}

---

## 🎯 Purpose

{What this template is for}

---

## 📋 Required Context Documents

**IMPORTANT:** Load these contexts before starting:

1. **FIRST:** `ai-contexts/contexts/master-context.md`
2. **SECOND:** `ai-contexts/contexts/code-workflow.md`
3. **THIRD:** `ai-contexts/contexts/custom/{your-context}.md`

---

## 🚀 Session Objective

**Ticket:** <!-- e.g., PROJ-123 -->

**{Field 1}:**

**{Field 2}:**

---

## 📐 Technical Requirements

**{Requirement Category}:**

---

## 🧪 Testing Requirements

**{Test Category}:**

---

## ✅ Start Session

Ready to begin. Please:
1. {Step 1}
2. {Step 2}
```

### Example: Database Migration Template

```markdown
# Database Migration Session Template

> **Template Type:** Database Schema Changes & Migrations
> **Version:** 1.0
> **Last Updated:** 2025-10-22

---

## 🎯 Purpose

For creating database migrations, schema changes, or data migrations.

---

## 📋 Required Context Documents

1. `ai-contexts/contexts/master-context.md`
2. `ai-contexts/contexts/code-workflow.md`
3. `ai-contexts/contexts/backend/database-schema-context.md`

---

## 🚀 Session Objective

**Ticket:** <!-- e.g., PROJ-123 -->

**Migration Type:** <!-- Schema change / Data migration / Index addition / etc. -->

**Goal:**

**Expected Outcome:**

**Success Criteria:**
- [ ] Migration runs successfully
- [ ] Rollback tested and works
- [ ] No data loss
- [ ] Performance impact assessed

---

## 📐 Database Details

**Tables Affected:**

**New Columns/Tables:**

**Indexes to Add/Remove:**

**Foreign Keys:**

**Data Transformations:**

---

## 🔄 Migration Strategy

**Downtime Required:** <!-- Yes/No, how long -->

**Rollback Plan:**

**Data Backup:**

**Order of Operations:**
1.
2.
3.

---

## 🧪 Testing Requirements

**Test Cases:**
- [ ] Migration completes successfully
- [ ] Rollback completes successfully
- [ ] Existing data integrity maintained
- [ ] Application still works after migration

**Performance Testing:**
- Expected migration duration:
- Impact on production queries:

---

## ✅ Start Session

Ready to begin migration planning.
```

**Save as:** `ai-contexts/templates/v1/database-migration-session.md`

---

## Adapting Workflow Commands

### Adding Custom Commands

Edit `ai-contexts/contexts/master-context.md` (or create custom commands context):

```markdown
## Custom Team Commands

### `REVIEW PR {pr-number}`
**AI Actions:**
1. Read the PR diff
2. Check against team standards
3. Identify potential issues
4. Suggest improvements

### `CREATE CHANGELOG`
**AI Actions:**
1. Read completed project plans from last sprint
2. Generate changelog entries
3. Group by feature/fix/chore
4. Format for release notes
```

### Customizing Existing Commands

Create `custom-workflow-commands-context.md`:

```markdown
# Custom Workflow Commands

## TASK COMPLETE Modifications

In addition to standard TASK COMPLETE:

**AI Actions:**
5. Generate performance metrics (if applicable)
6. Create Slack notification template
7. Update team dashboard file

## TASK STATUS Enhancements

**AI Actions:**
4. Show velocity (tasks per day)
5. Compare to sprint goal
6. Highlight blockers
```

---

## Team-Specific Standards

### Code Style Standards

```markdown
# Team Code Style Context

## Import Order
```typescript
// 1. External libraries
import React from 'react';
import { useQuery } from '@tanstack/react-query';

// 2. Internal utilities
import { formatDate } from '@/lib/utils';

// 3. Components
import { Button } from '@/components/ui/button';

// 4. Types
import type { User } from '@/types';

// 5. Styles (if any)
import styles from './component.module.css';
```

## Variable Naming
- Booleans: `isLoading`, `hasPermission`, `canEdit`
- Arrays: plural (`users`, `items`, `products`)
- Functions: verb + noun (`getUserById`, `createOrder`)

## Comment Style
```typescript
// ✅ Explain WHY, not WHAT
// Retrying here because API has rate limiting
await retryWithBackoff(apiCall);

// ❌ Don't state the obvious
// Increment counter
counter++;
```
```

### Testing Standards

```markdown
# Team Testing Context

## Test File Naming
```
src/
└── components/
    ├── UserProfile.tsx
    └── UserProfile.test.tsx  ✅ (Same name + .test)
```

## Test Structure (AAA Pattern)
```typescript
describe('UserProfile', () => {
  it('displays user name', () => {
    // Arrange
    const user = { name: 'John Doe' };

    // Act
    render(<UserProfile user={user} />);

    // Assert
    expect(screen.getByText('John Doe')).toBeInTheDocument();
  });
});
```

## Coverage Requirements
- Unit tests: 80% minimum
- Integration tests: Critical paths only
- E2E tests: Happy path + error cases
```

---

## Integration Customization

### VS Code Snippets

Customize `ai-contexts/integrations/vscode/ai-workflow-commands.code-snippets`:

```json
{
  "Team Task Start": {
    "prefix": "team-task-start",
    "body": [
      "TASK START ${1:TICKET-ID} ${2:description}",
      "",
      "**Context to load:**",
      "- master-context.md",
      "- code-workflow.md",
      "- custom/${3:your-context}.md"
    ],
    "description": "Start task with team contexts"
  },

  "Team Review Checklist": {
    "prefix": "team-review",
    "body": [
      "## Code Review Checklist",
      "- [ ] Follows team naming conventions",
      "- [ ] Tests added and passing",
      "- [ ] No console.logs or debugger",
      "- [ ] Comments explain WHY not WHAT",
      "- [ ] Updated relevant documentation"
    ],
    "description": "Team code review checklist"
  }
}
```

### GitHub PR Template

Customize `.github/PULL_REQUEST_TEMPLATE.md`:

```markdown
## Description
{What does this PR do}

## Project Plan
- [ ] Project plan created: `ai-contexts/project-plans/active/projectplan-XXX-YYY.md`
- [ ] All tasks completed and checkboxes marked

## Type of Change
- [ ] Feature
- [ ] Bug fix
- [ ] Refactor
- [ ] Documentation

## Testing
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] Manual testing completed

## Team Standards
- [ ] Follows team code style context
- [ ] Follows team testing context
- [ ] Updated team documentation (if applicable)

## Deployment
- [ ] Database migrations (if applicable)
- [ ] Environment variables (if applicable)
- [ ] Rollback plan documented

## Related Issues
Closes #{issue-number}

## Project Plan Reference
See `ai-contexts/project-plans/active/projectplan-{TICKET}-{feature}-{date}.md` for full implementation details.
```

---

## Examples

### Example 1: Monorepo Customization

```markdown
# Monorepo Context

## Our Structure
```
/packages
  /web         (Next.js app)
  /mobile      (React Native)
  /api         (Node.js API)
  /shared      (Shared utilities)
```

## Import Rules
```typescript
// ✅ Use workspace protocol
import { Button } from '@repo/shared';

// ❌ Don't use relative paths across packages
import { Button } from '../../../shared/components/Button';
```

## Task Scoping
When starting a task, specify affected packages:

**Ticket:** MONO-123
**Affected Packages:** web, shared
**Cross-Package Impact:** Yes - updating shared Button affects web
```

### Example 2: Microservices Customization

```markdown
# Microservices Context

## Our Services
- `auth-service` - Authentication (Port 3001)
- `user-service` - User management (Port 3002)
- `order-service` - Order processing (Port 3003)

## Inter-Service Communication
```typescript
// ✅ Use service client
import { userServiceClient } from '@/clients/user-service';
const user = await userServiceClient.getById(userId);

// ❌ Don't make direct HTTP calls
const response = await fetch('http://localhost:3002/users/' + userId);
```

## Project Plans for Services
Always specify which service(s) in project plan:

**Services Affected:** auth-service, user-service
**API Changes:** auth-service exposes new endpoint
**Database Changes:** user-service adds table
```

### Example 3: Python Project Customization

```markdown
# Python Project Context

## Our Stack
- Python 3.11+
- FastAPI for APIs
- SQLAlchemy for ORM
- Pytest for testing

## File Naming
```
✅ user_service.py        (snake_case)
✅ test_user_service.py   (test_ prefix)
```

## Import Organization
```python
# 1. Standard library
import os
from typing import List

# 2. Third-party
from fastapi import FastAPI
from sqlalchemy import select

# 3. Local
from app.models import User
from app.utils import format_date
```

## Type Hints Required
```python
# ✅ With type hints
def get_user(user_id: int) -> User | None:
    return db.query(User).filter(User.id == user_id).first()

# ❌ No type hints
def get_user(user_id):
    return db.query(User).filter(User.id == user_id).first()
```
```

---

## Next Steps

1. Identify your team's unique patterns
2. Create custom contexts for them
3. Share with your team
4. Iterate based on feedback
5. Contribute back to the main project

---

[Back to README](../README.md) | [Core Concepts](concepts.md) | [Best Practices](best-practices.md)
