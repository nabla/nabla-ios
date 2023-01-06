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
    private var requestCounts = [String: Int]()
    private let queue = DispatchQueue(label: "com.nabla.MockURLSessionClient", qos: .userInteractive)
    
    private enum Constants {
        static let unknownOperationName = "unknown"
    }
    
    override func sendRequest(_ request: URLRequest, rawTaskCompletionHandler _: URLSessionClient.RawCompletion? = nil, completion: @escaping URLSessionClient.Completion) -> URLSessionTask {
        let stampedRequest = stamp(request)
        let task = mockSession.dataTask(with: stampedRequest) { data, response, error in
            if let error = error {
                return completion(.failure(error))
            }
            if let data = data, let response = response as? HTTPURLResponse {
                return completion(.success((data, response)))
            }
            completion(.failure(TestError.unexpectedResponse))
        }
        task.resume()
        return task
    }
    
    private func stamp(_ request: URLRequest) -> URLRequest {
        queue.sync {
            do {
                let operationName = request.allHTTPHeaderFields?["X-APOLLO-OPERATION-NAME"] ?? Constants.unknownOperationName
                guard let bodyData = request.httpBody else { return request }
                guard var body = try JSONSerialization.jsonObject(with: bodyData) as? [String: Any] else { return request }
                let requestCount = requestCounts[operationName, default: 0]
                body["Tests-Request-Index"] = requestCount
                var copy = request
                copy.httpBody = try JSONSerialization.data(withJSONObject: body)
                requestCounts[operationName] = requestCount + 1
                return copy
            } catch {
                return request
            }
        }
    }
}
