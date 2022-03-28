//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation

protocol ConversationRepository {
    func getList(_ completion: ([Int]) -> Void)
}
