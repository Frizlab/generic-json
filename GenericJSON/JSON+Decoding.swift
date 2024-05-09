import Foundation



public extension JSON {
	
	/**
	 Decode the receiver as another type.
	 
	 The function will encode the receiver using the given encoder and decode the resulting data as T using the given decoder.
	 
	 This is not efficient!
	 But it can be very convenient. */
	func decode<T : Decodable>(as newType: T.Type = T.self, encoder: JSONEncoder = .init(), decoder: JSONDecoder = .init()) throws -> T {
		let encoded = try encoder.encode(self)
		return try decoder.decode(newType.self, from: encoded)
	}
	
}
