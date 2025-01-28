// swift-tools-version:5.8
import PackageDescription


//let swiftSettings: [SwiftSetting] = []
let swiftSettings: [SwiftSetting] = [.enableExperimentalFeature("StrictConcurrency")]

let package = Package(
	name: "generic-json",
	products: [
		.library(name: "GenericJSON", targets: ["GenericJSON"]),
	],
	targets: [
		.target(name: "GenericJSON", path: "GenericJSON", swiftSettings: swiftSettings),
		.testTarget(name: "GenericJSONTests", dependencies: ["GenericJSON"], swiftSettings: swiftSettings)
	]
)
