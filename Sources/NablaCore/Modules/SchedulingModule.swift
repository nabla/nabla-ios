import Foundation

public protocol SchedulingModule: Module {
    func makeClient(container: CoreContainer) -> SchedulingClient
}

public protocol SchedulingClient {
    var crossModuleViews: SchedulingViewFactory { get }
}
