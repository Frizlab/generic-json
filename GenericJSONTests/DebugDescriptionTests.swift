import Foundation
import XCTest

@testable import GenericJSON



class DebugDescriptionTests : XCTestCase {
	
	func testObjectDebugDescription() {
		let object = JSON.object(["key": "val", "auto": 1])
		XCTAssertEqual(object.debugDescription, """
			{
			   "auto": 1.0,
			   "key": "val"
			}
			""")
	}
	
	func testArrayDebugDescription() {
		let object = JSON.array(["key", "val", "auto", 1])
		XCTAssertEqual(object.debugDescription, """
			[
			   "key",
			   "val",
			   "auto",
			   1.0
			]
			""")
	}
	
	func testNested() {
		let object: JSON = [
			"string": "foo bar",
			"boolean": true,
			"number": 123,
			"object": [
				"str": "col",
				"arr": [1, 2, 3],
				"obj": [
					"x": "rah",
					"y": "tar",
					"z": "yaz"
				]
			]
		]
		XCTAssertEqual(object.debugDescription, """
			{
			   "boolean": true,
			   "number": 123.0,
			   "object": {
			      "arr": [
			         1.0,
			         2.0,
			         3.0
			      ],
			      "obj": {
			         "x": "rah",
			         "y": "tar",
			         "z": "yaz"
			      },
			      "str": "col"
			   },
			   "string": "foo bar"
			}
			""")
	}
	
}
