import Foundation

enum RefreshTokenEndpoint {
    static func request(refreshToken: String) -> HTTPRequest {
        HTTPRequest(
            method: .post,
            endPoint: "/v1/patient/jwt/refresh",
            parameters: [
                "refresh_token": refreshToken,
            ],
            headers: [
                "Content-Type": "application/json",
            ],
            requestId: UUID().uuidString
        )
    }
    
    struct Response: Decodable {
        let refreshToken: String
        let accessToken: String
    }
}
