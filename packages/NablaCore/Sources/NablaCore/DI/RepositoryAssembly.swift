//
//  File.swift
//
//
//  Created by Thibault Tourailles on 22/03/2022.
//

import Foundation
import NablaUtils

class RepositoryAssembly: Assembly {
    func assemble(resolver: Resolver) {
        resolver.register(type: ConversationRepository.self) {
            ConversationRepositoryImpl()
        }
    }
}
