import NablaCore

public extension NablaSchedulingClient {
    var crossModuleViews: SchedulingViewFactory {
        NablaSchedulingViewFactoryImpl(client: self)
    }
    
    var views: NablaSchedulingViewFactory {
        NablaSchedulingViewFactoryImpl(client: self)
    }
}
