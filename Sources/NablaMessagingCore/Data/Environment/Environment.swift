import Foundation

protocol Environment {
    var serverUrl: URL { get }
    var graphqlHttpUrl: URL { get }
    var graphqlWebSocketUrl: URL { get }
    var packageName: String { get }
    var packageVersion: String { get }
}
