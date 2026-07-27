# Release Notes

## 2.0.0-alpha.1

NPMPublishPlugin moves to Swift 6.4 with complete strict concurrency, and its process execution
is now built on [swift-subprocess](https://github.com/swiftlang/swift-subprocess) instead of
`Foundation.Process`. That changes the shape of the command-running API, so this is a
source-breaking release from `1.0.0`.

### Library
* Migrate to Swift 6.4 strict concurrency + swift-subprocess, modernize lint/CI tooling by @leogdion in https://github.com/brightdigit/NPMPublishPlugin/pull/9
* Rebuild the NPM command layer — `Command`, `Job`, `JobBuilder`, `Argument`, `ArgumentBuilder`, `Context`, `Location`, `RelativePathMap` and `Settings` — for strict concurrency by @leogdion in https://github.com/brightdigit/NPMPublishPlugin/pull/9

### Dependencies
* Depend on swift-subprocess `0.4.0` (up to next minor) for process execution by @leogdion in https://github.com/brightdigit/NPMPublishPlugin/pull/9
* Consume Publish from its standalone repository rather than a monorepo path by @leogdion in https://github.com/brightdigit/NPMPublishPlugin/pull/9

### Tooling & CI
* Retire the Hound and SwiftFormat configuration in favor of mise-based linting with `.mise.toml`, `.swift-format`, `.swiftlint.yml` and `Scripts/lint.sh` by @leogdion in https://github.com/brightdigit/NPMPublishPlugin/pull/9
* Adopt the shared multi-platform CI template (macOS/Linux/Windows/Android) plus `check-unsafe-flags`, `swift-source-compat` and `cleanup-caches` workflows by @leogdion in https://github.com/brightdigit/NPMPublishPlugin/pull/9

**Full Changelog**: https://github.com/brightdigit/NPMPublishPlugin/compare/1.0.0...2.0.0-alpha.1
