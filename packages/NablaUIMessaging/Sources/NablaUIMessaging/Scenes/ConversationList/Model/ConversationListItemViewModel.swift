//
//  File.swift
//
//
//  Created by Thibault Tourailles on 22/03/2022.
//

import Foundation

struct ConversationListItemViewModel {
    let avatar: AvatarViewModel
    let title: String
    let lastMessage: String
    let lastUpdatedTime: String
    let isUnread: Bool
}
