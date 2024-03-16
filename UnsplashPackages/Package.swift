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
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "13.0.0"),
    ],
    targets: [
        .target(
            name: "AppConfiguration"
        ),
        .target(
            name: "AppLogger"
        ),
        .testTarget(
            name: "AppLoggerTests",
            dependencies: [
                "AppLogger",
                .product(name: "Nimble", package: "Nimble"),
            ]
        ),
        .target(
            name: "Networking",
            dependencies: [
                "AppConfiguration",
                "AppLogger",
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .testTarget(
            name: "NetworkingTests",
            dependencies: [
                "Networking",
                .product(name: "Nimble", package: "Nimble"),
            ]
        )
    ]
)
