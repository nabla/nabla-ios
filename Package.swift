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
            name: "NablaCore",
            targets: ["NablaCore"]
        ),
        .library(
            name: "NablaMessagingCore",
            targets: ["NablaMessagingCore"]
        ),
        .library(
            name: "NablaMessagingUI",
            targets: ["NablaMessagingUI"]
        ),
        .library(
            name: "NablaVideoCall",
            targets: ["NablaVideoCall"]
        ),
        .library(
            name: "NablaScheduling",
            targets: ["NablaScheduling"]
        ),
    ],
    dependencies: [
        // SDK
        .package(url: "https://github.com/apollographql/apollo-ios", .exact("0.51.2")),
        .package(name: "LiveKit", url: "https://github.com/livekit/client-sdk-swift.git", .exact("1.0.5")),
        .package(name: "Sentry", url: "https://github.com/getsentry/sentry-cocoa.git", .exact("7.31.2")),
        
        // Tests
        .package(url: "https://github.com/MakeAWishFoundation/SwiftyMocky", .exact("4.1.0")),
        .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", .exact("1.10.0")),
        .package(url: "https://github.com/venmo/DVR", .exact("2.1.0")),
    ],
    targets: [
        .target(
            name: "NablaCore",
            dependencies: [
                .product(name: "Apollo", package: "apollo-ios"),
                .product(name: "ApolloWebSocket", package: "apollo-ios"),
                .product(name: "ApolloSQLite", package: "apollo-ios"),
                .product(name: "Sentry", package: "Sentry"),
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
        .target(
            name: "NablaCoreTestsUtils",
            dependencies: [
                .target(name: "NablaCore"),
                .product(name: "SwiftyMocky", package: "SwiftyMocky"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            path: "Tests/NablaCoreTestsUtils",
            resources: [
                .process("Resources"),
            ]
        ),
        .testTarget(
            name: "NablaCoreTests",
            dependencies: [
                .target(name: "NablaCore"),
                .target(name: "NablaCoreTestsUtils"),
            ],
            resources: [
                .process("SnapshotTests/PrimaryButton/__Snapshots__"),
                .process("SnapshotTests/AvatarView/__Snapshots__"),
            ]
        ),
        .target(
            name: "NablaMessagingCore",
            dependencies: [
                .target(name: "NablaCore"),
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
        .target(
            name: "NablaMessagingCoreTestsUtils",
            dependencies: [
                .target(name: "NablaMessagingCore"),
                .target(name: "NablaCoreTestsUtils"),
                .product(name: "SwiftyMocky", package: "SwiftyMocky"),
            ],
            path: "Tests/NablaMessagingCoreTestsUtils"
        ),
        .testTarget(
            name: "NablaMessagingCoreTests",
            dependencies: [
                .target(name: "NablaMessagingCore"),
                .target(name: "NablaMessagingCoreTestsUtils"),
                .target(name: "NablaCoreTestsUtils"),
            ]
        ),
        .testTarget(
            name: "NablaMessagingCoreIntegrationTests",
            dependencies: [
                .target(name: "NablaMessagingCore"),
                .target(name: "NablaMessagingCoreTestsUtils"),
                .target(name: "NablaCoreTestsUtils"),
                .product(name: "DVR", package: "DVR"),
                .product(name: "Apollo", package: "apollo-ios"),
            ],
            resources: [
                .process("CreateConversationTests"),
            ]
        ),
        .target(
            name: "NablaMessagingUI",
            dependencies: [
                .target(name: "NablaCore"),
                .target(name: "NablaMessagingCore"),
                .target(name: "NablaDocumentScanner"),
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
            dependencies: [
                .target(name: "NablaMessagingUI"),
                .target(name: "NablaCoreTestsUtils"),
                .target(name: "NablaMessagingCoreTestsUtils"),
                .product(name: "SwiftyMocky", package: "SwiftyMocky"),
            ],
            resources: [
                .process("SnapshotTests/Conversation/__Snapshots__"),
                .process("SnapshotTests/ConversationList/__Snapshots__"),
                .process("SnapshotTests/ImageDetail/__Snapshots__"),
            ]
        ),
        .target(
            name: "NablaVideoCall",
            dependencies: [
                .target(name: "NablaCore"),
                .product(name: "LiveKit", package: "LiveKit"),
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
            name: "NablaVideoCallTests",
            dependencies: [
                .target(name: "NablaVideoCall"),
                .target(name: "NablaCoreTestsUtils"),
                .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
            ],
            resources: [
                .process("SnapshotTests/ParticipantsCountView/__Snapshots__"),
            ]
        ),
        .target(
            name: "NablaScheduling",
            dependencies: [
                .target(name: "NablaCore"),
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
            name: "NablaSchedulingTests",
            dependencies: [
                .target(name: "NablaScheduling"),
                .target(name: "NablaCoreTestsUtils"),
                .product(name: "SwiftyMocky", package: "SwiftyMocky"),
            ],
            resources: [
                .process("SnapshotTests/AppointmentList/__Snapshots__"),
                .process("SnapshotTests/CategoryPicker/__Snapshots__"),
                .process("SnapshotTests/TimeSlotPicker/__Snapshots__"),
                .process("SnapshotTests/AppointmentConfirmation/__Snapshots__"),
                .process("SnapshotTests/AppointmentDetails/__Snapshots__"),
            ]
        ),
        .target(name: "NablaDocumentScanner"),
    ]
)
