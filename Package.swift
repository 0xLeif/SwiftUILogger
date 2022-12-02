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
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-collections.git",
            .upToNextMinor(from: "1.0.0") // or `.upToNextMajor
        )
    ],
    targets: [
        .target(
            name: "SwiftUILogger",
            dependencies: [
                .product(name: "OrderedCollections", package: "swift-collections")
            ]
        ),
        .testTarget(
            name: "SwiftUILoggerTests",
            dependencies: ["SwiftUILogger"]
        )
    ]
)
