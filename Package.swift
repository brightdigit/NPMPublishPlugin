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
    .package(name: "Publish", path: "../../Publish/Publish"),
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
          condition: .when(platforms: Platform.processExecution)
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
          condition: .when(platforms: Platform.processExecution)
        )
      ]
    )
  ]
)

extension Platform {
  static let processExecution: [Platform] = [.macOS, .linux, .windows, .android]
}
