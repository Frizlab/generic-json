import Foundation



extension JSON : CustomDebugStringConvertible {
	
	public var debugDescription: String {
		return debugDescription(level: 0)
	}
	
	private func debugDescription(level: Int, indentSize: Int = 3) -> String {
		/* For String, the debug description _looks_ compatible enough with a JSON String representation.
		 * There are probably edge cases, but as we do not guarantee a valid JSON representation in the debug decription it’ll do.
		 *
		 * For the number, the debug description always has a decimal part where none are present usually in JSON, but it’s still valid. */
		switch self {
			case .string(let str):                     return str.debugDescription
			case .number(let num):                     return num.debugDescription
			case .bool(false):                         return "false"
			case .bool(true):                          return "true"
			case .null:                                return "null"
			case .array(let elts)  where elts.isEmpty: return "[]"
			case .object(let elts) where elts.isEmpty: return "{}"
				
			case .array(let elts):
				let indent = String(repeating: " ", count: level * indentSize)
				let indentPlus1 = indent + String(repeating: " ", count: indentSize)
				let content = elts
					.map{ $0.debugDescription(level: level + 1, indentSize: indentSize) }
					.joined(separator: ",\n\(indentPlus1)")
				return "[\n\(indentPlus1)\(content)\n\(indent)]"
				
			case .object(let elts):
				let indent = String(repeating: " ", count: level * indentSize)
				let indentPlus1 = indent + String(repeating: " ", count: indentSize)
				let content = elts.sorted{ $0.key < $1.key }
					.map{ $0.key.debugDescription + ": " + $0.value.debugDescription(level: level + 1, indentSize: indentSize) }
					.joined(separator: ",\n\(indentPlus1)")
				return "{\n\(indentPlus1)\(content)\n\(indent)}"
		}
	}
	
}
