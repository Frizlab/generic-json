import Foundation



extension JSON : CustomDebugStringConvertible {
	
	public var debugDescription: String {
		switch self {
			case .string(let str): return str.debugDescription
			case .number(let num): return num.debugDescription
			case .bool(let bool):  return bool.description
			case .null:            return "null"
			default:
				/* TODO: Avoid going through a JSON encoder to create a String representation of the JSON! */
				let encoder = JSONEncoder()
				encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
				if #available(macOS 10.15, tvOS 13, iOS 13, watchOS 6, *) {
					encoder.outputFormatting = encoder.outputFormatting.union(.withoutEscapingSlashes)
				}
				return try! String(data: encoder.encode(self), encoding: .utf8)!
		}
	}
}
