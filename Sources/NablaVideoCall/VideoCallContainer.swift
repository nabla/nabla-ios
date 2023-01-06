import Foundation
import NablaCore

final class VideoCallContainer {
    // MARK: - Internal
    
    let logger: Logger
    let errorReporter: ErrorReporter
    let networkConfiguration: NetworkConfiguration
    let currentVideoCallInteractor: CurrentVideoCallInteractor
    
    // MARK: Initializer
    
    init(
        coreContainer: CoreContainer,
        networkConfiguration: NetworkConfiguration
    ) {
        self.coreContainer = coreContainer
        self.networkConfiguration = networkConfiguration
        
        logger = coreContainer.logger
        errorReporter = coreContainer.errorReporter
        currentVideoCallInteractor = CurrentVideoCallInteractor()
    }
    
    // MARK: - Private
    
    private let coreContainer: CoreContainer
}
