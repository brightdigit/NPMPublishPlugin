// swift-tools-version:6.4
// swiftlint:disable explicit_acl explicit_top_level_acl

import PackageDescription

let package = Package(
  name: "NPMPublishPlugin",
  platforms: [
    .macOS(.v15),
    .iOS(.v18),
    .tvOS(.v18),
    .watchOS(.v11)
  ],
  products: [
    .library(
      name: "NPMPublishPlugin",
      targets: ["NPMPublishPlugin"]
    )
  ],
  dependencies: [
    .package(
      url: "https://github.com/brightdigit/Publish.git",
      branch: "main"
    ),
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
        .product(
          name: "Subprocess",
          package: "swift-subprocess",
          condition: .when(
            platforms: [.macOS, .linux, .windows, .android]
          )
        )
      ]
    ),
    .testTarget(
      name: "NPMPublishPluginTests",
      dependencies: [
        "NPMPublishPlugin",
        .product(
          name: "Subprocess",
          package: "swift-subprocess",
          condition: .when(
            platforms: [.macOS, .linux, .windows, .android]
          )
        )
      ]
    )
  ]
)

// swiftlint:enable explicit_acl explicit_top_level_acl
