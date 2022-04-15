import Foundation

protocol Environment {
    var serverUrl: URL { get }
    var graphqlPath: String { get }
    var packageName: String { get }
    var packageVersion: String { get }
}
