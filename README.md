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
[![Reviewed by Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com)

# Table of Contents

* [Introduction](#introduction)
   * [Requirements](#requirements)
   * [Installation](#installation)
* [Usage](#usage)
   * [Configuring npm](#configuring-npm)
   * [Running npm commands](#running-npm-commands)
   * [On Argument](#on-argument)
* [References](#references)
* [License](#license)

# Introduction

`NPMPublishPlugin` allows you to integrate an NPM package into your **Publish** site. If you require javascript or css to be built for your site, this is the ideal plugin for you.

## Requirements 

**Apple Platforms**

- Xcode 14.3 or later
- Swift 5.8 or later

- macOS 12 or later deployment targets

**Linux**

- Ubuntu 18.04 or later
- Swift 5.8 or late

## Installation

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

# Usage

Add the `npm` to your **Publish** steps:

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

`NPMPublishPlugin` includes three ways to create a **Publish** step to run **npm**.

Firstly, you can supply a `Settings` and an array of `Job` items.
However most likely  you'll want to to use the other two methods which you can pass:

* an optional path to the **npm** command
* an optional path to the *current directory* to run from as either a `Folder` or `Path ` object from **Publish**
* using the ``NPM/JobBuilder`` pass the series jobs similar to how **SwiftUI** builds a `View` using its DSL

## Running npm commands

`NPMPublishPlugin` comes with two commands `ci` and `run`. If you wish to include more commands, 
simply create a function which can take in `Arguments` similar to the `run` method:

```swift
public func run(
  paths: [OutputPath] = [],
  @NPM.ArgumentBuilder _ arguments: () -> [NPM.Argument]
) -> NPM.Job {
  .init(subcommand: .run, outputRelativePaths: paths, arguments)
}
```

## On `Argument`

The `Argument` item can be either a simple string or an `OutputPath` that's dynamic and based a `Path` from the **Publish** library.
 
# References

* [Publish by John Sundell](https://github.com/JohnSundell/Publish)
* [npm](https://www.npmjs.com)

# License 

This code is distributed under the MIT license. See the [LICENSE](https://github.com/brightdigit/NPMPublishPlugin/LICENSE) file for more info.
