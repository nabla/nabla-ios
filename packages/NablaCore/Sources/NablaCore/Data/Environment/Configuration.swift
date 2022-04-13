import Foundation

public protocol Configuration {
    var domain: String { get }
    var scheme: String { get }
}

struct DefaultConfiguration: Configuration {
    let domain = "api.nabla.com"
    let scheme = "https"
}
