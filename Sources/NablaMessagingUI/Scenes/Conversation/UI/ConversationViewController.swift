import Foundation
import NablaCore
import NablaMessagingCore

import UIKit

final class ConversationViewController: UIViewController, ConversationViewContract {
    // MARK: - Init

    init(
        showComposer: Bool,
        logger: Logger,
        providers: [ConversationCellProvider]
    ) {
        self.showComposer = showComposer
        self.logger = logger
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
        view.backgroundColor = NablaTheme.Conversation.backgroundColor
        collectionView.backgroundColor = NablaTheme.Conversation.backgroundColor
        collectionView.delegate = self
        providers.forEach { $0.prepare(collectionView: collectionView) }
        errorView.delegate = self
        presenter.start()
    }

    // MARK: - Internal

    var presenter: ConversationPresenter!

    // MARK: - ConversationViewContract

    var showRecordAudioMessageButton = true {
        didSet { composerView.showRecordAudioButton = showRecordAudioMessageButton }
    }

    func configure(withConversation conversation: ConversationViewModel) {
        titleView.title = conversation.title
        titleView.avatar = conversation.avatar
        titleView.subtitle = conversation.subtitle
    }

    func configure(withState state: ConversationViewState) {
        self.state = state
    }

    func emptyComposer() {
        composerView.emptyComposer()
    }

    func displayMediaPicker(source: ImagePickerSource) {
        let picker = imagePickerModule.makeViewController(
            source: source,
            mediaTypes: [.image, .video]
        )
        present(picker, animated: true)
    }

    func displayImageDetail(for image: ImageFile) {
        let viewController = ImageDetailViewController()
        let presenter = ImageDetailPresenterImpl(viewContract: viewController, image: image)
        viewController.presenter = presenter
        show(viewController, sender: nil)
    }

    func displayDocumentDetail(for document: DocumentFile) {
        let viewController = DocumentDetailViewController()
        let presenter = DocumentDetailPresenterImpl(viewContract: viewController, document: document)
        viewController.presenter = presenter
        show(viewController, sender: nil)
    }

    @available(iOS 14, *)
    func displayDocumentPicker() {
        let picker = DocumentPickerModule.makeViewController(delegate: self)
        present(picker, animated: true)
    }

    func showErrorAlert(viewModel: AlertViewModel) {
        present(
            UIAlertController.create(with: viewModel),
            animated: true
        )
    }

    func set(replyToMessage: ConversationViewMessageItem) {
        composerView.replyToMessage = replyToMessage
    }

    func scrollToItem(withId id: UUID) {
        guard
            case let .loaded(items) = state,
            let item = items.first(where: { $0.id == id }),
            let indexPath = dataSource.indexPath(for: DiffableConversationViewItem(value: item)) else {
            return
        }
        collectionView.scrollToItem(at: indexPath, at: [.centeredHorizontally, .centeredVertically], animated: true)
    }

    // MARK: Private

    private enum Section {
        case main
    }

    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, DiffableConversationViewItem>

    private typealias DataSource = UICollectionViewDiffableDataSource<Section, DiffableConversationViewItem>

    private let showComposer: Bool
    private let logger: Logger
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

    private lazy var collectionView: UICollectionView = makeCollectionView()
    private lazy var composerView: ComposerView = makeComposerView()
    
    // TODO: @tgy - Don't retain modules
    private lazy var imagePickerModule = ImagePickerModule(delegate: self)
    
    private func makeTitleView() -> TitleView {
        TitleView(frame: .zero)
    }
    
    private func makeComposerView() -> ComposerView {
        let composerView = ComposerView(dependencies: .init(logger: logger)).prepareForAutoLayout()
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
        logger.warning(message: "No plugin provided a cell for item", extra: ["type": type(of: item)])
        return nil
    }
    
    // The view controller has 3 possible layouts
    //
    // - Error -> errorView
    // - Loading -> loadingView
    // - Loaded -> collectionView + composerView
    private func updateLayoutAfterStateChange(oldValue: ConversationViewState) {
        switch (state, oldValue) {
        case let (.loaded(items), .loaded(previousItems)):
            applySnapshot(items: items, animatingDifferences: !previousItems.isEmpty)
        case (.loading, _):
            switchToLoadingLayout()
            loadingView.startAnimating()
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
        if showComposer {
            view.addSubview(composerView)
            composerView.pinToSuperView(edges: .horizontal)
        }
        view.addSubview(loadedView)
        loadedView.addSubview(containedView)
        loadedView.pinToSuperView(edges: .horizontal)
        containedView.pinToSuperView()

        loadedView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        if showComposer {
            loadedView.bottomAnchor.constraint(equalTo: composerView.topAnchor).isActive = true
            composerView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor).isActive = true
        } else {
            loadedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        }
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
                logger.error(message: "Found duplicated item", extra: ["id": item.id])
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
        alert.addAction(
            UIAlertAction(title: L10n.conversationAddMediaLibrary, style: .default, handler: { [weak self] _ in
                self?.presenter?.didTapPhotoLibraryButton()
            })
        )
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
    
    func didTap(document: DocumentFile) {
        presenter?.didTap(document: document)
    }

    func didTap(image: ImageFile) {
        presenter?.didTap(image: image)
    }

    func didTapTextItem(withId id: UUID) {
        presenter?.didTapTextItem(withId: id)
    }

    func didReplyToItem(withId id: UUID) {
        presenter?.didReplyToMessage(withId: id)
    }

    func didTapMessagePreview(withId id: UUID) {
        presenter?.didTapMessagePreview(withId: id)
    }
}

extension ConversationViewController: ComposerViewDelegate {
    // MARK: - ComposerViewDelegate
    
    func composerViewDidTapOnSend(_ composerView: ComposerView) {
        guard let text = composerView.text else { return }
        presenter.didTapOnSend(text: text, medias: composerView.medias, replyingToMessageUUID: composerView.replyToMessage?.id)
    }
    
    func composerViewDidUpdateTextDraft(_ composerView: ComposerView) {
        presenter.didUpdateDraftText(composerView.text ?? "")
    }
    
    func composerViewDidTapOnAddMedia(_: ComposerView) {
        displayMediaSelectionSheet()
    }

    func composerView(_: ComposerView, didFinishRecordingAudioFile file: AudioFile) {
        presenter.didFinishRecordingAudioFile(file, replyingToMessageUUID: composerView.replyToMessage?.id)
    }
}

extension ConversationViewController: ImagePickerDelegate {
    // MARK: - ImagePickerDelegate
    
    func imagePickerDidCancel(_ pickerViewController: UIViewController) {
        pickerViewController.dismiss(animated: true)
    }
    
    func imagePicker(_ pickerViewController: UIViewController, didSelect medias: [Media], errors _: [ImagePickerError]) {
        composerView.add(medias)
        pickerViewController.dismiss(animated: true)
    }
}

extension ConversationViewController: DocumentPickerDelegate {
    // MARK: - DocumentPickerDelegate
    
    func documentPickerDidCancel(_ pickerViewController: UIViewController) {
        pickerViewController.dismiss(animated: true)
    }
    
    func documentPicker(_ pickerViewController: UIViewController, didSelect media: Media) {
        composerView.add([media])
        pickerViewController.dismiss(animated: true)
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

extension ConversationViewController: ErrorViewDelegate {
    func errorViewDidTapButton(_: ErrorView) {
        presenter.retry()
    }
}
