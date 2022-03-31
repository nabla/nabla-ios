//
//  File.swift
//
//
//  Created by Thibault Tourailles on 22/03/2022.
//

import Foundation

struct ConversationListViewModel {
    let items: [ConversationListItemViewModel]
}

extension ConversationListViewModel {
    static var empty: ConversationListViewModel {
        ConversationListViewModel(items: [])
    }
}
