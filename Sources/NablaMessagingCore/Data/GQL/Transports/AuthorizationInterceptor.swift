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
        authenticator.getAccessToken(
            handler: .init { result in
                switch result {
                case let .failure(error):
                    chain.handleErrorAsync(error, request: request, response: response, completion: completion)
                case let .success(state):
                    switch state {
                    case .notAuthenticated:
                        chain.proceedAsync(request: request, response: response, completion: completion)
                    case let .authenticated(accessToken):
                        request.addHeader(name: HTTPHeaders.NablaAuthorization, value: "Bearer \(accessToken)")
                        chain.proceedAsync(request: request, response: response, completion: completion)
                    }
                }
            })
    }
    
    // MARK: - Private
    
    private let authenticator: Authenticator
}
