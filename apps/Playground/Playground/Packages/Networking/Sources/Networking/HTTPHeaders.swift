import Foundation

enum HTTPHeaders {
    static let Accept = "Accept"
    static let Authorization = "Authorization"
    static let NablaAuthorization = "X-Nabla-Authorization"
    
    static var extra = [String: String]()
}
