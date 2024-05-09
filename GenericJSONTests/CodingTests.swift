import Foundation
import XCTest

@testable import GenericJSON



class CodingTests : XCTestCase {
	
	func testEncoding() throws {
		let json: JSON = [
			"num": 1,
			"str": "baz",
			"bool": true,
			"null": nil,
			"array": [],
			"obj": [:],
		]
		let encoder = JSONEncoder()
		encoder.outputFormatting = .sortedKeys
		let encoded = try encoder.encode(json)
		let str = try XCTUnwrap(String(data: encoded, encoding: .utf8))
		XCTAssertEqual(str, #"{"array":[],"bool":true,"null":null,"num":1,"obj":{},"str":"baz"}"#)
	}
	
	func testDecoding() throws {
		let input = #"{"array":[1],"num":1,"bool":true,"obj":{},"null":null,"str":"baz"}"#
		let json = try JSONDecoder().decode(JSON.self, from: Data(input.utf8))
		XCTAssertEqual(json, [
			"num": 1,
			"str": "baz",
			"bool": true,
			"null": nil,
			"array": [1],
			"obj": [:],
		])
	}
	
	func testDecodingBool() throws {
		XCTAssertEqual(try JSONDecoder().decode(JSON.self, from: Data(#"{"b":true}"#.utf8)), ["b": true])
		XCTAssertEqual(try JSONDecoder().decode(JSON.self, from: Data(#"{"n":1}"#   .utf8)), ["n": 1])
	}
	
	func testEmptyCollectionDecoding() throws {
		XCTAssertEqual(try JSONDecoder().decode(JSON.self, from: Data("[]".utf8)), [])
		XCTAssertEqual(try JSONDecoder().decode(JSON.self, from: Data("{}".utf8)), [:])
	}
	
	func testDebugDescriptions() {
		let fragments: [JSON] = ["foo", 1, true, nil]
		let descriptions = fragments.map{ $0.debugDescription }
		XCTAssertEqual(descriptions, [#""foo""#, "1.0", "true", "null"])
	}
	
}
