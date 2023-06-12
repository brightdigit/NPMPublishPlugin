# ``NPMPublishPlugin``

A Publish plugin that makes it easy to run **npm** commands for any Publish website. 

## Overview

`NPMPublishPlugin` allows you to integrate an NPM package into your **Publish** site. If you require javascript or css to be built for your site, this is the ideal plugin for you.

### Requirements 

**Apple Platforms**

- Xcode 14.3 or later
- Swift 5.8 or later

- macOS 12 or later deployment targets

**Linux**

- Ubuntu 18.04 or later
- Swift 5.8 or late

### Installation

To install it into your [Publish](https://github.com/johnsundell/publish) package, add it as a dependency within your `Package.swift` manifest:

```swift
let package = Package(
  ...
  dependencies: [
      ...
      .package(
         url: "https://github.com/johnsundell/publish.git", 
         from: "0.9.0"
      ),
      .package(
        url: "https://github.com/brightdigit/NPMPublishPlugin.git",
        from: "1.0.0"
      )
  ],
  targets: [
    .target(
      ...
      dependencies: [
          ...
          .product(name: "Publish", package: "publish"),
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

