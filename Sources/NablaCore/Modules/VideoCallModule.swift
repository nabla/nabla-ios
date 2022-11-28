import Combine
import Foundation
import UIKit

public protocol VideoCallModule: Module {
    func makeClient(container: CoreContainer) -> VideoCallClient
}

// sourcery: AutoMockable
public protocol VideoCallClient {
    var crossModuleViews: VideoCallViewFactory { get }
    
    // Ideally we would extract VideoCall cells to NablaVideoCall package to avoid such public APIs, see #20836 for more details
    var currentVideoCallToken: String? { get }
    func watchCurrentVideoCall() -> AnyPublisher<String?, Never>
    func openVideoCallRoom(url: String, token: String, from viewController: UIViewController)
}
