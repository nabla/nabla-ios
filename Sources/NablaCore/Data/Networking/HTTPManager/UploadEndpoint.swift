import Foundation

enum UploadEndpoint {
    static func request() -> HTTPRequest {
        HTTPRequest(
            method: .post,
            endPoint: "/v1/upload/patient"
        )
    }
    
    typealias Result = [String]
}
