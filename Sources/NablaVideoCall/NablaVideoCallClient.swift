import Foundation
import NablaCore

public final class NablaVideoCallClient: VideoCallClient {
    // MARK: - Public
    
    public var currentVideoCallToken: String? {
        container.currentVideoCallInteractor.currentVideoCallToken
    }
    
    public func watchCurrentVideoCall(callback: @escaping (_ token: String?) -> Void) -> Cancellable {
        container.currentVideoCallInteractor.watchCurrentVideoCall(callback: callback)
    }
    
    public func openCurrentVideoCall() {
        container.currentVideoCallInteractor.openCurrentVideoCall()
    }
    
    // MARK: Initializer
    
    public init(
        container: CoreContainer,
        networkConfiguration: NetworkConfiguration? = nil
    ) {
        self.container = VideoCallContainer(
            coreContainer: container,
            networkConfiguration: networkConfiguration ?? DefaultNetworkConfiguration()
        )
        checkPermissions()
    }
    
    // MARK: - Internal
    
    let container: VideoCallContainer
        
    // MARK: - Private
    
    private func checkPermissions() {
        if Bundle.main.nabla.hasMicrophoneUsageDescription {
            container.logger.error(message: "Missing `NSMicrophoneUsageDescription` key in Info.plist")
        }
        if Bundle.main.nabla.hasCameraUsageDescription {
            container.logger.error(message: "Missing `NSCameraUsageDescription` key in Info.plist")
        }
    }
}
