// swift-tools-version:5.8
import PackageDescription



let commonSwiftSettings: [SwiftSetting] = [
	.enableExperimentalFeature("StrictConcurrency")
]

let package = Package(
	name: "GenericJSON",
	products: [
		.library(name: "GenericJSON", targets: ["GenericJSON"]),
	],
	targets: [
		.target(name: "GenericJSON", path: "GenericJSON", swiftSettings: commonSwiftSettings),
		.testTarget(name: "GenericJSONTests", dependencies: ["GenericJSON"], path: "GenericJSONTests", swiftSettings: commonSwiftSettings)
	]
)
