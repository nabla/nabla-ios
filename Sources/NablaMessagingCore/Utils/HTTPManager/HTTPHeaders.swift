import Foundation

enum HTTPHeaders {
    static let Accept = "Accept"
    static let Authorization = "Authorization"
    static let NablaAuthorization = "X-Nabla-Authorization"
    static let ContentType = "Content-Type"
    static let NablaApiKey = "X-Nabla-API-Key"
    
    static var extra = [String: String]()
}
