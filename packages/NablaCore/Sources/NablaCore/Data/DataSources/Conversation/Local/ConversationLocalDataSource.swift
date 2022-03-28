//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation

protocol ConversationLocalDataSource {
    func watchList(_ update: ([Int]) -> Void)
    func insert(conversation: LocalConversation, completion: () -> Void)
}
