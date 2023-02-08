import Apollo

protocol IGraphQLQueryWatcher {
    func refetch(cachePolicy: CachePolicy)
    func cancel()
}

extension IGraphQLQueryWatcher {
    func refetch() {
        refetch(cachePolicy: .fetchIgnoringCacheData)
    }
}

extension GraphQLQueryWatcher: IGraphQLQueryWatcher {}
