import Apollo
import Foundation

class RequestHeadersInterceptor: ApolloInterceptor {
    // MARK: - Internal
    
    func interceptAsync<Operation>(
        chain: RequestChain,
        request: Apollo.HTTPRequest<Operation>,
        response: Apollo.HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void
    ) where Operation: GraphQLOperation {
        for (name, value) in HTTPHeaders.extra {
            request.addHeader(name: name, value: value)
        }
        chain.proceedAsync(request: request, response: response, completion: completion)
    }
    
    // MARK: - Private
}
