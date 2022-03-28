//
//  File.swift
//
//
//  Created by Thibault Tourailles on 22/03/2022.
//

import Foundation

public class Assembler {
    // MARK: - Initializer

    public init(assemblies: [Assembly]) {
        self.assemblies = assemblies
    }

    public func assemble(resolver: Resolver = .shared) {
        assemblies.forEach { $0.assemble(resolver: resolver) }
    }

    // MARK: - Private

    private let assemblies: [Assembly]
}
