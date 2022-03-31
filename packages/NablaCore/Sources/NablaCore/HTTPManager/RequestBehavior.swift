import Foundation

public protocol RequestBehavior {
    func beforeSend(request: HTTPRequest)
    func modify(request: HTTPRequest) -> HTTPRequest
    func modify(request: HTTPRequest, response: JSONResponse) -> JSONResponse
    func afterSend(request: HTTPRequest, response: JSONResponse)
    func afterCancel(request: HTTPRequest)
}

public extension RequestBehavior {
    func beforeSend(request _: HTTPRequest) {}

    func modify(request: HTTPRequest) -> HTTPRequest {
        request
    }

    func modify(request _: HTTPRequest, response: JSONResponse) -> JSONResponse {
        response
    }

    func afterSend(request _: HTTPRequest, response _: JSONResponse) {}

    func afterCancel(request _: HTTPRequest) {}
}

public struct EmptyRequestBehavior: RequestBehavior {
    public init() {}
}

public struct CombinedRequestBehavior: RequestBehavior {
    let behaviors: [RequestBehavior]

    public func beforeSend(request: HTTPRequest) {
        behaviors.forEach { $0.beforeSend(request: request) }
    }

    public func modify(request: HTTPRequest) -> HTTPRequest {
        behaviors.reduce(request) { resultRequest, behavior -> HTTPRequest in
            behavior.modify(request: resultRequest)
        }
    }

    public func modify(request: HTTPRequest, response: JSONResponse) -> JSONResponse {
        behaviors.reduce(response) { resultResponse, behavior -> JSONResponse in
            behavior.modify(request: request, response: resultResponse)
        }
    }

    public func afterSend(request: HTTPRequest, response: JSONResponse) {
        behaviors.forEach { $0.afterSend(request: request, response: response) }
    }

    public func afterCancel(request: HTTPRequest) {
        behaviors.forEach { $0.afterCancel(request: request) }
    }
}
