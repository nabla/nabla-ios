import NablaCore

public extension NablaClient {
    var scheduling: NablaSchedulingClient {
        guard let client = container.schedulingClient as? NablaSchedulingClient else {
            fatalError("`NablaSchedulingClient` not initilized. You must provide a `NablaSchedulingModule` to `NablaClient.initialize()`.")
        }
        return client
    }
}
