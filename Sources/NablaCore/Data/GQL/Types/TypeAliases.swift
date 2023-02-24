import Apollo
#if canImport(ApolloAPI)
    import ApolloAPI

    public typealias GQLQuery = ApolloAPI.GraphQLQuery
    public typealias GQLMutation = ApolloAPI.GraphQLMutation
    public typealias GQLSubscription = ApolloAPI.GraphQLSubscription
    public typealias GQLFragment = ApolloAPI.Fragment
#else
    public typealias GQLQuery = Apollo.GraphQLQuery
    public typealias GQLMutation = Apollo.GraphQLMutation
    public typealias GQLSubscription = Apollo.GraphQLSubscription
    public typealias GQLFragment = Apollo.Fragment
#endif
public typealias CachePolicy = Apollo.CachePolicy
