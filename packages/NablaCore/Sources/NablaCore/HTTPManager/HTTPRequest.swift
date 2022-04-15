import Foundation

public struct HTTPRequest {
    public enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }

    public enum ParametersEncoding {
        case queryString
        case httpBody
    }

    let id: String

    private(set) var method: Method
    private(set) var endPoint: String
    private(set) var parameters: [String: Any]
    private(set) var headers: [String: String]
    private(set) var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy

    public init(
        method: Method = .get,
        endPoint: String,
        parameters: [String: Any] = [:],
        headers: [String: String] = [:],
        keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase,
        requestId: String? = nil
    ) {
        self.method = method
        self.endPoint = endPoint
        self.parameters = parameters
        self.headers = headers
        self.keyDecodingStrategy = keyDecodingStrategy
        id = requestId ?? UUID().uuidString
    }

    // MARK: - Builder pattern

    func method(_ method: Method) -> HTTPRequest {
        var request = self
        request.method = method
        return request
    }

    func parameters(_ parameters: [String: Any]) -> HTTPRequest {
        var request = self
        request.parameters = parameters
        return request
    }

    func headers(_ headers: [String: String]) -> HTTPRequest {
        var request = self
        request.headers = headers
        return request
    }
}

extension HTTPRequest {
    static func post<E: Encodable>(endPoint: String, parameters _: E) -> HTTPRequest {
        HTTPRequest(endPoint: endPoint)
            .method(.post)
    }

    static func put<E: Encodable>(endPoint: String, parameters _: E) -> HTTPRequest {
        HTTPRequest(endPoint: endPoint)
            .method(.put)
    }

    static func post(endPoint: String) -> HTTPRequest {
        HTTPRequest(endPoint: endPoint)
            .method(.post)
    }

    static func put(endPoint: String) -> HTTPRequest {
        HTTPRequest(endPoint: endPoint)
            .method(.put)
    }

    static func get(endPoint: String) -> HTTPRequest {
        HTTPRequest(endPoint: endPoint)
            .method(.get)
    }
}
