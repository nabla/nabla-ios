import Apollo
import Foundation
import NablaUtils

class AuthorizationInterceptor: ApolloInterceptor {
    // MARK: - Internal
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: Apollo.HTTPRequest<Operation>,
        response: Apollo.HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation: GraphQLOperation {
        authenticator.getAccessToken { result in
            switch result {
            case let .failure(error):
                chain.handleErrorAsync(error, request: request, response: response, completion: completion)
            case let .success(state):
                switch state {
                case .unauthenticated:
                    chain.proceedAsync(request: request, response: response, completion: completion)
                case let .authenticated(accessToken):
                    request.addHeader(name: HTTPHeaders.NablaAuthorization, value: "Bearer \(accessToken)")
                    chain.proceedAsync(request: request, response: response, completion: completion)
                }
            }
        }
    }
    
    // MARK: - Private
    
    @Inject private var authenticator: Authenticator
}
