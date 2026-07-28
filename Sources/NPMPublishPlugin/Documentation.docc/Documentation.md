# ``NPMPublishPlugin``

A Publish plugin that makes it easy to run **npm** commands for any Publish website.

## Overview

`NPMPublishPlugin` lets you integrate an npm package into your **Publish** site. If you need JavaScript or CSS built as part of publishing, this plugin runs those **npm** steps in your pipeline.

### Requirements

**Toolchain**

- Swift tools **6.4** (Swift 6.4 toolchain)

**Apple Platforms**

- macOS 15 or later
- iOS 18 or later
- tvOS 18 or later
- watchOS 11 or later

**Process execution**

Process execution uses [swift-subprocess](https://github.com/swiftlang/swift-subprocess). The ``Publish/PublishingStep`` `npm` APIs are available where Subprocess can be imported (macOS, Linux, Windows, and Android per the package’s dependency conditions).

### Installation

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

### Usage

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

There are three ways to create the step: ``NPM/Settings`` plus an array of ``NPM/Job`` values, or `npm(_:at:_:)` with a `Folder` or Publish `Path` and an ``NPM/JobBuilder`` block. Built-in helpers ``ci()`` and ``run(paths:_:)`` cover the common commands; pass string or ``OutputPath`` values as ``NPM/Argument``s.

## Topics

### Setting up your Publish step

* ``Publish/PublishingStep``
* ``NPM/Job``
* ``NPM/Settings``
* ``OutputPath``
* ``NPM/Argument``
* ``NPM``

### Commands

* ``ci()``
* ``run(paths:_:)``
