# Session Initialization Template

> **Template Type:** Feature Development - Health Monitoring
> **Version:** 1.0
> **Last Updated:** October 17, 2025

---

## 🎯 Purpose

Implement real-time application health monitoring with visual status indicator.

---

## 📋 Required Context Documents

**IMPORTANT:** Before starting this session, load the following context documents **IN THE EXACT ORDER LISTED BELOW**.

### Core Contexts (Load in this EXACT order - ONE AT A TIME)

**CRITICAL:** Read these files sequentially. Do not proceed to the next document until you have fully read and understood the previous one.

1. **FIRST:** `ai-contexts/master-context.md` - General principles and conventions
   - ⚠️ Contains critical instruction to read code-workflow.md
   - ⚠️ Defines operating principles
   - ⚠️ Contains mandatory workflow enforcement
   - ⚠️ Defines example adherence requirements

2. **SECOND:** `ai-contexts/code-workflow.md` - Standard workflow and task tracking
   - Contains MANDATORY workflow requirements
   - Requires creating project plan BEFORE any code changes
   - Defines approval checkpoint process

### Additional Contexts (Load after core contexts)

- `ai-contexts/general-problem-solving-context.md` - Debugging methodology
- `ai-contexts/frontend/ui-context.md` - UI consistency and design system
- `ai-contexts/frontend/component-context.md` - Component architecture patterns
- `ai-contexts/backend/backend-api-context.md` - API design patterns

**Confirm you have loaded these contexts before starting the session.**

---

## 🚀 Session Objective

**JIRA Ticket:** HPP-2451

**Goal:**
Implement a health monitoring system that allows anyone (authenticated or not) to visually verify:

1. Whether the application is currently running
2. How long the application has been up (uptime)
3. If the application has crashed (indicated by no response or downtime)

**Expected Outcome:**
Visual indicator on the homepage showing real-time health status of the application.

**Success Criteria:**

- Health indicator visible without authentication
- Shows green/red status based on server availability
- Displays uptime in human-readable format
- Updates automatically at regular intervals
- Gracefully handles offline/error states

---

## 📝 Session Notes

**Key Requirements:**

- Must be visible on public homepage (no auth required)
- Must show also on the signin and homepage
- Real-time or near-real-time updates (polling every 30-60 seconds)
- Simple, non-intrusive visual design
- Should not impact page load performance

**Technical Considerations:**

- API endpoint must be public (exclude from auth middleware)
- Health check should be lightweight (no heavy DB queries)
- Client-side component should handle network errors gracefully
- Consider caching to avoid excessive server load

**Design Preferences:**

- Minimalist badge/indicator in header or footer
- Color-coded: Green (healthy), Yellow (degraded), Red (offline)
- Show uptime as "Running for: 2d 5h 23m" format
- Optional: Click to expand for detailed metrics

---

## ✅ Start Session

**AI Instructions:**

1. Read the recommended context files listed above
2. Confirm context loading: "✅ Contexts loaded: master-context, code-workflow, general-problem-solving, ui-context, component-context, backend-api-context"
3. Restate the session objective in your own words
4. Create project plan document
5. Perform impact analysis following code-workflow.md guidelines
6. Create a detailed action plan with to-do checklist
7. Identify dependencies, risks, and trade-offs
8. Request confirmation before proceeding with implementation

**User:** Type "START" to begin the session with AI reading contexts and creating the implementation plan.

---
