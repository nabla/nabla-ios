import Apollo
import Foundation

public extension Optional {
    var nabla: NablaOptionalExtension<Wrapped> {
        NablaOptionalExtension(base: self)
    }
}

public struct NablaOptionalExtension<Wrapped> {
    let base: Wrapped?
}

public extension NablaOptionalExtension {
    func asGQLNullable(default: GraphQLNullable<Wrapped> = .none) -> GraphQLNullable<Wrapped> {
        base.map(GraphQLNullable.some) ?? `default`
    }
}
