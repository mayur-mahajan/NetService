// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "NetService",
    products: [
        .library(name: "NetService", targets: ["NetService"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Bouke/DNS.git", .revision("2d13515ea1f697170c9c32f7708ac508e749bf50")),
        .package(url: "https://github.com/mayur-mahajan/swift-nio.git", .revision("26324082af963922fda832c626287a81d532f8d4"))
    ],
    targets: [
		.target(name: "Cifaddrs", dependencies: []),
        .target(name: "NetService", dependencies: ["Cifaddrs", "NIO", "DNS"]),
        .testTarget(name: "NetServiceTests", dependencies: ["NetService"])
    ]
)
