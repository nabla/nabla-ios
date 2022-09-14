import NablaCore

public struct NablaSchedulingModule: NablaCore.SchedulingModule {
    public func makeClient(container: CoreContainer) -> SchedulingClient {
        NablaSchedulingClient(container: container)
    }
    
    public init() {}
}
