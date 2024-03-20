// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UnsplashPackages",
    defaultLocalization: "en",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "AppConfiguration",
            targets: ["AppConfiguration"]),
        .library(
            name: "AppLogger",
            targets: ["AppLogger"]),
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]),
        .library(
            name: "Details",
            targets: ["Details"]),
        .library(
            name: "Home",
            targets: ["Home"]),
        .library(
            name: "SharedModels",
            targets: ["SharedModels"]),
        .library(
            name: "Search",
            targets: ["Search"]),
        .library(
            name: "Localizable",
            targets: ["Localizable"]),
        .library(
            name: "Networking",
            targets: ["Networking"]),
        .library(
            name: "Utils",
            targets: ["Utils"]),
        .library(
            name: "UnitTestsUtils",
            targets: ["UnitTestsUtils"]),

    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "13.0.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImageSwiftUI.git", from: "3.0.0"),
        .package(url: "https://github.com/SwiftGen/SwiftGenPlugin", from: "6.6.0"),
        .package(url: "https://github.com/realm/SwiftLint", branch: "main"),
        .package(url: "https://github.com/liamnichols/xcstrings-tool-plugin.git", from: "0.1.2"),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.15.4"),
        .package(url: "https://github.com/pointfreeco/swift-concurrency-extras", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "AppConfiguration",
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .target(
            name: "AppLogger",
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "AppLoggerTests",
            dependencies: [
                "AppLogger",
                .product(name: "Nimble", package: "Nimble"),
            ]
        ),
        .target(
            name: "Details",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "DesignSystem",
                "Localizable",
                "Networking",
                "SharedModels",
                "Utils"
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "DetailsTests",
            dependencies: [
                "Details",
                "UnitTestsUtils",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .target(
            name: "DesignSystem",
            dependencies: [
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI"),
                "Utils"
            ],
            plugins: [
                "Localizable",
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint"),
                .plugin(name: "SwiftGenPlugin", package: "SwiftGenPlugin")
            ]
        ),
        .target(
            name: "Home",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "DesignSystem",
                "Localizable",
                "Networking",
                "SharedModels",
                "Utils"
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "HomeTests",
            dependencies: [
                "Home",
                "UnitTestsUtils",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .target(
            name: "Search",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                "DesignSystem",
                "Localizable",
                "Networking",
                "SharedModels",
                "Utils"
            ]
        ),
        .testTarget(
            name: "SearchTests",
            dependencies: [
                "DesignSystem",
                "Search",
                "UnitTestsUtils",
                .product(name: "ConcurrencyExtras", package: "swift-concurrency-extras"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ]
        ),
        .target(
            name: "SharedModels",
            dependencies: [
                "Utils"
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .target(
            name: "Utils",
            dependencies: [
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .target(
            name: "Localizable",
            dependencies: [
                .product(name: "XCStringsToolPlugin", package: "xcstrings-tool-plugin"),
            ],
            swiftSettings: [
                .define("XCSTRINGS_TOOL_ACCESS_LEVEL_PUBLIC")
            ]
        ),
        .target(
            name: "Networking",
            dependencies: [
                "AppConfiguration",
                "AppLogger",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "SDWebImageSwiftUI", package: "SDWebImageSwiftUI")

            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking",
                .product(name: "Nimble", package: "Nimble"),
            ]
        ),
        .target(
            name: "UnitTestsUtils",
            dependencies: [
                "AppConfiguration",
                "DesignSystem",
                "SharedModels"
            ],
            resources: [
                .process("Resources")
            ],
            plugins: [
                .plugin(name: "SwiftLintPlugin", package: "SwiftLint")
            ]
        ),
    ]
)
