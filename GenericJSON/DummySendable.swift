import Foundation


#if swift(>=5.5)
public protocol GenericJSON_Sendable : Sendable {}
#else
public protocol GenericJSON_Sendable {}
#endif
