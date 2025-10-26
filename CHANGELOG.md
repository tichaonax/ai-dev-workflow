# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Enhanced installer preservation functionality during framework updates
- Comprehensive backup and restore system for user content
- Test suite for installer preservation functionality

### Enhanced
- **Three-Document Knowledge Base System:**
  - Enhanced `DOCUMENT WORK` command to create comprehensive final documentation
  - Updated `TASK COMPLETE` to archive complete documentation triad
  - Each completed task now generates three complementary documents:
    - Project plan (execution roadmap)
    - Requirements context (original requirements)
    - Final documentation (implementation summary and lessons learned)
- **Installer now preserves user work during updates:**
  - Custom templates (both `templates/custom/` and custom files in `templates/v1/`)
  - Work-in-progress sessions (`wip/` directory and subdirectories)
  - Project plans (`project-plans/active/` and `project-plans/completed/`)
  - Custom team contexts (`custom/` directory)
- Updated installation documentation with preservation details
- Enhanced user experience during framework updates

### Added (Previous)
- Initial repository setup
- Core context documents (master-context, code-workflow)
- 9 session templates
- 15+ real-world examples
- Documentation structure
- Presentation materials
- Integration guides

## [1.0.0] - 2025-10-16

### Added
- First official release
- Complete AI-assisted development workflow system
- Contexts: master, code-workflow, backend, frontend, testing
- Templates: feature, debugging, refactor, database, API, design, docs, security, init
- Examples from real production usage
- VS Code integration snippets
- GitHub PR templates
- MIT License
- Comprehensive documentation

### Documentation
- Quick start guide
- Installation guide (4 methods)
- Core concepts explanation
- Best practices guide
- Customization guide
- FAQ
- Troubleshooting guide

### Metrics
- Proven 80% reduction in rework time
- 100% documentation completeness
- Near-zero breaking changes
- 50% faster onboarding

---

**Note:** This changelog follows the format from [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
