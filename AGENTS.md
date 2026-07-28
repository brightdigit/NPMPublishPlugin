# AGENTS.md

Guidance for AI agents (Cursor, Claude Code, and others) working in this repository.

## Overview

NPMPublishPlugin is a Publish plugin that runs npm build steps as part of the
static-site publishing pipeline.

## Worktrees

This repository uses a **bare repo + git worktrees** layout, managed by
[`git-trees`](https://github.com/brightdigit/git-trees).

### Layout

```
<repo-root>/
├── trees-bare.git/  bare git repo — never modify directly
├── .git             file pointing at trees-bare.git
└── <name>/          one worktree per branch, each its own working copy
```

Worktrees share a single object store but have independent working trees,
indexes, and HEADs.

### Rules

1. Stay inside your assigned worktree. Do not `cd` into a sibling worktree or
   above the repo root.
2. Do not `git checkout` a different branch. To work on another branch, request a
   new worktree.
3. Never touch `trees-bare.git/`.
4. Push with `git push -u origin HEAD` — upstream tracking may not be set.
5. Other agents may be working in sibling worktrees concurrently. Do not `git gc`,
   rewrite shared history, or force-push branches you were not assigned.

## Commands

Run all commands from your worktree root. Builds use the **Swift 6.4 toolchain**
(`Package.swift` tools-version `6.4`). Use the matching snapshot / `Xcode-beta`
toolchain locally.

- Build: `swift build`
- Build incl. tests: `swift build --build-tests`
- Run tests: `swift test`

### Linting

Lint tooling is pinned via **mise** (`.mise.toml`). The entry point is
`Scripts/lint.sh`, which bootstraps tools with `mise install` then runs
swift-format, SwiftLint, and a build check (periphery + header rewrite run
locally only).

- Full lint + autofix (local): `Scripts/lint.sh`
- CI/strict mode (no autofix, fails on warnings): `LINT_MODE=STRICT CI=1 Scripts/lint.sh`

## Dependencies

Depends on [Publish](https://github.com/brightdigit/Publish) and
[swift-subprocess](https://github.com/swiftlang/swift-subprocess). See
`Package.swift` for current version pins.
