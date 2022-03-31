//
//  File.swift
//
//
//  Created by Thibault Tourailles on 22/03/2022.
//

import Foundation
import NablaUtils

class InteractorAssembly: Assembly {
    // MARK: - Assembly

    func assemble(resolver: Resolver) {
        resolver.register(type: GetConversationListInteractor.self) {
            GetConversationListInteractorImpl()
        }
    }
}
