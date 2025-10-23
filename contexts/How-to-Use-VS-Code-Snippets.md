# How to Use AI Workflow VS Code Snippets

**File:** `integrations/vscode/ai-workflow-snippets.code-snippets`

---

## 📋 What Are These Snippets?

These are **VS Code code snippets** that let you quickly insert AI workflow prompts by typing a short prefix. They save you from typing the same prompts over and over when starting AI sessions.

---

## 🚀 Installation

### Method 1: User Snippets (All Projects)

**Best for:** Using across all your projects

1. **Copy the file to VS Code user snippets:**
   ```bash
   # macOS/Linux
   cp integrations/vscode/ai-workflow-snippets.code-snippets \
      ~/Library/Application\ Support/Code/User/snippets/ai-workflow.code-snippets
   
   # Or manually:
   # 1. Open VS Code
   # 2. Press Cmd+Shift+P (Mac) or Ctrl+Shift+P (Windows/Linux)
   # 3. Type "Snippets: Configure User Snippets"
   # 4. Select "New Global Snippets file"
   # 5. Name it "ai-workflow"
   # 6. Paste the content from the file
   ```

2. **Verify installation:**
   - Create a new Markdown file
   - Type `ai-` and you should see suggestions

### Method 2: Workspace Snippets (Single Project)

**Best for:** This project only

1. **Copy to workspace:**
   ```bash
   mkdir -p .vscode
   cp integrations/vscode/ai-workflow-snippets.code-snippets \
      .vscode/ai-workflow.code-snippets
   ```

2. **Commit to project:**
   ```bash
   git add .vscode/ai-workflow.code-snippets
   git commit -m "Add AI workflow snippets"
   ```

Now everyone on your team gets the snippets automatically!

### Method 3: Manual Install

1. Open VS Code
2. Go to **Code** → **Preferences** → **User Snippets** (Mac)  
   Or **File** → **Preferences** → **User Snippets** (Windows/Linux)
3. Select **New Global Snippets file...**
4. Name it `ai-workflow`
5. Paste the content from `ai-workflow-snippets.code-snippets`
6. Save

---

## 💡 How to Use

### Available Snippets

The file contains **4 snippets**:

| Snippet | Trigger | What It Does |
|---------|---------|--------------|
| **Load Master Context** | `ai-master` | Loads core contexts in correct order |
| **Feature Development** | `ai-feature` | Starts feature development session |
| **Debugging** | `ai-debug` | Starts debugging session |
| **Refactoring** | `ai-refactor` | Starts refactoring session |

---

## 🎯 Using Snippets

### Snippet 1: Load Master Context

**Trigger:** Type `ai-master` and press Tab

**What it inserts:**
```markdown
Please load the following context:

1. **FIRST:** ai-contexts/master-context.md
2. **SECOND:** ai-contexts/code-workflow.md

```

**When to use:**
- Starting any AI session
- Need AI to load core contexts
- Quick way to ensure correct loading order

**Example workflow:**
1. Open VS Code
2. Open GitHub Copilot Chat or create a markdown file
3. Type `ai-master` + Tab
4. Send to AI
5. AI loads the contexts

---

### Snippet 2: Feature Development Template

**Trigger:** Type `ai-feature` and press Tab

**What it inserts:**
```markdown
I need to work on a new feature. Please:

1. Load ai-contexts/templates/v1/feature-development-session-template.md
2. Help me fill it out
3. Follow the workflow strictly

```

**When to use:**
- Building new features
- Adding new screens/pages
- Creating new components
- Implementing new functionality

**Example workflow:**
1. Type `ai-feature` + Tab
2. Send to AI
3. AI loads template and asks questions
4. Fill in details interactively
5. AI creates project plan

---

### Snippet 3: Debugging Template

**Trigger:** Type `ai-debug` and press Tab

**What it inserts:**
```markdown
I need to debug an issue. Please:

1. Load ai-contexts/templates/v1/debugging-session-template.md
2. Help me fill it out
3. Follow the workflow strictly

```

**When to use:**
- Investigating bugs
- Fixing errors
- Troubleshooting issues
- Understanding unexpected behavior

**Example workflow:**
1. Encounter a bug
2. Type `ai-debug` + Tab
3. Send to AI
4. Describe the issue
5. AI guides debugging process

---

### Snippet 4: Refactoring Template

**Trigger:** Type `ai-refactor` and press Tab

**What it inserts:**
```markdown
I need to refactor code. Please:

1. Load ai-contexts/templates/v1/refactor-optimization-session-template.md
2. Help me fill it out
3. Follow the workflow strictly

```

**When to use:**
- Improving code quality
- Optimizing performance
- Modernizing code
- Restructuring components

**Example workflow:**
1. Identify code to refactor
2. Type `ai-refactor` + Tab
3. Send to AI
4. Explain what needs refactoring
5. AI creates refactoring plan

---

## 📺 Step-by-Step Demo

### Using with GitHub Copilot Chat

1. **Open Copilot Chat:**
   - Press `Cmd+Shift+I` (Mac) or `Ctrl+Shift+I` (Windows/Linux)
   - Or click the chat icon in the sidebar

2. **Type snippet trigger:**
   ```
   ai-feature
   ```

3. **Press Tab:**
   - Snippet expands automatically

4. **Press Enter to send:**
   - AI receives the prompt
   - AI loads the template
   - AI asks questions to fill out template

5. **Interact with AI:**
   - Answer questions
   - Review project plan
   - Approve phases

### Using in Markdown Files

1. **Create a session document:**
   ```bash
   # Create work-in-progress folder
   mkdir -p ai-contexts/wip
   
   # Create session file
   touch ai-contexts/wip/my-feature-session.md
   ```

2. **Open in VS Code:**
   ```bash
   code ai-contexts/wip/my-feature-session.md
   ```

3. **Use snippet:**
   - Type `ai-feature` + Tab
   - Snippet content appears
   - Copy and paste to AI chat
   - Or save and reference file to AI

4. **Continue session:**
   - AI fills template with you
   - Save all interactions in this file
   - Keep as documentation

---

## ⚙️ Customizing Snippets

### Add Your Own Snippets

Edit the file and add new snippets:

```json
{
  "Your Custom Snippet": {
    "prefix": "ai-custom",
    "body": [
      "Your custom text here",
      "Line 2",
      "Line 3"
    ],
    "description": "What this snippet does"
  }
}
```

### Useful Custom Snippets to Add

#### Database Schema Session
```json
{
  "Database Schema Template": {
    "prefix": "ai-database",
    "body": [
      "I need to work on database changes. Please:",
      "",
      "1. Load ai-contexts/templates/v1/database-schema-session-template.md",
      "2. Help me fill it out",
      "3. Follow the workflow strictly",
      ""
    ],
    "description": "Start database schema session"
  }
}
```

#### API Endpoint Session
```json
{
  "API Endpoint Template": {
    "prefix": "ai-api",
    "body": [
      "I need to create/update an API endpoint. Please:",
      "",
      "1. Load ai-contexts/templates/v1/api-endpoint-session-template.md",
      "2. Help me fill it out",
      "3. Follow the workflow strictly",
      ""
    ],
    "description": "Start API endpoint session"
  }
}
```

#### Load All Contexts
```json
{
  "Load All Contexts": {
    "prefix": "ai-all",
    "body": [
      "Please load the following contexts in order:",
      "",
      "1. **FIRST:** ai-contexts/master-context.md",
      "2. **SECOND:** ai-contexts/code-workflow.md",
      "3. Backend: ai-contexts/backend/backend-api-context.md",
      "4. Frontend: ai-contexts/frontend/component-context.md",
      ""
    ],
    "description": "Load all core contexts"
  }
}
```

---

## 🎨 Snippet Variables

VS Code snippets support variables. You can make them more dynamic:

```json
{
  "Feature with Details": {
    "prefix": "ai-feature-full",
    "body": [
      "I need to work on a new feature. Please:",
      "",
      "1. Load ai-contexts/templates/v1/feature-development-session-template.md",
      "2. Help me fill it out",
      "3. Follow the workflow strictly",
      "",
      "Feature: ${1:feature-name}",
      "Ticket: ${2:JIRA-123}",
      "Description: ${3:description}",
      "$0"
    ],
    "description": "Start feature with placeholders"
  }
}
```

When you trigger this, you can tab through the placeholders:
1. Type feature name
2. Tab to ticket number
3. Tab to description
4. Tab to end

---

## 💡 Pro Tips

### Tip 1: Combine with File Watchers

When you type a snippet in Copilot Chat, it immediately sends to AI. Super fast workflow!

### Tip 2: Create Snippet for Your Most Common Tasks

Track what you do most often and create snippets:
- `ai-bug` - Bug fix sessions
- `ai-test` - Adding tests
- `ai-doc` - Documentation
- `ai-review` - Code review

### Tip 3: Share with Team

If using workspace snippets (Method 2), everyone gets them automatically when they clone!

### Tip 4: Use in Combination

```markdown
# Type ai-master first
Please load the following context:
1. **FIRST:** ai-contexts/master-context.md
2. **SECOND:** ai-contexts/code-workflow.md

# Then type ai-feature
I need to work on a new feature. Please:
1. Load ai-contexts/templates/v1/feature-development-session-template.md
...
```

### Tip 5: Keyboard Shortcuts

Set up keyboard shortcuts for common snippets:

1. Open **Preferences** → **Keyboard Shortcuts**
2. Search for "Insert Snippet"
3. Add keybinding:
   - `Cmd+K, Cmd+M` = ai-master
   - `Cmd+K, Cmd+F` = ai-feature
   - `Cmd+K, Cmd+D` = ai-debug

---

## 🔧 Troubleshooting

### Snippets Not Appearing

**Problem:** Type `ai-` but no suggestions appear

**Solutions:**
1. **Check file location:**
   ```bash
   # Should exist:
   ls ~/Library/Application\ Support/Code/User/snippets/ai-workflow.code-snippets
   ```

2. **Restart VS Code:**
   ```bash
   # Quit and reopen VS Code
   ```

3. **Check snippet syntax:**
   - JSON must be valid
   - Use online JSON validator

4. **Enable suggestions:**
   - Open VS Code settings
   - Search for "suggest"
   - Ensure "Editor: Quick Suggestions" is enabled

### Snippets Not Expanding

**Problem:** Type `ai-master` but nothing happens

**Solutions:**
1. **Press Tab (not Enter):**
   - Type `ai-master`
   - Press **Tab** key

2. **Check file type:**
   - Snippets may be scoped to Markdown
   - Try in a `.md` file

3. **Try prefix completion:**
   - Type `ai-`
   - Press `Ctrl+Space` to see all snippets

### Wrong Content Inserted

**Problem:** Snippet inserts but content is wrong

**Solutions:**
1. **Check you're using latest version:**
   ```bash
   cat ~/Library/Application\ Support/Code/User/snippets/ai-workflow.code-snippets
   ```

2. **Re-copy the file:**
   ```bash
   cp integrations/vscode/ai-workflow-snippets.code-snippets \
      ~/Library/Application\ Support/Code/User/snippets/ai-workflow.code-snippets
   ```

---

## 📚 Additional Resources

### VS Code Snippet Documentation
- [Official VS Code Snippets Guide](https://code.visualstudio.com/docs/editor/userdefinedsnippets)
- [Snippet Variables Reference](https://code.visualstudio.com/docs/editor/userdefinedsnippets#_variables)

### Where Snippets Are Stored

**macOS:**
```
~/Library/Application Support/Code/User/snippets/
```

**Linux:**
```
~/.config/Code/User/snippets/
```

**Windows:**
```
%APPDATA%\Code\User\snippets\
```

---

## ✅ Quick Reference Card

Print this and keep it handy!

```
╔══════════════════════════════════════════╗
║   AI WORKFLOW VS CODE SNIPPETS          ║
╠══════════════════════════════════════════╣
║                                          ║
║  ai-master    →  Load core contexts     ║
║  ai-feature   →  Feature development    ║
║  ai-debug     →  Debugging session      ║
║  ai-refactor  →  Refactoring session    ║
║                                          ║
║  Type prefix + TAB to expand            ║
║                                          ║
╚══════════════════════════════════════════╝
```

---

## 🎉 You're Ready!

Now you can:
- ✅ Quickly start AI sessions with snippets
- ✅ Save time typing repetitive prompts
- ✅ Ensure consistent workflow startup
- ✅ Share snippets with your team
- ✅ Customize for your needs

**Try it now:**
1. Install the snippets
2. Open VS Code
3. Type `ai-master` + Tab
4. See the magic! ✨

---

**Need help?** See [FAQ](../../docs/faq.md) or [Troubleshooting](../../docs/troubleshooting.md)
