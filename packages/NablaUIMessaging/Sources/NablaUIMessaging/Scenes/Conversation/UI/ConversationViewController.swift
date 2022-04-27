import Foundation
import NablaCore
import NablaUtils
import UIKit

final class ConversationViewController: UIViewController, ConversationViewContract {
    // MARK: - Init

    init(providers: [ConversationCellProvider]) {
        self.providers = providers
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = NablaTheme.ConversationViewController.backgroundColor
        collectionView.backgroundColor = NablaTheme.ConversationViewController.backgroundColor
        collectionView.delegate = self
        providers.forEach { $0.prepare(collectionView: collectionView) }
        presenter.start()
    }

    // MARK: - Internal

    var presenter: ConversationPresenter!

    // MARK: - ConversationViewContract

    func configure(withState state: ConversationViewState) {
        self.state = state
    }

    func emptyComposer() {
        composerView.text = nil
    }

    // MARK: Private

    private enum Section {
        case main
    }

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DiffableConversationViewItem>
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DiffableConversationViewItem>

    @Inject private var logger: Logger
    private let providers: [ConversationCellProvider]
    private var state: ConversationViewState = .loading {
        didSet {
            updateLayoutAfterStateChange(oldValue: oldValue)
        }
    }

    private lazy var dataSource = makeDataSource()

    private let loadingView: LoadingView = .init().prepareForAutoLayout()

    private let errorView: ErrorView = .init().prepareForAutoLayout()

    private let loadedView: UIView = .init().prepareForAutoLayout()
    private let emptyView: EmptyView = .init().prepareForAutoLayout()

    private lazy var collectionView: UICollectionView = makeCollectionView()
    private lazy var composerView: ComposerView = makeComposerView()

    private func makeComposerView() -> ComposerView {
        let composerView = ComposerView().prepareForAutoLayout()
        composerView.placeHolder = L10n.conversationComposerPlaceholder
        composerView.delegate = self
        return composerView
    }

    private func makeCollectionView() -> UICollectionView {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group: NSCollectionLayoutGroup = .vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return BottomCollectionView(frame: .zero, collectionViewLayout: layout).prepareForAutoLayout()
    }

    private func makeDataSource() -> DataSource {
        DataSource(collectionView: collectionView) { [unowned self] collectionView, indexPath, item in
            self.provideCell(collectionView: collectionView, indexPath: indexPath, item: item.value)
        }
    }

    private func provideCell(
        collectionView _: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem
    ) -> UICollectionViewCell? {
        for provider in providers { // TODO: @ams Switch to [type:plugin] dictionary
            if let cell = provider.provideCell(
                collectionView: collectionView,
                indexPath: indexPath,
                item: item,
                delegate: self
            ) {
                return cell
            }
        }
        logger.warning(message: "no plugin provided the cell for \(type(of: item))")
        return nil
    }

    // The view controller has 3 possible layouts
    //
    // - Error -> errorView
    // - Loading -> loadingView
    // - Loaded -> [emptyView | collectionView] + composerView
    private func updateLayoutAfterStateChange(oldValue: ConversationViewState) {
        switch (state, oldValue) {
        case (.empty, .loaded):
            switchLoadedLayout(from: collectionView, to: emptyView)
        case let (.loaded(items), .loaded):
            applySnapshot(items: items)
        case let (.loaded(items), .empty):
            switchLoadedLayout(from: emptyView, to: collectionView)
            applySnapshot(items: items)
        case (.loading, _):
            switchToLoadingLayout()
            loadingView.startAnimating()
        case (.empty, _):
            switchToLoadedLayout(with: emptyView)
        case let (.error(viewModel), _):
            switchToErrorLayout(viewModel: viewModel)
        case let (.loaded(items), _):
            switchToLoadedLayout(with: collectionView)
            applySnapshot(items: items)
        }
    }

    private func switchToLoadingLayout() {
        view.removeSubviews()
        view.addSubview(loadingView)
        loadingView.pinToSuperView()
    }

    private func switchToErrorLayout(viewModel: ErrorViewModel) {
        view.removeSubviews()
        view.addSubview(errorView)
        errorView.pinToSuperView()
        errorView.configure(with: viewModel)
    }

    private func switchToLoadedLayout(with containedView: UIView) {
        view.removeSubviews()
        view.addSubview(composerView)
        view.addSubview(loadedView)
        loadedView.addSubview(containedView)
        composerView.pinToSuperView(edges: .horizontal)
        loadedView.pinToSuperView(edges: .horizontal)
        containedView.pinToSuperView()

        NSLayoutConstraint.activate([
            loadedView.topAnchor.constraint(equalTo: view.topAnchor),
            loadedView.bottomAnchor.constraint(equalTo: composerView.topAnchor),
            composerView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor), // TODO: (@ams) check iOS 13
        ])
    }

    private func switchLoadedLayout(from fromView: UIView, to toView: UIView) {
        fromView.removeFromSuperview()
        loadedView.addSubview(toView)
        toView.pinToSuperView()
    }

    private func applySnapshot(items: [ConversationViewItem], animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items.map(DiffableConversationViewItem.init(value:)))
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func reconfigure(item: DiffableConversationViewItem) {
        var snapshot = dataSource.snapshot()
        if #available(iOS 15.0, *) {
            snapshot.reconfigureItems([item])
        } else {
            snapshot.reloadItems([item])
        }
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ConversationViewController: ConversationCellPresenterDelegate {
    func didUpdateState(forItemWithId id: UUID) {
        dataSource.snapshot()
            .itemIdentifiers
            .first { $0.value.id == id }
            .map(reconfigure)
    }

    func didDeleteItem(withId messageId: UUID) {
        presenter.didTapDeleteMessageButton(withId: messageId)
    }
}

extension ConversationViewController: ComposerViewDelegate {
    func composerViewDidTapOnSend(_ composerView: ComposerView) {
        guard let text = composerView.text else { return }
        presenter.didTapOnSend(text: text)
    }

    func composerViewDidUpdateTextDraft(_ composerView: ComposerView) {
        presenter.didUpdateDraftText(composerView.text ?? "")
    }

    func composerViewDidTapOnAddMedia(_: ComposerView) {}
}

struct DiffableConversationViewItem: Hashable {
    let value: ConversationViewItem
    
    func hash(into hasher: inout Hasher) {
        value.hash(into: &hasher)
    }
    
    static func == (lhs: DiffableConversationViewItem, rhs: DiffableConversationViewItem) -> Bool {
        lhs.value.hashValue == rhs.value.hashValue
    }
}

extension ConversationViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point _: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let conversationContextCell = collectionView.cellForItem(at: indexPath) as? ConversationContextCell,
              let menuConfiguration = conversationContextCell.makeContextMenuConfiguration(for: indexPath) else {
            return nil
        }

        return menuConfiguration.makeUIConfiguration()
    }

    func collectionView(
        _ collectionView: UICollectionView,
        previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        guard let indexPath = configuration.indexPath,
              let cell = collectionView.cellForItem(at: indexPath) as? ConversationContextCell else {
            return nil
        }
        return cell.previewForHighlightingContextMenu()
    }

    public func collectionView(
        _ collectionView: UICollectionView,
        previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        guard let indexPath = configuration.indexPath,
              let cell = collectionView.cellForItem(at: indexPath) as? ConversationContextCell else {
            return nil
        }
        return cell.previewForHighlightingContextMenu()
    }
}
