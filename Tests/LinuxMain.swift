import Foundation
import XCTest

@testable import GenericJSONTests



var tests: [XCTestCaseEntry] = [
	testCase([
		("testEncoding", CodingTests.testEncoding),
		("testDecoding", CodingTests.testDecoding),
		("testDecodingBool", CodingTests.testDecodingBool),
		("testEmptyCollectionDecoding", CodingTests.testEmptyCollectionDecoding),
		("testDebugDescriptions", CodingTests.testDebugDescriptions),
	]),
	testCase([
		("testObjectDebugDescription", DebugDescriptionTests.testObjectDebugDescription),
		("testArrayDebugDescription", DebugDescriptionTests.testArrayDebugDescription),
		("testNested", DebugDescriptionTests.testNested),
	]),
	testCase([
		("testDecodeAs", DecodingTests.testDecodeAs),
	]),
	testCase([
		("testEquality", EqualityTests.testEquality),
	]),
	testCase([
		("testLiteralInitialization", InitializationTests.testLiteralInitialization),
		("testValueInitialization", InitializationTests.testValueInitialization),
		("testUnknownTypeInitialization", InitializationTests.testUnknownTypeInitialization),
		("testNilInitializationFromAny", InitializationTests.testNilInitializationFromAny),
		("testNSNullInitialization", InitializationTests.testNSNullInitialization),
		("testInitializationFromCodable", InitializationTests.testInitializationFromCodable),
		("testInitializationFromJSONSerilization", InitializationTests.testInitializationFromJSONSerilization),
	]),
	testCase([
		("testMerging", MergingTests.testMerging),
		("testMergingPrimitives", MergingTests.testMergingPrimitives),
	]),
	testCase([
		("testStringValue", QueryingTests.testStringValue),
		("testFloatValue", QueryingTests.testFloatValue),
		("testBoolValue", QueryingTests.testBoolValue),
		("testObjectValue", QueryingTests.testObjectValue),
		("testArrayValue", QueryingTests.testArrayValue),
		("testNullValue", QueryingTests.testNullValue),
		("testArraySubscripting", QueryingTests.testArraySubscripting),
		("testStringSubscripting", QueryingTests.testStringSubscripting),
		("testStringSubscriptingSugar", QueryingTests.testStringSubscriptingSugar),
		("testKeyPath", QueryingTests.testKeyPath),
	]),
]
#if !os(WASI)
XCTMain(tests)

#else
/* Compilation fails for Swift <5.5… */
//await XCTMain(tests)

/* Let’s print a message to inform the tests on WASI are disabled. */
let brightRed = "\u{1B}[91;1m"
let gray = "\u{1B}[38;5;245m"
let magenta = "\u{1B}[35;1m"
let reset = "\u{1B}[0m"
try FileHandle.standardError.write(contentsOf: Data("""
\(brightRed)Tests are disabled on WASI\(reset):
\(gray)This package is compatible with Swift <5.4, so we have to add a LinuxMain file in which we call XCTMain.
On WASI the XCTMain function is async, so we have to #if the XCTMain call, one with the await keyword, the other without.
However, on Swift <5.5 the LinuxMain setup like this does not compile because the old compiler does not know the await keyword
 (even though the whole code is ignored because we do not compile for WASI whe compiling with an old compiler).
I also tried doing a #if swift(>=5.5) check, but that do not work either.\(reset)

\(magenta)To temporarily enable the tests for WASI, uncomment the `await XCTMain(tests)` line in LinuxMain.swift.\(reset)

""".utf8))

#endif
