// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "ReactiveCombineBridge",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(name: "ReactiveCombineBridge", targets: ["ReactiveCombineBridge"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveCocoa/ReactiveSwift", from: "6.2.1")
    ],
    targets: [
        .target(name: "ReactiveCombineBridge", dependencies: ["ReactiveSwift"]),
        .testTarget(name: "ReactiveCombineBridgeTests", dependencies: [
            "ReactiveCombineBridge",
            "ReactiveSwift"
        ]),
    ]
)
