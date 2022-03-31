import Foundation

public class Resolver {
    // MARK: - Public

    public static let shared = Resolver()

    public func register<T>(type: T.Type, factory: @escaping () -> T) {
        factories[key(for: type)] = factory
    }

    public func register<T>(type: T.Type, _ value: T) {
        factories[key(for: type)] = { value }
    }

    public func resolve<T>(_ type: T.Type) -> T {
        guard let factory = factories[key(for: type)] else {
            fatalError("Could not resolve any \(type)")
        }
        let component = factory()
        guard let typeSafeComponent = component as? T else {
            fatalError("Tried to resovle \(type) but found \(component)")
        }
        return typeSafeComponent
    }

    // MARK: - Private

    private var factories: [String: () -> Any] = [:]

    private func key<T>(for type: T.Type) -> String {
        String(describing: type.self)
    }
}
