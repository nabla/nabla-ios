import NablaCore

public extension NablaClient {
    var videoCall: NablaVideoCallClient {
        guard let client = container.videoCallClient as? NablaVideoCallClient else {
            fatalError("`NablaVideoCallClient` not initilized. You must provide a `NablaVideoCallModule` to `NablaClient.initialize()`.")
        }
        return client
    }
}
