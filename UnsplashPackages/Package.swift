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
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "AppConfiguration"
        ),
        .target(
            name: "Networking",
            dependencies: [
                "AppConfiguration",
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
    ]
)
