import Foundation

extension URLSession {
    /// - Throws: ``HTTPError``
    func responseJSON(with request: URLRequest) async throws -> JSONResponse {
        do {
            let (data, response) = try await retroCompatibleData(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw HTTPError.transportError(.noResponse)
            }
            
            switch httpResponse.statusCode {
            case 200 ..< 300:
                return JSONResponse(
                    data: data,
                    request: request,
                    response: httpResponse
                )
            case 401:
                throw HTTPError.serverError(.unauthorized)
            case 404:
                throw HTTPError.serverError(.notFound)
            case 500 ..< 600:
                throw HTTPError.serverError(.unavailableService(nil))
            default:
                throw HTTPError.serverError(.generic(nil))
            }
        } catch let error as HTTPError {
            throw error
        } catch {
            throw triageError(error)
        }
    }
    
    private func triageError(_ error: Error) -> HTTPError {
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain {
            if nsError.code == NSURLErrorCancelled {
                return .transportError(.cancelled)
            } else {
                return .transportError(.unreachableService)
            }
        }
        return .transportError(.generic(error))
    }
    
    private func retroCompatibleData(for request: URLRequest) async throws -> (Data, URLResponse) {
        if #available(iOS 15, *) {
            return try await data(for: request)
        }
        return try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<(Data, URLResponse), Error>) in
            dataTask(with: request) { data, response, error in
                if let data = data, let response = response {
                    continuation.resume(returning: (data, response))
                } else if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(throwing: HTTPError.transportError(.generic(nil)))
                }
            }
        }
    }
}
