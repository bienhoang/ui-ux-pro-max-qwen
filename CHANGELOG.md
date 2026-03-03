# Changelog

All notable changes to UI UX Pro Max for Qwen Code.

This project is a port of [UI UX Pro Max](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) for the Qwen Code ecosystem.

## [1.1.0] - 2026-03-03

### Changed

- Remove duplicate command file — SKILL.md is now single source of truth
- Use `/skills ui-ux-pro-max` for explicit invocation (Qwen Code native)
- All script paths use `$HOME/.qwen/` absolute paths for reliability
- Step 3 (domain searches) marked REQUIRED — minimum 2 searches to prevent hallucination
- SKILL.md expanded with Rule Categories, Quick Reference, Persist Design System, Output Formats, Tips

### Removed

- `/design` and `/ui-search` commands (replaced by `/skills ui-ux-pro-max`)
- `.qwen/commands/` directory (no longer needed)

## [1.0.0] - 2026-03-03

### Added

- Port of UI UX Pro Max from Claude Code to Qwen Code (`.claude/` -> `.qwen/`)
- `setup.sh` — curl installer with POSIX-compatible shell script
  - Dependency checks (python3, curl, tar) with OS-specific install guidance
  - Backup-and-swap for safe upgrades of existing `.qwen/`
  - Post-install verification (SKILL.md + search engine smoke test)
  - Temp file cleanup via trap on all exit paths
- 67 UI styles, 96 color palettes, 57 font pairings, 25 chart types
- 13 tech stack guidelines (React, Next.js, Vue, Svelte, SwiftUI, Flutter, etc.)
- 99 UX guidelines and 100 industry-specific reasoning rules
- BM25 + regex hybrid search engine
- `/design` and `/ui-search` custom commands
- Design system persistence (`--persist` flag)

### Changed

- Skill directory structure: `.claude/` renamed to `.qwen/`
- README updated with Qwen Code focus and curl install as primary method
- LICENSE updated with dual copyright (original + port)
- Credits section added to README

### Inherited from upstream

- All design databases (styles, colors, typography, charts, UX guidelines)
- Core search engine (`core.py`, `search.py`, `design_system.py`)
- Stack-specific CSVs (13 frameworks)
