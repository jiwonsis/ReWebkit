// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ReWebkit",
    dependencies: [
         .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "1.3.2")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "7.3.1")),
    ],
    targets: [
        .target(
            name: "ReWebkit",
            dependencies: ["RxSwift", "RxCocoa"],
            path: "Sources"
        ),
        .testTarget(
            name: "ReWebkitTests",
            dependencies: ["ReWebkit", "Quick", "Nimble"],
            path: "Tests"
        ),
    ]
)
