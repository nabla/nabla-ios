import Foundation
import Networking

enum AuthenticateEndpoint {
    static func request(userId: UUID) -> HTTPRequest {
        HTTPRequest(
            method: .get,
            endPoint: "/v1/privileged/jwt/patient/authenticate/\(userId)"
        )
    }
    
    struct Response: Decodable {
        let refreshToken: String
        let accessToken: String
    }
}
