// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GildedRose",
    products: [
        .executable(name: "GildedRoseExecutable", targets: ["GildedRoseExecutable"]),
        .library(name: "GildedRose", targets: ["GildedRose"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GildedRoseExecutable",
            dependencies: ["GildedRose"]),
        .target(
            name: "GildedRose",
            dependencies: []),
        .testTarget(
            name: "GildedRoseTests",
            dependencies: ["GildedRose"]),
    ]
)
