import Foundation

extension URLSession {
    @discardableResult
    func responseJSON(with request: URLRequest,
                      completion: @escaping (JSONResponse) -> Void) -> URLSessionDataTask {
        let task = dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {
                let jsonResponse = JSONResponse(
                    result: self.resultError(from: error),
                    request: request,
                    response: response as? HTTPURLResponse
                )
                completion(jsonResponse)
                return
            }
            let result: Result<Data, HTTPError>
            switch response.statusCode {
            case 200 ..< 300:
                result = .success(data)
            case 401:
                result = .failure(.serverError(.unauthorized))
            case 404:
                result = .failure(.serverError(.notFound))
            case 500 ..< 600:
                result = .failure(.serverError(.unavailableService(error)))
            default:
                result = .failure(.serverError(.generic(error)))
            }
            
            let jsonResponse = JSONResponse(
                result: result,
                request: request,
                response: response
            )
            completion(jsonResponse)
        }
        task.resume()
        return task
    }
    
    private func resultError(from error: Error?) -> Result<Data, HTTPError> {
        guard let error = error else { return .failure(.transportError(.generic(error))) }
        var customError: TransportError = .generic(error)
        let nsError = error as NSError
        if nsError.domain == NSURLErrorDomain {
            if nsError.code == NSURLErrorCancelled {
                customError = .cancelled
            } else {
                customError = .unreachableService
            }
        }
        return .failure(.transportError(customError))
    }
}
