import Apollo
import DVR
import Foundation

class MockURLSessionClient: URLSessionClient {
    enum TestError: Error {
        case unexpectedResponse
    }
    
    init(session: DVR.Session) {
        mockSession = session
        super.init(sessionConfiguration: .default, callbackQueue: nil)
    }
    
    private let mockSession: DVR.Session
    private var requestCount = 0
    
    override func sendRequest(_ request: URLRequest, rawTaskCompletionHandler _: URLSessionClient.RawCompletion? = nil, completion: @escaping URLSessionClient.Completion) -> URLSessionTask {
        let stampedRequest = stamp(request)
        let task = mockSession.dataTask(with: stampedRequest) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            if let data = data, let response = response as? HTTPURLResponse {
                return completion(.success((data, response)))
            }
            print(type(of: response))
            completion(.failure(TestError.unexpectedResponse))
        }
        task.resume()
        return task
    }
    
    private func stamp(_ request: URLRequest) -> URLRequest {
        do {
            guard let bodyData = request.httpBody else { return request }
            guard var body = try JSONSerialization.jsonObject(with: bodyData) as? [String: Any] else { return request }
            body["Tests-Request-Index"] = requestCount
            var copy = request
            copy.httpBody = try JSONSerialization.data(withJSONObject: body)
            requestCount += 1
            return copy
        } catch {
            return request
        }
    }
}
