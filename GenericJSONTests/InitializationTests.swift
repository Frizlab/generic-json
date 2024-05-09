import Foundation
import XCTest

@testable import GenericJSON



class InitializationTests : XCTestCase {
	
	func testLiteralInitialization() {
		XCTAssertEqual(nil as JSON,           .null)
		XCTAssertEqual(true as JSON,          .bool(true))
		XCTAssertEqual([1, 2] as JSON,        .array([.number(1), .number(2)]))
		XCTAssertEqual(["x": 1] as JSON,      .object(["x": .number(1)]))
		XCTAssertEqual(3.4028236e+38 as JSON, .number(3.4028236e+38))
		XCTAssertEqual("foo" as JSON,         .string("foo"))
	}
	
	func testValueInitialization() throws {
		let num = 1
		let bool = true
		let str = "foo"
		let json = try JSON([
			"a": [num, bool] as [Any],
			"b": [str, [str], [str: bool]],
		])
		XCTAssertEqual(json, [
			"a": [1, true],
			"b": ["foo", ["foo"], ["foo": true]],
		])
	}
	
	func testUnknownTypeInitialization() {
		XCTAssertThrowsError(try JSON(["foo": Date()]))
	}
	
	func testNilInitializationFromAny() throws {
		XCTAssertEqual(try JSON(Optional<Int> .none as Any), .null)
		XCTAssertEqual(try JSON(Optional<Date>.none as Any), .null)
		XCTAssertThrowsError(try JSON(Optional<Date>.some(Date()) as Any))
	}
	
	func testNSNullInitialization() throws {
		XCTAssertEqual(try JSON(NSNull()), .null)
	}
	
	func testInitializationFromCodable() throws {
		struct Foo : Codable {
			var a: String = "foo"
			var b: Bool = true
		}
		
		let json = try JSON(encodable: Foo())
		XCTAssertEqual(json, [
			"a": "foo",
			"b": true,
		])
	}
	
	func testInitializationFromJSONSerilization() throws {
		let jsonData = Data("""
			{
				"array": [
					1,
					2,
					3
				],
				"boolean": true,
				"null": null,
				"number": 1,
				"greatest_int": \(Int.max),
				"greatest_double": \(Double.greatestFiniteMagnitude),
				"object": {
					"a": "b"
				},
				"string": "Hello World"
			}
			""".utf8)
		
		let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [])
		let json = try JSON(jsonObject)
		
		XCTAssertEqual(try XCTUnwrap(json["array"]),           JSON.array([1, 2, 3]))
		XCTAssertEqual(try XCTUnwrap(json["boolean"]),         JSON.bool(true))
		XCTAssertEqual(try XCTUnwrap(json["number"]),          JSON.number(1))
		XCTAssertEqual(try XCTUnwrap(json["greatest_int"]),    JSON.number(Double(Int.max)))
		XCTAssertEqual(try XCTUnwrap(json["greatest_double"]), JSON.number(Double.greatestFiniteMagnitude))
		XCTAssertEqual(try XCTUnwrap(json["null"]),            JSON.null)
		XCTAssertEqual(try XCTUnwrap(json["object"]),          JSON.object(["a": "b"]))
		XCTAssertEqual(try XCTUnwrap(json["string"]),          JSON.string("Hello World"))
		
	}
	
}
