import Foundation

public final class HTTPManager {
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
    
    /// - Throws: ``HTTPError``
    public func fetch<Resource: Decodable>(
        _ type: Resource.Type,
        associatedTo request: HTTPRequest
    ) async throws -> Resource {
        let response = try await fetch(request)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = request.keyDecodingStrategy
        
        do {
            return try decoder.decode(type, from: response.data)
        } catch {
            throw HTTPError.decodingError(error)
        }
    }
    
    /// - Throws: ``HTTPError``
    public func fetch(_ baseRequest: HTTPRequest) async throws -> JSONResponse {
        let updatedRequest = requestBehavior.modify(request: baseRequest)
        
        guard let urlRequest = urlRequestMapper.map(httpRequest: updatedRequest) else {
            fatalError()
        }
        
        requestBehavior.beforeSend(request: updatedRequest)
        
        let response = try await session.responseJSON(with: urlRequest)
        requestBehavior.afterSend(request: baseRequest, response: response)
        let alteredResponse = requestBehavior.modify(
            request: updatedRequest,
            response: response
        )
        return alteredResponse
    }

    // MARK: - Private

    private let session: URLSession
    private let requestBehavior: RequestBehavior
    private let urlRequestMapper: URLRequestMapper
}
