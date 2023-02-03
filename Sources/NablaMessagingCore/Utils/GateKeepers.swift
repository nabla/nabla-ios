import Foundation
import NablaCore

// sourcery: AutoMockable
protocol GateKeepers {
    var supportVideoCallActionRequests: Bool { get }
}

class GateKeepersImpl: GateKeepers {
    // MARK: - Internal
    
    var supportVideoCallActionRequests: Bool {
        coreContainer.videoCallClient != nil
    }
    
    // MARK: Init
    
    init(
        coreContainer: CoreContainer
    ) {
        self.coreContainer = coreContainer
    }

    // MARK: - Private
    
    private let coreContainer: CoreContainer
}
