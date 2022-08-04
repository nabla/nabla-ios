import Foundation

public protocol Environment {
    var platform: String { get }
    var languageCode: String { get }
    var version: String { get }
    var serverUrl: URL { get }
    var graphqlHttpUrl: URL { get }
    var graphqlWebSocketUrl: URL { get }
}
