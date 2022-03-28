//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation
import NablaUtils

class ConversationRepositoryImpl: ConversationRepository {
    func getList(_: ([Int]) -> Void) {}

    @Inject private var restDataSource: ConversationRemoteDataSource
    @Inject private var localDataSource: ConversationLocalDataSource
    @Inject private var restConversationMapper: RestConversationMapper
}
