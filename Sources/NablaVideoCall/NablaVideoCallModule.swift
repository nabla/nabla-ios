import NablaCore

public struct NablaVideoCallModule: NablaCore.VideoCallModule {
    public func makeClient(container: CoreContainer) -> VideoCallClient {
        NablaVideoCallClient(container: container)
    }
    
    public init() {}
}
