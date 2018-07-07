// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "NetService",
    products: [
        .library(name: "NetService", targets: ["NetService"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mayur-mahajan/DNS.git", .revision("2d13515ea1f697170c9c32f7708ac508e749bf50")),
        .package(url: "https://github.com/IBM-Swift/BlueSocket.git", from: "1.0.0")
    ],
    targets: [
		.target(name: "Cifaddrs", dependencies: []),
        .target(name: "NetService", dependencies: ["Cifaddrs", "Socket", "DNS"]),
    ]
)
