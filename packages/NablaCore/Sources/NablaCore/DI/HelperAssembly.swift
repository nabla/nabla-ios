//
//  File.swift
//
//
//  Created by Thibault Tourailles on 28/03/2022.
//

import Foundation
import NablaUtils

class HelperAssembly: Assembly {
    // MARK: - Assembly

    func assemble(resolver: Resolver) {
        resolver.register(type: URLCache.self) {
            URLCacheImplementation()
        }
    }
}
