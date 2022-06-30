import Apollo
import Foundation

class RequestHeadersInterceptor: ApolloInterceptor {
    // MARK: - Initializer

    init(
        environment: Environment,
        extraHeaders: ExtraHeaders
    ) {
        self.environment = environment
        self.extraHeaders = extraHeaders
    }

    // MARK: - Internal
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: Apollo.HTTPRequest<Operation>,
        response: Apollo.HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation: GraphQLOperation {
        request.addHeader(name: HTTPHeaders.Platform, value: environment.platform)
        request.addHeader(name: HTTPHeaders.Version, value: environment.version)
        for (name, value) in extraHeaders.all {
            request.addHeader(name: name, value: value)
        }
        chain.proceedAsync(request: request, response: response, completion: completion)
    }
    
    // MARK: - Private

    private let environment: Environment
    private let extraHeaders: ExtraHeaders
}
