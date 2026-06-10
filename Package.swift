// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-ui",
    platforms: [
        .macOS(.v14),
        .iOS(.v16),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.

        .library(
            name: "VisualEffects",
            targets: ["VisualEffects"]
        ),

        .library(
            name: "SwiftUIComponents",
            targets: ["SwiftUIComponents"]
        ),

    ],
    dependencies: [
        .package(url: "https://github.com/vitali-kurlovich/swift-mathkit.git", from: "0.0.10"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "VisualEffects",

            resources: [
                .process("Metal/"),
            ]
        ),

        .target(
            name: "SwiftUIComponents",
            dependencies: [
                "VisualEffects",
                .product(name: "MathKit", package: "swift-mathkit"),
            ]

        ),
    ],
    swiftLanguageModes: [.v6]
)
