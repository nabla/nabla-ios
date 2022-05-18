import Apollo
import Foundation

class RequestHeadersInterceptor: ApolloInterceptor {
    // MARK: - Initializer

    init(extraHeaders: [String: String]) {
        self.extraHeaders = extraHeaders
    }

    // MARK: - Internal
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: Apollo.HTTPRequest<Operation>,
        response: Apollo.HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation: GraphQLOperation {
        for (name, value) in extraHeaders {
            request.addHeader(name: name, value: value)
        }
        chain.proceedAsync(request: request, response: response, completion: completion)
    }
    
    // MARK: - Private

    private let extraHeaders: [String: String]
}
