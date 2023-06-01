// swift-tools-version: 5.8
// swiftlint:disable explicit_acl explicit_top_level_acl

import PackageDescription

let package = Package(
    name: "NPMPublishPlugin",
    platforms: [.macOS(.v12)],
    products: [
        .library(
            name: "NPMPublishPlugin",
            targets: ["NPMPublishPlugin"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/johnsundell/publish.git",
            from: "0.9.0"
        ),
        .package(
            url: "https://github.com/johnsundell/shellout.git",
            from: "2.3.0"
        )
    ],
    targets: [
        .target(
            name: "NPMPublishPlugin",
            dependencies: [
                .product(name: "Publish", package: "publish"),
                .product(name: "ShellOut", package: "shellout")
            ]
        ),
        .testTarget(
            name: "NPMPublishPluginTests",
            dependencies: ["NPMPublishPlugin"]
        )
    ]
)
