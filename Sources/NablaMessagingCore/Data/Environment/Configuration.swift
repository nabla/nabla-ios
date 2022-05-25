import Foundation

public protocol Configuration {
    var domain: String { get }
    var scheme: String { get }
    var port: Int? { get }
    var path: String { get }
    var session: URLSession { get }
}

struct DefaultConfiguration: Configuration {
    let domain = "api.nabla.com"
    let scheme = "https"
    let port: Int? = nil
    let path = "/"
    let session = URLSession.shared
}
