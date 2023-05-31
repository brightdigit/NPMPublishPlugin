// swift-tools-version: 5.8
// swiftlint:disable explicit_acl explicit_top_level_acl

import PackageDescription

let package = Package(
  name: "NPMPublishPlugin",
  products: [
    .library(
      name: "NPMPublishPlugin",
      targets: ["NPMPublishPlugin"]
    )
  ],
  targets: [
    .target(
      name: "NPMPublishPlugin"
    ),
    .testTarget(
      name: "NPMPublishPluginTests",
      dependencies: ["NPMPublishPlugin"]
    )
  ]
)
