import Foundation
import UIKit

final class ConversationViewController: UIViewController, ConversationViewContract {
    enum Section {
        case main
    }

    typealias DataSource = UICollectionViewDiffableDataSource<Section, ConversationViewItem>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, ConversationViewItem>

    // MARK: - Init

    init(providers: [ConversationCellProvider]) {
        self.providers = providers
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        providers.forEach { $0.prepare(collectionView: collectionView) }
        presenter.start()
    }

    // MARK: Internal

    var presenter: ConversationPresenter!

    func configure(withState state: ConversationViewState) {
        self.state = state
    }

    // MARK: Private

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

    private lazy var collectionView: UICollectionView = createCollectionView()
    private let composerView: ComposerView = .init().prepareForAutoLayout()

    private func createCollectionView() -> UICollectionView {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        let group: NSCollectionLayoutGroup = .vertical(layoutSize: layoutSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return BottomCollectionView(frame: .zero, collectionViewLayout: layout).prepareForAutoLayout()
    }

    private func makeDataSource() -> DataSource {
        DataSource(
            collectionView: collectionView,
            cellProvider: provideCell
        )
    }

    private func provideCell(
        collectionView _: UICollectionView,
        indexPath: IndexPath,
        item: ConversationViewItem
    ) -> UICollectionViewCell? {
        for plugin in providers { // TODO: @ams Switch to [type:plugin] dictionary
            if let cell = plugin.provideCell(
                collectionView: collectionView,
                indexPath: indexPath,
                item: item
            ) {
                return cell
            }
        }
        print("no plugin provided the cell for \(item)") // TODO: @ams Replace with logger
        return nil
    }

    // The view controller has 3 possible layouts
    //
    // - Error -> errorView
    // - Loading -> loadingView
    // - Loaded -> [emptyView | collectionView] + composerView
    private func updateLayoutAfterStateChange(oldValue: ConversationViewState) {
        switch (state, oldValue) {
        case (.loading, _):
            switchToLoadingLayout()
            loadingView.startAnimating()
        case (.error, _):
            switchToErrorLayout()
        case (.empty, _):
            switchToLoadedLayout(with: emptyView)
        case let (.loaded(items), .empty):
            switchLoadedLayout(from: emptyView, to: collectionView)
            applySnapshot(items: items)
        case let (.loaded(items), .loaded):
            applySnapshot(items: items)
        case (.empty, .loaded):
            switchLoadedLayout(from: collectionView, to: emptyView)
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

    private func switchToErrorLayout() {
        view.removeSubviews()
        view.addSubview(errorView)
        errorView.pinToSuperView()
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
            loadedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
        snapshot.appendItems(items)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences) {
            UIView.animate(withDuration: 0.3, animations: {
                self.collectionView.updateInsets()
            })
        }
    }
}
