// swift-tools-version:5.1
import PackageDescription


let package = Package(
	name: "generic-json",
	products: [
		.library(name: "GenericJSON", targets: ["GenericJSON"]),
	],
	targets: [
		.target(name: "GenericJSON", path: "GenericJSON"),
		.testTarget(name: "GenericJSONTests", dependencies: ["GenericJSON"])
	]
)
