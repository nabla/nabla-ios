import Foundation

public protocol VideoCallModule: Module {
    func makeClient(container: CoreContainer) -> VideoCallClient
}

public protocol VideoCallClient {
    var views: VideoCallViewFactory { get }
    
    // Ideally we would extract VideoCall cells to NablaVideoCall package to avoid such public APIs, see #20836 for more details
    var currentVideoCallToken: String? { get }
    func watchCurrentVideoCall(callback: @escaping (_ token: String?) -> Void) -> Cancellable
    func openCurrentVideoCall()
}
