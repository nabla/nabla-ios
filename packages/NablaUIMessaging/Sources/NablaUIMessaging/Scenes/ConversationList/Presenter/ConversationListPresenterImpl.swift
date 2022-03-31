//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation
import NablaCore
import NablaUtils

class ConversationListPresenterImpl: ConversationListPresenter {
    // MARK: - Public

    init(viewContract: ConversationListViewContract,
         client: NablaClient) {
        self.viewContract = viewContract
        self.client = client
    }

    // MARK: - ConversationListPresenter

    func start() {
        viewContract?.configure(with: ConversationListViewModelMapper().stubs())
    }

    private let client: NablaClient
    private weak var viewContract: ConversationListViewContract?
}
