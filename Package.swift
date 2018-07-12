// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "NetService",
    products: [
        .library(name: "NetService", targets: ["NetService"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Bouke/DNS.git", .revision("2d13515ea1f697170c9c32f7708ac508e749bf50")),
//        .package(url: "https://github.com/apple/swift-nio.git", from: "1.0.0"),
        .package(url: "https://github.com/mayur-mahajan/swift-nio.git", .revision("d913c886befe2f92ae250ad1666131b6013e32d9")),
        .package(url: "https://github.com/IBM-Swift/BlueSocket.git", from: "1.0.0")
    ],
    targets: [
		.target(name: "Cifaddrs", dependencies: []),
        .target(name: "NetService", dependencies: ["Cifaddrs", "NIO", "Socket", "DNS"]),
        .testTarget(name: "NetServiceTests", dependencies: ["NetService"])
    ]
)
