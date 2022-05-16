// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "nabla-ios",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        .library(
            name: "NablaMessagingCore",
            targets: ["NablaMessagingCore"]
        ),
        .library(
            name: "NablaMessagingUI",
            targets: ["NablaMessagingUI"]
        ),
        .library(
            name: "NablaUtils",
            targets: ["NablaUtils"]
        ),
    ],
    dependencies: [
        // SDK
        .package(url: "https://github.com/apollographql/apollo-ios", from: "0.50.0"),
        
        // Tests
        .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", from: "4.1.0"),
    ],
    targets: [
        .target(
            name: "NablaMessagingCore",
            dependencies: [
                .target(name: "NablaUtils"),
                .product(name: "Apollo", package: "apollo-ios"),
                .product(name: "ApolloWebSocket", package: "apollo-ios"),
            ],
            exclude: [
                "build.sh",
                "swiftgen.yml",
                "Data/GQL/Schema",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "NablaMessagingCoreTests",
            dependencies: [
                .target(name: "NablaMessagingCore"),
                .product(name: "SwiftyMocky", package: "SwiftyMocky"),
            ]
        ),
        .target(
            name: "NablaMessagingUI",
            dependencies: [
                .target(name: "NablaUtils"),
                .target(name: "NablaMessagingCore"),
            ],
            exclude: [
                "build.sh",
                "swiftgen.yml",
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "NablaMessagingUITests",
            dependencies: ["NablaMessagingUI"]
        ),
        .target(
            name: "NablaUtils",
            dependencies: []
        ),
        .testTarget(
            name: "NablaUtilsTests",
            dependencies: ["NablaUtils"]
        ),
    ]
)
