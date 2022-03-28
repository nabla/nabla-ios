//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation
import NablaUtils

public class NablaClient {
    // MARK: - Public

    public static var shared: NablaClient = initialize()

    public var apiKey: String?

    public func getConversations(block _: ([Int]) -> Void) {
        getConversationListInteractor.execute(conversationUuid: .init())
    }

    public func getMessages(conversationUUID _: UUID, block _: () -> [Int]) {}

    // MARK: - Private

    @Inject private var getConversationListInteractor: GetConversationListInteractor

    private static func initialize() -> NablaClient {
        let assembler = Assembler(assemblies: [
            RepositoryAssembly(),
        ])
        assembler.assemble()
        return NablaClient()
    }
}
