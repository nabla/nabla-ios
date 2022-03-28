//
//  File.swift
//
//
//  Created by Tanguy Helesbeux on 21/03/2022.
//

import Foundation
import NablaCore

public struct NablaViewFactory {
    public func createConversationListView(delegate _: ConversationListViewDelegate) -> ConversationListView {
        let view = ConversationListView(frame: .zero)
        let presenter = ConversationListPresenterImpl(view: view)
        view.presenter = presenter
        return view
    }
}
