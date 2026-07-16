// swift-tools-version:6.4
// swiftlint:disable explicit_acl explicit_top_level_acl

import PackageDescription

let package = Package(
  name: "NPMPublishPlugin",
  platforms: [.macOS(.v15)],
  products: [
    .library(
      name: "NPMPublishPlugin",
      targets: ["NPMPublishPlugin"]
    )
  ],
  dependencies: [
    .package(path: "../../Publish/Publish"),
    .package(
      url: "https://github.com/swiftlang/swift-subprocess.git",
      .upToNextMinor(from: "0.4.0")
    )
  ],
  targets: [
    .target(
      name: "NPMPublishPlugin",
      dependencies: [
        .product(name: "Publish", package: "Publish"),
        .product(name: "Subprocess", package: "swift-subprocess")
      ]
    ),
    .testTarget(
      name: "NPMPublishPluginTests",
      dependencies: ["NPMPublishPlugin"]
    )
  ]
)
