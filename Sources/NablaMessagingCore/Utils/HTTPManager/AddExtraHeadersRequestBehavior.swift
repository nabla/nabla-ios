import Foundation

class AddExtraHeadersRequestBehavior: RequestBehavior {
    // MARK: - Initializer
    
    init(headers: [String: String]) {
        self.headers = headers
    }

    // MARK: - Public

    func modify(request: HTTPRequest) -> HTTPRequest {
        request.headers(request.headers.merging(headers, uniquingKeysWith: { lhs, _ in lhs }))
    }

    func addHeader(key: String, value: String) {
        headers[key] = value
    }

    func removeHeader(key: String) {
        headers.removeValue(forKey: key)
    }

    // MARK: - Private

    private var headers: [String: String]
}
