import Combine

public extension Publisher {
    var nabla: NablaPublisherExtension<Self> {
        NablaPublisherExtension(base: self)
    }
}

public struct NablaPublisherExtension<Base: Publisher> {
    let base: Base
}
