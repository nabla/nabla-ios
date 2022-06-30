import Apollo
import Foundation

public class GQLWatcher<Query: GQLQuery>: Watcher {
    // MARK: - Public
    
    public func cancel() {
        apollo.cancel()
    }
    
    public func refetch() {
        apollo.refetch()
    }
    
    // MARK: - Internal
    
    init(_ apollo: GraphQLQueryWatcher<Query>) {
        self.apollo = apollo
    }
    
    // MARK: - Private
    
    private let apollo: GraphQLQueryWatcher<Query>
    
    private func observeRefetchNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refetchNotificationHandler),
            name: RefetchTrigger.refetchWatchersNotifiationName,
            object: nil
        )
    }
    
    @objc private func refetchNotificationHandler() {
        refetch()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
