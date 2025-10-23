# Contributing to AI-Assisted Development Workflow

First off, thank you for considering contributing to AI-Assisted Development Workflow! It's people like you that make this system better for everyone.

---

## 📋 Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How Can I Contribute?](#how-can-i-contribute)
- [Getting Started](#getting-started)
- [Contribution Guidelines](#contribution-guidelines)
- [Style Guidelines](#style-guidelines)
- [Commit Messages](#commit-messages)
- [Pull Request Process](#pull-request-process)

---

## 📜 Code of Conduct

This project and everyone participating in it is governed by basic principles of respect and professionalism:

- **Be respectful** - Treat everyone with respect
- **Be collaborative** - Help others succeed
- **Be patient** - Remember everyone is learning
- **Be constructive** - Provide helpful feedback

---

## 🤝 How Can I Contribute?

### 1. Share Your Session Templates

**Most valuable contribution!**

If you've used the workflow for a project, share your filled template:

```bash
# 1. Remove sensitive information (company names, internal details)
# 2. Generalize the example
# 3. Add it to examples/ folder
# 4. Submit PR
```

**What makes a good example:**
- ✅ Complete workflow from start to finish
- ✅ Shows real problems and solutions
- ✅ Includes approval checkpoints
- ✅ Has meaningful context
- ✅ Demonstrates best practices

### 2. Add New Context Documents

Create contexts for new tech stacks:

- Python/Django patterns
- Java/Spring Boot conventions
- Ruby on Rails standards
- Go best practices
- Mobile development (iOS/Android)
- DevOps patterns

**Format:**
```markdown
# [Technology] Coding Patterns

## Style Guidelines
- [Style rule 1]
- [Style rule 2]

## Best Practices
- [Practice 1]
- [Practice 2]

## Common Patterns
```

### 3. Create New Templates

Add templates for new session types:

- Performance optimization
- Accessibility review
- Infrastructure setup
- CI/CD pipeline
- Testing strategy
- Code review

**Use existing templates as reference**

### 4. Improve Documentation

- Fix typos
- Add clarifications
- Include examples
- Improve explanations
- Add diagrams
- Create videos

### 5. Report Issues

Found something wrong? Let us know!

- Bug in template
- Confusing documentation
- Missing context
- Workflow gap

### 6. Answer Questions

Help others in:
- GitHub Discussions
- Issue comments
- Pull request reviews

---

## 🚀 Getting Started

### Fork and Clone

```bash
# 1. Fork the repository on GitHub
# 2. Clone your fork
git clone https://github.com/YOUR-USERNAME/ai-dev-workflow.git
cd ai-dev-workflow

# 3. Add upstream remote
git remote add upstream https://github.com/tichaonax/ai-dev-workflow.git

# 4. Create a branch
git checkout -b feature/my-contribution
```

### Make Your Changes

```bash
# Edit files...

# Test your changes
# - Read through your changes
# - Verify formatting
# - Check links work
# - Test with AI if applicable
```

### Submit Pull Request

```bash
# Commit your changes
git add .
git commit -m "Add: Python Django context document"

# Push to your fork
git push origin feature/my-contribution

# Create Pull Request on GitHub
```

---

## 📝 Contribution Guidelines

### For Session Template Examples

**Checklist:**
- [ ] Remove all sensitive information (names, companies, internal systems)
- [ ] Generalize the scenario (make it applicable to others)
- [ ] Include all workflow sections
- [ ] Show approval checkpoints
- [ ] Demonstrate incremental implementation
- [ ] Include final results/outcomes
- [ ] Add to appropriate `examples/` subfolder
- [ ] Update examples README if needed

**File naming:**
```
EXAMPLE-[template-type]-[brief-description].md

Examples:
- EXAMPLE-feature-development-payment-integration.md
- EXAMPLE-debugging-memory-leak.md
- EXAMPLE-refactor-api-modernization.md
```

### For Context Documents

**Checklist:**
- [ ] Clear, actionable guidelines
- [ ] Organized in logical sections
- [ ] Includes code examples
- [ ] Explains "why" not just "what"
- [ ] References official documentation where applicable
- [ ] Follows existing context format
- [ ] Added to `contexts/` with appropriate subfolder
- [ ] Updated master context if needed

**File naming:**
```
[technology]-[aspect]-context.md

Examples:
- python-django-context.md
- java-spring-testing-context.md
- react-native-context.md
```

### For Templates

**Checklist:**
- [ ] Follows existing template structure
- [ ] Includes context loading section
- [ ] Has clear task description sections
- [ ] Includes success criteria
- [ ] Has approval checkpoint markers
- [ ] Contains documentation section
- [ ] Added to `templates/v1/`
- [ ] Includes filled example in `examples/` (add filled examples to the top-level `examples/` directory)

**File naming:**
```
[purpose]-session.md

Examples:
- performance-optimization-session.md
- accessibility-review-session.md
- infrastructure-setup-session.md
```

### For Documentation

**Checklist:**
- [ ] Clear and concise writing
- [ ] Includes examples
- [ ] Uses proper Markdown formatting
- [ ] Links to related docs
- [ ] Tested procedures work
- [ ] Added to `docs/` folder
- [ ] Updated main README if needed

---

## 🎨 Style Guidelines

### Markdown Style

**Headers:**
```markdown
# H1 - Document Title (once per file)
## H2 - Major Sections
### H3 - Subsections
#### H4 - Details
```

**Emphasis:**
```markdown
**Bold** for important terms
*Italic* for emphasis
`Code` for file names, commands, code snippets
```

**Lists:**
```markdown
- Unordered list item
  - Nested item

1. Ordered list item
2. Second item
```

**Code Blocks:**
````markdown
```bash
# Commands with language specified
git commit -m "Message"
```

```javascript
// Code examples with syntax highlighting
const example = "value";
```
````

**Links:**
```markdown
[Link Text](relative/path/to/file.md)
[External Link](https://example.com)
```

### Template Style

**Context Loading Section:**
```markdown
### Core Contexts (Load in this EXACT order - ONE AT A TIME)

1. **FIRST:** `ai-contexts/master-context.md`
   - ⚠️ Contains critical instructions
   
2. **SECOND:** `ai-contexts/code-workflow.md`
   - Contains MANDATORY workflow requirements
```

**Approval Checkpoints:**
```markdown
## ⏸️ APPROVAL CHECKPOINT #1

**AI:** STOP here and wait for approval.

**Review Questions:**
- [ ] Does the plan make sense?
- [ ] Are phases logical?
```

**Section Headers:**
```markdown
## 📋 Section Title
## 🎯 Goals
## 📁 Files
## ⏸️ Checkpoint
## ✅ Completion
```

### Context Document Style

**Structure:**
```markdown
# [Technology] Context

## Overview
Brief description of what this covers

## Coding Standards
### Style Guidelines
- Rule 1
- Rule 2

### Best Practices
- Practice 1
- Practice 2

## Common Patterns
### Pattern Name
Description and example

## Testing
Requirements and examples

## References
- [Official Docs](url)
```

---

## 💬 Commit Messages

### Format

```
Type: Brief description (50 chars max)

Detailed explanation of what changed and why.
- Can include bullet points
- Multiple lines
- Links to issues

Fixes #123
```

### Types

- **Add:** New file, template, context, example
- **Update:** Modify existing content
- **Fix:** Bug fix, typo, error correction
- **Docs:** Documentation changes
- **Refactor:** Reorganize without changing functionality
- **Remove:** Delete obsolete content

### Examples

**Good:**
```
Add: Python Django context document

Adds comprehensive context for Django projects including:
- Django ORM patterns
- View/URL conventions
- Testing with pytest-django
- Common middleware patterns

Closes #45
```

```
Fix: Typo in feature-development template

Corrected "procede" to "proceed" in approval checkpoint #2
```

```
Update: Clarify approval checkpoint language

Made checkpoint instructions more explicit to prevent
AI from continuing without explicit approval.
```

**Bad:**
```
update stuff
```

```
Fixed things
```

```
Added Python context because it was needed
```

---

## 🔄 Pull Request Process

### 1. Before Submitting

- ✅ Test your changes
- ✅ Update relevant documentation
- ✅ Add examples if applicable
- ✅ Check for typos
- ✅ Verify all links work
- ✅ Follow style guidelines

### 2. Pull Request Title

```
Type: Brief description

Examples:
Add: Python Django context document
Fix: Broken link in quick-start guide
Update: Improve debugging template clarity
Docs: Add video tutorial link
```

### 3. Pull Request Description

**Template:**
```markdown
## Description
What does this PR do?

## Type of Change
- [ ] New template
- [ ] New context
- [ ] New example
- [ ] Documentation update
- [ ] Bug fix
- [ ] Other (describe):

## Checklist
- [ ] Followed style guidelines
- [ ] Tested changes
- [ ] Updated documentation
- [ ] Added examples if applicable
- [ ] All links work

## Related Issues
Fixes #123
Related to #456

## Additional Context
Any other information that reviewers should know.
```

### 4. Review Process

1. **Automated checks** run (if configured)
2. **Maintainer reviews** your PR
3. **Feedback** may be requested
4. **Iterate** based on feedback
5. **Merge** once approved

### 5. After Merge

- ✅ Delete your branch
- ✅ Pull latest from upstream
- ✅ Celebrate! 🎉

---

## 🎯 Priority Contributions

We especially need:

### High Priority
1. **Python/Django context** - High demand
2. **Java/Spring Boot context** - Requested by multiple users
3. **More debugging examples** - Real-world scenarios
4. **Video tutorials** - Visual learning materials
5. **VS Code extension** - Better IDE integration

### Medium Priority
6. Mobile development contexts (iOS/Android)
7. DevOps/Infrastructure templates
8. More API integration examples
9. Accessibility review template
10. Translations (Spanish, French, etc.)

### Always Welcome
- Bug fixes
- Documentation improvements
- Example refinements
- Question answers in Discussions

---

## ❓ Questions?

**Not sure about something?**

1. Check existing issues/PRs
2. Ask in [GitHub Discussions](https://github.com/tichaonax/ai-dev-workflow/discussions)
3. Open a draft PR and ask for feedback
4. Tag maintainers in comments

**Common questions:**

**Q: Can I contribute even if I'm new to this workflow?**  
A: Yes! Share your learning experience, improve beginner docs.

**Q: Do contributions need to be perfect?**  
A: No! Submit and we'll help refine through review.

**Q: Can I contribute examples from work projects?**  
A: Yes, but remove all sensitive/proprietary information first.

**Q: How long until my PR is reviewed?**  
A: Usually within 1-3 days. Be patient, maintainers volunteer their time.

---

## 🏆 Recognition

Contributors will be:

- ✅ Listed in README
- ✅ Credited in release notes
- ✅ Thanked in announcements
- ✅ Given contributor badge
- ✅ Mentioned in presentations

---

## 📜 License

By contributing, you agree that your contributions will be licensed under the same MIT License that covers the project.

---

## 🙏 Thank You!

Every contribution, no matter how small, makes this project better for everyone.

**Your time and effort are appreciated!** 🎉

---

**Ready to contribute?** Pick an issue labeled `good first issue` or `help wanted` and get started!

[Back to README](README.md) | [View Issues](https://github.com/tichaonax/ai-dev-workflow/issues) | [Start Discussion](https://github.com/tichaonax/ai-dev-workflow/discussions)
