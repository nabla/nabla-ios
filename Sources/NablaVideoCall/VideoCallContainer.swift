import Foundation
import NablaCore

final class VideoCallContainer {
    // MARK: - Internal
    
    var logger: Logger { coreContainer.logger }
    
    let networkConfiguration: NetworkConfiguration
    
    let currentVideoCallInteractor = CurrentVideoCallInteractor()
    
    // MARK: Initializer
    
    init(
        coreContainer: CoreContainer,
        networkConfiguration: NetworkConfiguration
    ) {
        self.coreContainer = coreContainer
        self.networkConfiguration = networkConfiguration
    }
    
    // MARK: - Private
    
    private let coreContainer: CoreContainer
}
