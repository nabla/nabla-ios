import Combine
import Foundation
import NablaCore
import UIKit

public final class NablaVideoCallClient: VideoCallClient {
    // MARK: - Public
    
    public var currentVideoCallToken: String? {
        container.currentVideoCallInteractor.currentVideoCallToken
    }
    
    public func watchCurrentVideoCall() -> AnyPublisher<String?, Never> {
        container.currentVideoCallInteractor.watchCurrentVideoCall()
    }
    
    public func openVideoCallRoom(url: String, token: String, from viewController: UIViewController, completion: (() -> Void)?) {
        if currentVideoCallToken == token {
            container.currentVideoCallInteractor.openCurrentVideoCall()
        } else if currentVideoCallToken == nil {
            let modal = NablaVideoCallViewFactoryImpl(client: self).createVideoCallRoomViewController(url: url, token: token)
            viewController.present(modal, animated: true, completion: completion)
        } else {
            container.logger.warning(message: "Can not join a video call while another is in progress.")
        }
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
        if !Bundle.main.nabla.hasMicrophoneUsageDescription {
            container.logger.error(message: "Missing `NSMicrophoneUsageDescription` key in Info.plist")
        }
        if !Bundle.main.nabla.hasCameraUsageDescription {
            container.logger.error(message: "Missing `NSCameraUsageDescription` key in Info.plist")
        }
    }
}
