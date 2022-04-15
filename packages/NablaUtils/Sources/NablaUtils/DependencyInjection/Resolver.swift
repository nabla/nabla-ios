import Foundation

public class Resolver {
    // MARK: - Public

    public static let shared = Resolver()

    public func register<T>(type: T.Type, factory: @escaping (Resolver) -> T) {
        factories[key(for: type)] = PermanentFactory(factory)
    }
    
    public func register<T>(type: T.Type, factory: @escaping () -> T) {
        factories[key(for: type)] = PermanentFactory { _ in factory() }
    }

    public func register<T>(type: T.Type, _ value: T) {
        factories[key(for: type)] = PermanentFactory { _ in value }
    }

    public func resolve<T>(_ type: T.Type) -> T {
        guard let factory = factories[key(for: type)] else {
            fatalError("Could not resolve any \(String(reflecting: type))")
        }
        let component = factory.get(resolver: self)
        guard let typeSafeComponent = component as? T else {
            fatalError("Tried to resolve \(String(reflecting: type)) but found \(String(reflecting: component))")
        }
        return typeSafeComponent
    }

    // MARK: - Private

    private var factories: [String: Factory] = [:]

    private func key<T>(for type: T.Type) -> String {
        String(reflecting: type.self)
    }
}

private protocol Factory {
    func get(resolver: Resolver) -> Any
}

private class PermanentFactory: Factory {
    let block: (Resolver) -> Any
    var cache: Any?
    
    init(_ block: @escaping (Resolver) -> Any) {
        self.block = block
    }
    
    func get(resolver: Resolver) -> Any {
        if let cache = cache {
            return cache
        }
        let value = block(resolver)
        cache = value
        return value
    }
}
