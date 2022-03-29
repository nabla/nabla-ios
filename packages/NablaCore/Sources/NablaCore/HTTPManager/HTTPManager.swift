import Foundation

public class HTTPManager {
    private let session: URLSession
    private let requestBehavior: RequestBehavior
    private let urlRequestMapper: URLRequestMapper

    public init(baseURLProvider: BaseURLProvider,
                session: URLSession = URLSession.shared,
                requestBehavior: RequestBehavior = EmptyRequestBehavior()) {
        self.session = session
        self.requestBehavior = requestBehavior
        urlRequestMapper = URLRequestMapper(baseUrlProvider: baseURLProvider)
    }

    // MARK: - Public

    @discardableResult
    public func fetch<Resource: Decodable>(_ type: Resource.Type,
                                           associatedTo request: HTTPRequest,
                                           completion: @escaping (Result<Resource, Error>) -> Void) -> String {
        fetch(request) { response in
            switch response.result {
            case let .success(data):
                do {
                    let value = try JSONDecoder().decode(type, from: data)
                    completion(.success(value))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    @discardableResult
    public func fetch(_ baseRequest: HTTPRequest,
                      completion: @escaping (JSONResponse) -> Void) -> String {
        let updatedRequest = requestBehavior.modify(request: baseRequest)

        guard let urlRequest = urlRequestMapper.map(httpRequest: baseRequest) else {
            fatalError()
        }

        requestBehavior.beforeSend(request: updatedRequest)

        session.responseJSON(with: urlRequest) { [weak self] response in
            self?.requestBehavior.afterSend(request: baseRequest, response: response)
            let alteredResponse = self?.requestBehavior.modify(
                request: updatedRequest,
                response: response
            ) ?? response
            completion(alteredResponse)
        }

        return updatedRequest.id
    }
}
