// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserPicker",
    platforms: [
        .iOS(.v13),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "UserPicker",
            targets: ["UserPicker"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(path: "../Networking"),
        .package(path: "../../../../packages/NablaUtils"),
        .package(path: "../../../../packages/NablaCore"),
        
        .package(url: "https://github.com/faberNovel/Coordinator", from: "1.0.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "UserPicker",
            dependencies: [
                .product(name: "Networking", package: "Networking"),
                .product(name: "NablaUtils", package: "NablaUtils"),
                .product(name: "NablaCore", package: "NablaCore"),
                .product(name: "ADCoordinator", package: "Coordinator"),
            ]
        ),
        .testTarget(
            name: "UserPickerTests",
            dependencies: ["UserPicker"]
        ),
    ]
)
