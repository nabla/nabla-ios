import Apollo
import Foundation

class GQLWatcher<Query: GraphQLQuery> {
    // MARK: Interface
    
    init(_ apollo: GraphQLQueryWatcher<Query>) {
        self.apollo = apollo
    }
    
    func cancel() {
        apollo.cancel()
    }
    
    func refetch() {
        apollo.refetch()
    }
    
    // MARK: Private
    
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
