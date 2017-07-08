// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "ProrsumProvider",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/noppoMan/Prorsum.git", majorVersion: 0, minor: 1)
    ]
)
