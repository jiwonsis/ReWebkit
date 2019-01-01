// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReWebKit",
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "1.3.2")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.3.1")),
    ],
    targets: [
        .target(
            name: "ReWebKit",
            dependencies: ["RxSwift", "RxCocoa"],
            path: "Sources"
        ),
        .testTarget(
            name: "ReWebKitTests",
            dependencies: ["ReWebKit", "Quick", "Nimble", "RxSwift", "RxCocoa"],
            path: "Tests"
        ),
    ]
)
