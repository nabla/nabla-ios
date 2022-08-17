import NablaCore

public extension NablaVideoCallClient {
    var views: VideoCallViewFactory {
        NablaVideoCallViewFactory(client: self)
    }
}
