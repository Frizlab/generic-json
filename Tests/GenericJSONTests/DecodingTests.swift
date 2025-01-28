import Foundation
import XCTest

@testable import GenericJSON



final class DecodingTests : XCTestCase {
	
	func testDecodeAs() {
		struct Foo : Decodable, Equatable {var foo: String}
		let json: JSON = ["foo": "bar"]
		XCTAssertEqual(try json.decode(), Foo(foo: "bar"))
	}
	
}
