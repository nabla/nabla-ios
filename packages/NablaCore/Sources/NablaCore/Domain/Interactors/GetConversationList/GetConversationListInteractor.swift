//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation

public protocol GetConversationListInteractor {
    func execute(conversationUuid: UUID)
}
