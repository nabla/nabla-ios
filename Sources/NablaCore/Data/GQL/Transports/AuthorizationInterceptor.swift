import Apollo
import Foundation

class AuthorizationInterceptor: ApolloInterceptor {
    // MARK: - Initializer

    init(authenticator: Authenticator) {
        self.authenticator = authenticator
    }

    // MARK: - Internal
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: Apollo.HTTPRequest<Operation>,
        response: Apollo.HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation: GraphQLOperation {
        Task(priority: .userInitiated) {
            do {
                let state = try await authenticator.getAccessToken()
                switch state {
                case .notAuthenticated:
                    chain.proceedAsync(request: request, response: response, completion: completion)
                case let .authenticated(accessToken):
                    request.addHeader(name: HTTPHeaders.NablaAuthorization, value: "Bearer \(accessToken)")
                    chain.proceedAsync(request: request, response: response, completion: { [authenticator] result in
                        if case let .failure(error) = result, AuthorizationInterceptor.isAuthenticationError(error) {
                            authenticator.markTokensAsInvalid()
                        }
                        
                        completion(result)
                    })
                }
            } catch {
                chain.handleErrorAsync(error, request: request, response: response, completion: completion)
            }
        }
    }
    
    // MARK: - Private
    
    private let authenticator: Authenticator
    
    private static func isAuthenticationError(_ error: Error) -> Bool {
        if let responseCodeError = error as? Apollo.ResponseCodeInterceptor.ResponseCodeError,
           case let .invalidResponseCode(response, _) = responseCodeError,
           response?.statusCode == 401 {
            return true
        }
        
        return false
    }
}
