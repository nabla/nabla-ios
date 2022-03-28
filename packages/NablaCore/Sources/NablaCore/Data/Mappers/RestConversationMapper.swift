//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation

protocol RestConversationMapper {
    func map(_ conversation: RestConversation) -> Conversation
}
