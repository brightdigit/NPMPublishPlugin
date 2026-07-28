# NPMPublishPlugin

A Publish plugin that makes it easy to run **npm** commands for any Publish website.

[![SwiftPM](https://img.shields.io/badge/SPM-Linux%20%7C%20macOS-success?logo=swift)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@brightdigit-blue.svg?style=flat)](http://twitter.com/brightdigit)
![GitHub](https://img.shields.io/github/license/brightdigit/NPMPublishPlugin)
![GitHub issues](https://img.shields.io/github/issues/brightdigit/NPMPublishPlugin)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/brightdigit/NPMPublishPlugin/NPMPublishPlugin.yml?label=actions&logo=github&?branch=main)

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FNPMPublishPlugin%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/brightdigit/NPMPublishPlugin)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fbrightdigit%2FNPMPublishPlugin%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/brightdigit/NPMPublishPlugin)


[![Codecov](https://img.shields.io/codecov/c/github/brightdigit/NPMPublishPlugin)](https://codecov.io/gh/brightdigit/NPMPublishPlugin)
[![CodeFactor Grade](https://img.shields.io/codefactor/grade/github/brightdigit/NPMPublishPlugin)](https://www.codefactor.io/repository/github/brightdigit/NPMPublishPlugin)
[![codebeat badge](https://codebeat.co/badges/508ff110-90aa-4a3d-be48-1ffcc8009dd1)](https://codebeat.co/projects/github-com-brightdigit-npmpublishplugin-main)
[![Code Climate maintainability](https://img.shields.io/codeclimate/maintainability/brightdigit/NPMPublishPlugin)](https://codeclimate.com/github/brightdigit/NPMPublishPlugin)
[![Code Climate technical debt](https://img.shields.io/codeclimate/tech-debt/brightdigit/NPMPublishPlugin?label=debt)](https://codeclimate.com/github/brightdigit/NPMPublishPlugin)
[![Code Climate issues](https://img.shields.io/codeclimate/issues/brightdigit/NPMPublishPlugin)](https://codeclimate.com/github/brightdigit/NPMPublishPlugin)

# Table of Contents

* [Introduction](#introduction)
   * [Requirements](#requirements)
   * [Installation](#installation)
* [Usage](#usage)
   * [Configuring npm](#configuring-npm)
   * [Running npm commands](#running-npm-commands)
   * [On Argument](#on-argument)
* [Migrating from 1.x](#migrating-from-1x)
* [References](#references)
* [License](#license)

# Introduction

`NPMPublishPlugin` lets you integrate an npm package into your **Publish** site. If you need JavaScript or CSS built as part of publishing, this plugin runs those **npm** steps in your pipeline.

## Requirements

**Toolchain**

- Swift tools **6.4** (Swift 6.4 toolchain)

**Apple Platforms**

- macOS 15 or later
- iOS 18 or later
- tvOS 18 or later
- watchOS 11 or later

**Process execution**

Process execution uses [swift-subprocess](https://github.com/swiftlang/swift-subprocess). The `PublishingStep.npm` APIs are available where Subprocess can be imported (macOS, Linux, Windows, and Android per the package’s dependency conditions).

## Installation

Add **Publish** and **NPMPublishPlugin** as dependencies in your site’s `Package.swift`:

```swift
let package = Package(
  ...
  dependencies: [
      ...
      .package(
        url: "https://github.com/brightdigit/Publish.git",
        from: "1.0.0-alpha.1"
      ),
      .package(
        url: "https://github.com/brightdigit/NPMPublishPlugin.git",
        from: "2.0.0-alpha.1"
      )
  ],
  targets: [
    .target(
      ...
      dependencies: [
          ...
          .product(name: "Publish", package: "Publish"),
          .product(name: "NPMPublishPlugin", package: "NPMPublishPlugin"),
      ]
    )
  ]
  ...
)
```

Then import **NPMPublishPlugin** wherever you’d like to use it:

```swift
import NPMPublishPlugin
```

# Usage

Add an `npm` step to your **Publish** pipeline:

```swift
import NPMPublishPlugin

let mainJS = OutputPath.file("js/main.js")

try DeliciousRecipes().publish(using: [
    .addMarkdownFiles(),
    .copyResources(),
    .addFavoriteItems(),
    .addDefaultSectionTitles(),
    .generateHTML(withTheme: .delicious),
    .generateRSSFeed(including: [.recipes]),
    .generateSiteMap(),
    // from the **npm** package directory at `Styling`
    .npm(npmPath, at: "Styling") {
      // run `npm ci`
      ci()
      // run `npm run publish -- --output-filename js/main.js`
      run(paths: [mainJS]) {
        "publish -- --output-filename"
        mainJS
      }
    }
])
```

## Configuring npm

`NPMPublishPlugin` provides three ways to create a **Publish** step that runs **npm**:

1. Pass an `NPM.Settings` value and an array of `NPM.Job` items to `PublishingStep.npm(run:withSettings:)`.
2. Call `npm(_:at:_:)` with an optional path to the **npm** executable and a `Folder` to run from, plus an `NPM.JobBuilder` block.
3. Call `npm(_:at:_:)` with an optional path to the **npm** executable and a Publish `Path` to run from, plus an `NPM.JobBuilder` block.

Most sites use options 2 or 3. The job builder lists jobs the same way a SwiftUI view builder lists views.

## Running npm commands

Built-in helpers cover the two most common commands:

- `ci()` — runs `npm ci`
- `run(paths:_:)` — runs `npm run` with optional output paths and arguments

To add another command, create a helper that returns an `NPM.Job`, similar to `run`:

```swift
public func run(
  paths: [OutputPath] = [],
  @NPM.ArgumentBuilder _ arguments: () -> [NPM.Argument]
) -> NPM.Job {
  .init(subcommand: .run, outputRelativePaths: paths, arguments)
}
```

You can also construct an `NPM.Job` with any `NPM.Command` (string-convertible) and arguments yourself.

## On `Argument`

Each `NPM.Argument` is either:

- a **string** (may contain several whitespace-separated tokens, which are split when the process is launched), or
- an **`OutputPath`**, resolved relative to the npm project folder so Publish output paths can be passed into **npm** without hard-coding absolute paths

# Migrating from 1.x

`2.0.0-alpha.1` is source-breaking relative to `1.0.0`. Bump to Swift 6.4, depend on Publish `1.0.0-alpha.1` and NPMPublishPlugin `2.0.0-alpha.1`, and expect API changes around command execution (now based on swift-subprocess). See [RELEASE_NOTES.md](RELEASE_NOTES.md) for the full changelog.

# References

* [Publish](https://github.com/brightdigit/Publish)
* [npm](https://www.npmjs.com)
* [swift-subprocess](https://github.com/swiftlang/swift-subprocess)

# License

This code is distributed under the MIT license. See the [LICENSE](https://github.com/brightdigit/NPMPublishPlugin/LICENSE) file for more info.
