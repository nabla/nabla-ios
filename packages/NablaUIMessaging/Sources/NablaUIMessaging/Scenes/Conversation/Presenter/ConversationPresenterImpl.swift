import Foundation

final class ConversationPresenterImpl: ConversationPresenter {
    private var items = [ConversationViewItem]()

    // MARK: Init

    init(view: ConversationViewContract) {
        self.view = view
    }

    // MARK: - Internal

    func start() {
//        view?.configure(withState: .loading)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.view?.configure(withState: .error)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
//            self.view?.configure(withState: .loading)
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.view?.configure(withState: .empty)
//        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.items.append(
                ConversationViewItem(
                    content: DateSeparatorItemContent(
                        text: "Date separator: \(Date().description)")
                )
            )
            self.view?.configure(withState: .loaded(items: self.items))
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.items.append(
                ConversationViewItem(
                    content: EventItemContent(
                        text: "Event item: somebody joined?")
                )
            )
            self.view?.configure(withState: .loaded(items: self.items))
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.items.append(
                ConversationViewItem(
                    content: TextMessageItemContent(
                        text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam.")
                )
            )
            self.view?.configure(withState: .loaded(items: self.items))
        }
    }

    // MARK: - Private

    private weak var view: ConversationViewContract?
}
