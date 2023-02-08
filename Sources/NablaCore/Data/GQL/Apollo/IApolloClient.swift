import Apollo

/// Mockable interface to abstract `ApolloClient` during tests.
protocol IApolloClient {
    func watch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        resultHandler: @escaping GraphQLResultHandler<Query.Data>
    ) -> IGraphQLQueryWatcher
    func subscribe<Subscription: GraphQLSubscription>(
        subscription: Subscription,
        resultHandler: @escaping GraphQLResultHandler<Subscription.Data>
    ) -> Apollo.Cancellable
}

extension ApolloClient: IApolloClient {
    func watch<Query: GraphQLQuery>(
        query: Query,
        cachePolicy: CachePolicy,
        resultHandler: @escaping GraphQLResultHandler<Query.Data>
    ) -> IGraphQLQueryWatcher {
        watch(
            query: query,
            cachePolicy: cachePolicy,
            callbackQueue: .global(qos: .userInitiated),
            resultHandler: resultHandler
        )
    }
    
    func subscribe<Subscription: GraphQLSubscription>(
        subscription: Subscription,
        resultHandler: @escaping GraphQLResultHandler<Subscription.Data>
    ) -> Apollo.Cancellable {
        subscribe(
            subscription: subscription,
            queue: .global(qos: .userInitiated),
            resultHandler: resultHandler
        )
    }
}
