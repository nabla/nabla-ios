//
//  ConversationRemoteDataSource.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation

protocol ConversationRemoteDataSource {
    func fetchConversations(page: Int, completion: ([RestConversation]) -> Void)
}
