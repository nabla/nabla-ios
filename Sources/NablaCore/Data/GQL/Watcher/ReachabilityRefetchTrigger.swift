import Foundation

class ReachabilityRefetchTrigger: RefetchTrigger {
    // MARK: - Initializer

    init(environment: Environment) {
        self.environment = environment
        super.init()
        observeServerReachability()
    }

    // MARK: - Private
    
    private let environment: Environment
    
    private var performedInitialCheck = false
    private lazy var reachability: Reachability? = makeReachability()
    
    private func makeReachability() -> Reachability? {
        do {
            let reachability: Reachability
            if let hostname = environment.serverUrl.host {
                reachability = try Reachability(hostname: hostname)
            } else {
                reachability = try Reachability()
            }
            return reachability
        } catch {
            return nil
        }
    }
    
    private func observeServerReachability() {
        guard let reachability = reachability else { return }
        // Refresh the cache when the host becomes reachable again
        reachability.whenReachable = { [weak self] _ in
            guard let self = self else { return }
            // When we call startNotifier, an initial check is queued immediately
            // We ignore this one, and only refresh the cache for actual network recovery situations
            if self.performedInitialCheck {
                self.trigger()
            } else {
                self.performedInitialCheck = true
            }
        }
        
        try? reachability.startNotifier()
    }
}
