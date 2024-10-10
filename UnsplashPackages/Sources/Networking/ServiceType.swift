import Foundation

public enum RequestMethod: String {
    case get
    case post
}

public protocol ServiceType {
    var path: String { get }
    var method: RequestMethod { get }
    var quertyItems: [URLQueryItem]? { get }
    var data: Data? { get }
}

public extension ServiceType {
    var quertyItems: [URLQueryItem]? { nil }
    var data: Data? { nil }
}
