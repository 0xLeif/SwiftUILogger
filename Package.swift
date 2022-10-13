// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftUILogger",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7),
        .tvOS(.v14)
    ],
    products: [
        .library(
            name: "SwiftUILogger",
            targets: ["SwiftUILogger"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUILogger",
            dependencies: []
        ),
        .testTarget(
            name: "SwiftUILoggerTests",
            dependencies: ["SwiftUILogger"]
        )
    ]
)
