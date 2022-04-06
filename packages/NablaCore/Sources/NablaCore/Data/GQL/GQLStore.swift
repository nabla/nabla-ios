import Apollo
import Foundation

class GQLStore {
    let apollo: ApolloStore
    
    init(
        cache: NormalizedCache = InMemoryNormalizedCache()
    ) {
        apollo = ApolloStore(cache: cache)
    }
}
