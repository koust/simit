// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "simit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "simit",
            targets: ["simit"]),
    ],
    dependencies: [
        .package(url:"https://github.com/koust/simit", from: "1.0.0"),
        .package(url: "https://github.com/eugenebokhan/Bonjour.git",
         .upToNextMinor(from: "2.1.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "simit",
            dependencies: [
                "Bonjour"
            ]),
        .testTarget(
            name: "simitTests",
            dependencies: ["simit"]),
    ]
)
