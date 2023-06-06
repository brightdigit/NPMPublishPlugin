# ``NPMPublishPlugin``

A Publish plugin that makes it easy to run npm commands for any Publish website. 

## Overview

This is the overview

### Requirements 

**Apple Platforms**

- Xcode 13.4 or later
- Swift 5.8 or later

// @Leo
- iOS 14 / watchOS 6 / tvOS 14 / macOS 12 or later deployment targets

**Linux**

// @Leo
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

**NPMPublishPlugin** enables .....

## Topics

