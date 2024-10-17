// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "FigmaAPI",
    platforms: [.macOS(.v14), .iOS(.v17)],
    products: [
        .library(
            name: "FigmaAPI",
            targets: ["FigmaAPI"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "FigmaAPI",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
            ]
        ),
        .testTarget(
            name: "FigmaAPITests",
            dependencies: ["FigmaAPI"]
        ),
    ]
)
