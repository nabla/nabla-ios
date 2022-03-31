//
//  File.swift
//
//
//  Created by Thibault Tourailles on 22/03/2022.
//

import Foundation

protocol ConversationListViewContract: AnyObject {
    func configure(with viewModel: ConversationListViewModel)
}
