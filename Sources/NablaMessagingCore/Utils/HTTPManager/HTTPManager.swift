import Foundation

final class HTTPManager {
    // MARK: - Initializer
    
    public init(
        baseURLProvider: BaseURLProvider,
        session: URLSession = URLSession.shared,
        requestBehavior: RequestBehavior = EmptyRequestBehavior()
    ) {
        self.session = session
        self.requestBehavior = requestBehavior
        urlRequestMapper = URLRequestMapper(baseUrlProvider: baseURLProvider)
    }
    
    // MARK: - Public
    
    @discardableResult
    public func fetch<Resource: Decodable>(
        _ type: Resource.Type,
        associatedTo request: HTTPRequest,
        completion: @escaping (Result<Resource, HTTPError>) -> Void
    ) -> Cancellable {
        fetch(request) { response in
            switch response.result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = request.keyDecodingStrategy
                    let value = try decoder.decode(type, from: data)
                    completion(.success(value))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    public func fetch(
        _ baseRequest: HTTPRequest,
        completion: @escaping (JSONResponse) -> Void
    ) -> Cancellable {
        let updatedRequest = requestBehavior.modify(request: baseRequest)
        
        guard let urlRequest = urlRequestMapper.map(httpRequest: updatedRequest) else {
            fatalError()
        }
        
        requestBehavior.beforeSend(request: updatedRequest)
        
        return session.responseJSON(with: urlRequest) { [weak self] response in
            self?.requestBehavior.afterSend(request: baseRequest, response: response)
            let alteredResponse = self?.requestBehavior.modify(
                request: updatedRequest,
                response: response
            ) ?? response
            completion(alteredResponse)
        }
    }

    // MARK: - Private

    private let session: URLSession
    private let requestBehavior: RequestBehavior
    private let urlRequestMapper: URLRequestMapper
}

extension URLSessionDataTask: Cancellable {}
