import Foundation
import NablaMessagingCore
import NablaUtils
import UIKit

final class ConversationViewController: UIViewController, ConversationViewContract {
    // MARK: - Init
    
    init(providers: [ConversationCellProvider]) {
        self.providers = providers
        super.init(nibName: nil, bundle: nil)
        navigationItem.titleView = titleView
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
    
    func configure(withConversation conversation: ConversationViewModel) {
        titleView.title = conversation.title
        titleView.avatar = conversation.avatar
    }
    
    func configure(withState state: ConversationViewState) {
        self.state = state
    }
    
    func emptyComposer() {
        composerView.text = nil
        composerView.medias = []
    }
    
    func displayMediaPicker(source: ImagePickerSource) {
        let picker = imagePickerModule.makeViewController(
            source: source,
            mediaTypes: [.image]
        )
        navigationController?.present(picker, animated: true)
    }
    
    func displayImageDetail(for media: Media) {
        let viewController = ImageDetailViewController()
        let presenter = ImageDetailPresenterImpl(viewContract: viewController, media: media)
        viewController.presenter = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func displayDocumentDetail(for media: Media) {
        let viewController = DocumentDetailViewController()
        let presenter = DocumentDetailPresenterImpl(viewContract: viewController, document: media)
        viewController.presenter = presenter
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @available(iOS 14, *)
    func displayDocumentPicker() {
        let picker = DocumentPickerModule.makeViewController(delegate: self)
        navigationController?.present(picker, animated: true)
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
    
    private lazy var titleView: TitleView = makeTitleView()
    
    private let loadingView: LoadingView = .init().prepareForAutoLayout()
    
    private let errorView: ErrorView = .init().prepareForAutoLayout()
    
    private let loadedView: UIView = .init().prepareForAutoLayout()
    private let emptyView: EmptyView = .init().prepareForAutoLayout()
    
    private lazy var collectionView: UICollectionView = makeCollectionView()
    private lazy var composerView: ComposerView = makeComposerView()
    
    // TODO: @tgy - Don't retain modules
    private lazy var imagePickerModule = ImagePickerModule(delegate: self)
    
    private func makeTitleView() -> TitleView {
        TitleView(frame: .zero)
    }
    
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
        let layout = FlippedCollectionViewCompositionalLayout(section: section)
        let collectionView = FlippedCollectionView(frame: .zero, collectionViewLayout: layout).prepareForAutoLayout()
        collectionView.keyboardDismissMode = .interactive
        collectionView.delegate = self
        return collectionView
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
        var seen = Set<UUID>()
        let items = items.reversed().compactMap { item -> DiffableConversationViewItem? in
            guard !seen.contains(item.id) else {
                logger.warning(message: "Found duplicate item with identifier \(item.id)")
                return nil
            }
            seen.insert(item.id)
            return DiffableConversationViewItem(value: item)
        }
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(items)
        
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
    
    private func displayMediaSelectionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(
            UIAlertAction(title: L10n.conversationAddMediaCamera, style: .default, handler: { [weak self] _ in
                self?.presenter?.didTapCameraButton()
            })
        )
        if #available(iOS 14, *) {
            alert.addAction(
                UIAlertAction(title: L10n.conversationAddMediaLibrary, style: .default, handler: { [weak self] _ in
                    self?.presenter?.didTapPhotoLibraryButton()
                })
            )
        }
        if #available(iOS 14, *) {
            alert.addAction(
                UIAlertAction(title: L10n.conversationAddMediaDocument, style: .default, handler: { [weak self] _ in
                    self?.presenter?.didTapDocumentLibraryButton()
                })
            )
        }
        alert.addAction(UIAlertAction(title: L10n.conversationAddMediaCancel, style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
}

extension ConversationViewController: ConversationCellPresenterDelegate {
    // MARK: - ConversationCellPresenterDelegate
    
    func didUpdateState(forItemWithId id: UUID) {
        dataSource.snapshot()
            .itemIdentifiers
            .first { $0.value.id == id }
            .map(reconfigure)
    }
    
    func didDeleteItem(withId messageId: UUID) {
        presenter.didTapDeleteMessageButton(withId: messageId)
    }
    
    func didTapMedia(_ media: Media) {
        presenter?.didTapMedia(media)
    }
}

extension ConversationViewController: ComposerViewDelegate {
    // MARK: - ComposerViewDelegate
    
    func composerViewDidTapOnSend(_ composerView: ComposerView) {
        guard let text = composerView.text else { return }
        presenter.didTapOnSend(text: text, medias: composerView.medias)
    }
    
    func composerViewDidUpdateTextDraft(_ composerView: ComposerView) {
        presenter.didUpdateDraftText(composerView.text ?? "")
    }
    
    func composerViewDidTapOnAddMedia(_: ComposerView) {
        displayMediaSelectionSheet()
    }
}

extension ConversationViewController: ImagePickerDelegate {
    // MARK: - ImagePickerDelegate
    
    func imagePickerDidCancel(_: UIViewController) {
        navigationController?.dismiss(animated: true)
    }
    
    func imagePicker(_: UIViewController, didSelect medias: [Media], errors _: [ImagePickerError]) {
        composerView.medias.append(contentsOf: medias)
        navigationController?.dismiss(animated: true)
    }
}

extension ConversationViewController: DocumentPickerDelegate {
    // MARK: - DocumentPickerDelegate
    
    func documentPickerDidCancel(_: UIViewController) {
        navigationController?.dismiss(animated: true)
    }
    
    func documentPicker(_: UIViewController, didSelect media: Media) {
        composerView.medias.append(media)
        navigationController?.dismiss(animated: true)
    }
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
    func collectionView(_ collectionView: UICollectionView, willDisplay _: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastIndexPath = collectionView.lastIndexPath
        let isAlmostEndOfCollectionView = lastIndexPath.section == indexPath.section && lastIndexPath.item - indexPath.item < 5
        if isAlmostEndOfCollectionView {
            presenter.didReachEndOfConversation()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemAt indexPath: IndexPath,
        point _: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let conversationContextCell = collectionView.cellForItem(at: indexPath) as? ConversationContextCell,
              let menuConfiguration = conversationContextCell.makeContextMenuConfiguration(for: indexPath)
        else {
            return nil
        }
        
        return menuConfiguration.makeUIConfiguration()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        guard let indexPath = configuration.indexPath,
              let cell = collectionView.cellForItem(at: indexPath) as? ConversationContextCell
        else {
            return nil
        }
        return cell.previewForHighlightingContextMenu()
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration
    ) -> UITargetedPreview? {
        guard let indexPath = configuration.indexPath,
              let cell = collectionView.cellForItem(at: indexPath) as? ConversationContextCell
        else {
            return nil
        }
        return cell.previewForHighlightingContextMenu()
    }
}

private extension UICollectionView {
    var lastIndexPath: IndexPath {
        let section = numberOfSections - 1
        let item = numberOfItems(inSection: section) - 1
        return IndexPath(item: item, section: section)
    }
}
