import Foundation

enum UploadEndpoint {
    static func request() -> HTTPRequest {
        HTTPRequest(
            method: .post,
            endPoint: "/v1/patient/upload"
        )
    }
    
    typealias Result = [String]
}
