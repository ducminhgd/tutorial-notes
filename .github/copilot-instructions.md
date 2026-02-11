# AI Agent Instructions for Tutorial Notes Repository

## Project Overview
This is a personal knowledge base of tutorial notes organized by technology/topic (Go, Python, Docker, Ansible, databases, etc.). The goal is to maintain accessible, practical learning resources with commands, configurations, and examples.

## Repository Structure & Conventions

### Directory Organization
- **Top-level folders**: One folder per technology domain (e.g., `docker/`, `python/`, `ansible/`)
- **Naming**: Use lowercase, hyphen-separated folder names for multi-word topics
- **README pattern**: Most technology folders include a `README.md` with overview, installation, and basic usage
- **Subdirectories**: Only when there's substantial content (e.g., `docker/docs/`, `python/locustio/`, `vagrant/vagrant-kafka/`)
- **Configuration files**: Keep alongside related markdown (e.g., `docker/docker-compose.yaml`)

### Markdown Content Patterns
- **Headers**: Use `# Title` for main topics, `## Section` for subsections
- **Code blocks**: Always specify language (`` ```bash ``, `` ```python ``, `` ```yaml ``)
- **Tables**: Used for reference/cheatsheets (e.g., Git commands in `others/git.md`)
- **Code comments**: Keep inline explanations for non-obvious commands
- **Links**: Reference internal files using relative paths `[text](relative/path.md)`
- **Line breaks**: Generous spacing between sections for readability

### Reference Patterns (from existing files)
- `others/git.md`: Command-reference tables + step-by-step guides
- `docker/`: Mix of overview docs + practical cheatsheets + configuration examples
- `ansible/`: Setup instructions → configuration → quick-start examples
- `python/`: Includes both markdown guides and Python script examples

## Common Tasks for AI Agents

### Adding New Content
1. Create appropriate folder (or use existing) based on technology
2. Start with markdown (not separate directories) unless content exceeds ~500 lines
3. Update main `README.md` with entry linking to new content
4. Use `##` headers for major sections within a file

### Updating Existing Content
- Preserve existing structure and formatting
- Add new sections at end of file (don't reorganize existing content)
- Update README.md links if renaming/moving files
- Keep code examples accurate; mark outdated sections with context (version info, date)

### Cross-Folder References
- Link by relative path: `[See Docker docs](../../docker/README.md)`
- Link specific commands when reusing patterns
- Check if content should be consolidated if heavily referenced

## Key Patterns to Follow
- **Be specific**: Include version numbers, OS context (Ubuntu/CentOS/macOS), specific commands
- **Practical focus**: Show working examples, not theoretical concepts
- **Organized reference**: Use tables for commands, numbered steps for procedures
- **Modular**: Single markdown file per topic unless naturally grouped (subdirectory only if 3+ related files)

## Files Structure Reference
```
tutorial-notes/
├── README.md (main index)
├── [technology]/
│   ├── README.md (technology overview)
│   ├── *.md (specific topics)
│   ├── *.{yml,yaml,conf,Dockerfile} (configs/examples)
│   └── [subdirs]/ (only if 3+ substantial files)
```

## Do NOT

- Create deeply nested folder structures without justification
- Mix unrelated technologies in one folder
- Add large code projects (keep files <20KB) - this is a knowledge repo, not a code repo
- Duplicate content across folders - link instead
