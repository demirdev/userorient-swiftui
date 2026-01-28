// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "userorient-swiftui",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(
            name: "userorient-swiftui",
            targets: ["userorient-swiftui"]
        ),
    ],
    targets: [
        .target(
            name: "userorient-swiftui"
        ),
        .testTarget(
            name: "userorient-swiftuiTests",
            dependencies: ["userorient-swiftui"]
        ),
    ]
)
