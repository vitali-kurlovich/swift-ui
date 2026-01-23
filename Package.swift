// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// SwiftUIControlsKit

let package = Package(
    name: "swift-ui",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.

        .library(
            name: "VisualEffects",
            targets: ["VisualEffects"]
        ),

        .library(
            name: "SwiftUIKit",
            targets: ["SwiftUIKit"]
        ),

        //
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
            name: "SwiftUIKit",
            dependencies: [
                "VisualEffects",
            ]
        ),
    ]
)
