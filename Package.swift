// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "With",
	products: [
		.library(name: "With", targets: ["With"]),
	],
	dependencies: [],
	targets: [
		.target(name: "With", dependencies: [], path: "Sources/"),
		.testTarget(name: "WithTests", dependencies: ["With"]),
	]
)
