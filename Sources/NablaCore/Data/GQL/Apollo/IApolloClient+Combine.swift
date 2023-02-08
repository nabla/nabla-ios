import Apollo
import Combine
import Foundation

extension IApolloClient {
    func watch<Q: GraphQLQuery>(query: Q, cachePolicy: CachePolicy) -> AnyPublisher<GraphQLResult<Q.Data>, Error> {
        ApolloPublisher { resultHandler in
            let watcher = self.watch(
                query: query,
                cachePolicy: cachePolicy,
                resultHandler: resultHandler
            )

            let refresher = RefetchTrigger.refetchPublisher.sink { _ in
                watcher.refetch()
            }

            return AnyCancellable {
                watcher.cancel()
                refresher.cancel()
            }
        }
        .eraseToAnyPublisher()
    }
    
    func watchAndUpdate<Q: GraphQLQuery>(query: Q) -> AnyPublisher<AnyResponse<Q.Data, Error>, Error> {
        var isRefreshing = true
        var isDataFresh = false
        
        return ApolloPublisher { resultHandler in
            var previousData: Q.Data?
            
            let watcher = self.watch(query: query, cachePolicy: .returnCacheDataAndFetch) { output in
                switch output {
                case let .failure(error):
                    if let previousData = previousData {
                        let response = Self.makeResponse(fromPreviousData: previousData, withError: error)
                        return resultHandler(.success(response))
                    } else {
                        return resultHandler(.failure(error))
                    }
                case let .success(result):
                    if result.source == .server {
                        // We are "refreshing" until we've received data from the server.
                        // As soon as a first `server` data is seen, we assume the data is fresh.
                        // If a subscription receives an update, it will emit a new data with `cache` source,
                        // but the data will still be fresh.
                        isRefreshing = false
                        isDataFresh = true
                    }
                    if let response = Self.makeResponse(result, previousData, isDataFresh, isRefreshing) {
                        previousData = response.data
                        return resultHandler(.success(response))
                    } else {
                        let error: Error = result.errors?.first ?? GQLError.emptyServerResponse
                        return resultHandler(.failure(error))
                    }
                }
            }
            
            let refresher = RefetchTrigger.refetchPublisher.sink { _ in
                isRefreshing = true
                watcher.refetch()
            }
            
            return AnyCancellable {
                watcher.cancel()
                refresher.cancel()
            }
        }
        .eraseToAnyPublisher()
    }
    
    func subscribe<S: GraphQLSubscription>(subscription: S) -> AnyPublisher<GraphQLResult<S.Data>, Error> {
        ApolloPublisher { resultHandler in
            let subscriber = self.subscribe(subscription: subscription, resultHandler: resultHandler)
            return AnyCancellable {
                subscriber.cancel()
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Private
    
    private static func makeResponse<T>(
        _ result: GraphQLResult<T>,
        _ previousData: T?,
        _ isDataFresh: Bool,
        _ isRefreshing: Bool
    ) -> AnyResponse<T, Error>? {
        if let data = result.data {
            if let error = result.errors?.first {
                return .init(
                    data: data,
                    isDataFresh: false,
                    refreshingState: .failed(error: error)
                )
            } else {
                return .init(
                    data: data,
                    isDataFresh: isDataFresh,
                    refreshingState: isRefreshing ? .refreshing : .refreshed
                )
            }
        } else if let previousData = previousData {
            if let error = result.errors?.first {
                return makeResponse(fromPreviousData: previousData, withError: error)
            } else {
                return makeResponse(fromPreviousData: previousData, withError: GQLError.emptyServerResponse)
            }
        }
        return nil
    }
    
    private static func makeResponse<T>(fromPreviousData previous: T, withError error: Error) -> AnyResponse<T, Error> {
        .init(
            data: previous,
            isDataFresh: false,
            refreshingState: .failed(error: error)
        )
    }
}
