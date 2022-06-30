import Foundation

enum RefreshTokenEndpoint {
    static func request(refreshToken: String) -> HTTPRequest {
        HTTPRequest(
            method: .post,
            endPoint: "/v1/patient/jwt/refresh"
        )
        .body(json: [
            "refresh_token": refreshToken,
        ])
    }
    
    struct Response: Decodable {
        let refreshToken: String
        let accessToken: String
    }
}
