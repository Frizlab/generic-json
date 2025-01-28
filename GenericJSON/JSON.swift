import Foundation



/**
 A JSON value representation.
 
 This is a bit more useful than the naïve `[String: Any]` type for JSON values,
  since it makes sure only valid JSON values are present & supports `Equatable` and `Codable`,
  so that you can compare values for equality and code and decode them into data or strings. */
@dynamicMemberLookup
public enum JSON : Equatable, Hashable, GenericJSON_Sendable {
	
	case string(String)
	case number(Double)
	case object([String: JSON])
	case array([JSON])
	case bool(Bool)
	case null
	
	/**
	 Dynamic member lookup sugar for string subscripts.
	 
	 This lets you write `json.foo` instead of `json["foo"]`. */
	public subscript(dynamicMember member: String) -> JSON? {
		return self[member]
	}
	
}
