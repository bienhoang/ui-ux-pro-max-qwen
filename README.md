# UI UX Pro Max for Qwen Code

<p align="center">
  <img src="https://img.shields.io/badge/UI_styles-67-purple?style=for-the-badge" alt="67 UI Styles">
  <img src="https://img.shields.io/badge/palettes-96-blue?style=for-the-badge" alt="96 Color Palettes">
  <img src="https://img.shields.io/badge/font_pairings-57-teal?style=for-the-badge" alt="57 Font Pairings">
  <img src="https://img.shields.io/badge/python-3.x-yellow?style=for-the-badge&logo=python&logoColor=white" alt="Python 3.x">
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License"></a>
</p>

An AI skill for [Qwen Code](https://qwenlm.github.io/blog/qwen-code/) that provides design intelligence for building professional UI/UX. Uses a BM25 + regex hybrid search engine with 100 industry-specific reasoning rules to generate complete, tailored design systems.

## Features

- **67 UI Styles** — Glassmorphism, Claymorphism, Minimalism, Brutalism, Neumorphism, Bento Grid, Dark Mode, AI-Native UI, and more
- **96 Color Palettes** — Industry-specific palettes for SaaS, E-commerce, Healthcare, Fintech, Beauty, etc.
- **57 Font Pairings** — Curated typography combinations with Google Fonts imports
- **25 Chart Types** — Recommendations for dashboards and analytics
- **13 Tech Stacks** — React, Next.js, Vue, Svelte, SwiftUI, React Native, Flutter, HTML+Tailwind, shadcn/ui, Jetpack Compose, Astro, Nuxt.js, Nuxt UI
- **99 UX Guidelines** — Best practices, anti-patterns, and accessibility rules
- **100 Reasoning Rules** — Industry-specific design system generation

## Installation

1. Clone or copy the `.qwen/` folder into your project root
2. Restart Qwen Code
3. The skill auto-activates when you request UI/UX work

```bash
# Option A: Clone this repo and copy .qwen/
git clone https://github.com/user/ui-ux-pro-max-qwen.git
cp -r ui-ux-pro-max-qwen/.qwen /path/to/your/project/

# Option B: Copy directly from an existing installation
cp -r /path/to/ui-ux-pro-max-qwen/.qwen /path/to/your/project/
```

## Prerequisites

Python 3.x is required for the search script.

```bash
python3 --version

# macOS
brew install python3

# Ubuntu/Debian
sudo apt update && sudo apt install python3

# Windows
winget install Python.Python.3.12
```

## Usage

### Skill Mode (Auto-activate)

The skill activates automatically when you request UI/UX work. Just chat naturally:

```
Build a landing page for my SaaS product
Create a dashboard for healthcare analytics
Design a portfolio website with dark mode
```

### Custom Commands

**`/design <query>`** — Generate a complete design system:

```
/design beauty spa wellness
/design fintech banking dashboard
/design saas project management
```

**`/ui-search <query> [--domain <d>] [--stack <s>]`** — Search the design database:

```
/ui-search "glassmorphism dark" --domain style
/ui-search "elegant luxury" --domain typography
/ui-search "animation accessibility" --domain ux
/ui-search "responsive layout" --stack html-tailwind
```

### Direct CLI

```bash
# Generate design system
python3 .qwen/skills/ui-ux-pro-max/scripts/search.py "beauty spa" --design-system -p "Serenity Spa"

# Domain search
python3 .qwen/skills/ui-ux-pro-max/scripts/search.py "glassmorphism" --domain style

# Stack-specific guidelines
python3 .qwen/skills/ui-ux-pro-max/scripts/search.py "form validation" --stack react
```

### Persist Design System

Save your design system for reuse across sessions:

```bash
# Create MASTER.md
python3 .qwen/skills/ui-ux-pro-max/scripts/search.py "SaaS dashboard" --design-system --persist -p "MyApp"

# Create page-specific override
python3 .qwen/skills/ui-ux-pro-max/scripts/search.py "SaaS dashboard" --design-system --persist -p "MyApp" --page "dashboard"
```

## Supported Stacks

| Category | Stacks |
|----------|--------|
| **Web (HTML)** | HTML + Tailwind (default) |
| **React Ecosystem** | React, Next.js, shadcn/ui |
| **Vue Ecosystem** | Vue, Nuxt.js, Nuxt UI |
| **Other Web** | Svelte, Astro |
| **iOS** | SwiftUI |
| **Android** | Jetpack Compose |
| **Cross-Platform** | React Native, Flutter |

## Architecture

```
.qwen/
├── skills/ui-ux-pro-max/
│   ├── SKILL.md              # Skill definition (auto-activates)
│   ├── data/                 # 11 CSV databases
│   │   └── stacks/           # 13 stack-specific CSVs
│   └── scripts/
│       ├── search.py         # CLI entry point
│       ├── core.py           # BM25 + regex hybrid engine
│       └── design_system.py  # Design system generator
└── commands/
    ├── design.md             # /design command
    └── ui-search.md          # /ui-search command
```

## License

[MIT](LICENSE)
