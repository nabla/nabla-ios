//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation

@propertyWrapper
public struct Inject<Component> {
    // MARK: - Public

    public init() {
        component = Resolver.shared.resolve(Component.self)
    }

    public var wrappedValue: Component {
        get { component }
        mutating set { component = newValue }
    }

    // MARK: - Private

    private var component: Component
}
