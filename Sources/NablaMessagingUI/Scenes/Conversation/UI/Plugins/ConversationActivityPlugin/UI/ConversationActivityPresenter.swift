import Foundation
import NablaMessagingCore
#if canImport(NablaUtils)
    import NablaUtils
#endif

final class ConversationActivityPresenter: Presenter {
    var item: ConversationActivityViewItem
    
    // MARK: - Init
    
    init(delegate _: ConversationCellPresenterDelegate, item: ConversationActivityViewItem) {
        self.item = item
    }
    
    // MARK: - Presenter
    
    func start() {
        updateView()
    }
    
    // MARK: - Internal
    
    func attachView(_ view: ConversationActivityCell) {
        self.view = view
    }
    
    // MARK: - Private
    
    private weak var view: ConversationActivityCell?
    
    private func updateView() {
        view?.configure(with: .init(text: Self.transform(item: item)))
    }

    private static func transform(item: ConversationActivityViewItem) -> String {
        switch item.activity {
        case let .providerJoined(provider):
            return L10n.conversationProviderJoined(provider.fullNameWithPrefix)
        }
    }
}
