import Foundation

class HeadersRequestBehavior: RequestBehavior {
    // MARK: - Initializer
    
    init(headers: ExtraHeaders) {
        self.headers = headers
    }

    // MARK: - Public

    func modify(request: HTTPRequest) -> HTTPRequest {
        request.headers(request.headers.merging(headers.all, uniquingKeysWith: { lhs, _ in lhs }))
    }

    // MARK: - Private

    private var headers: ExtraHeaders
}
