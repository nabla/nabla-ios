import Foundation
import UIKit

final class ConversationViewController: UIViewController, ConversationViewContract {
    // MARK: - Init

    init() {
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

        presenter.start()
    }

    // MARK: Internal

    var presenter: ConversationPresenter!

    func configure(withState state: ConversationViewState) {
        self.state = state
    }

    // MARK: Private

    private var state: ConversationViewState = .loading {
        didSet {
            updateLayoutAfterStateChange(oldValue: oldValue)
        }
    }

    private let loadingView: LoadingView = .init().prepareForAutoLayout()

    private let errorView: ErrorView = .init().prepareForAutoLayout()

    private let loadedView: UIView = .init().prepareForAutoLayout()
    private let emptyView: EmptyView = .init().prepareForAutoLayout()

    private lazy var collectionView: UICollectionView = createCollectionView()
    private let composerView: ComposerView = .init().prepareForAutoLayout()
    private let keyboardPlaceHolderView: KeyboardPlaceholderView = .init().prepareForAutoLayout()
    
    private func createCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView.prepareForAutoLayout()
    }

    // The view controller has 3 possible layouts
    //
    // - Error -> errorView
    // - Loading -> loadingView
    // - Loaded -> [emptyView | collectionView] + composerView + keyboardView
    private func updateLayoutAfterStateChange(oldValue: ConversationViewState?) {
        switch (state, oldValue) {
        case (.loading, _):
            view.removeSubviews()
            view.addSubview(loadingView)
            loadingView.pinToSuperView()
            loadingView.startAnimating()
        case (.error, _):
            view.removeSubviews()
            view.addSubview(errorView)
            errorView.pinToSuperView()
        case (.loaded, .empty):
            emptyView.removeFromSuperview()
            loadedView.addSubview(collectionView)
            collectionView.pinToSuperView()
        case (.empty, .loaded):
            collectionView.removeFromSuperview()
            loadedView.addSubview(emptyView)
            emptyView.pinToSuperView()
        case (.empty, _):
            setupLoaded(with: emptyView)
        case (.loaded, _):
            setupLoaded(with: collectionView)
        }
    }

    private func setupLoaded(with containedView: UIView) {
        view.removeSubviews()
        view.addSubview(keyboardPlaceHolderView)
        view.addSubview(composerView)
        view.addSubview(loadedView)
        loadedView.addSubview(containedView)
        keyboardPlaceHolderView.pinToSuperView(edges: .horizontal)
        composerView.pinToSuperView(edges: .horizontal)
        loadedView.pinToSuperView(edges: .horizontal)
        containedView.pinToSuperView()

        NSLayoutConstraint.activate([
            loadedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loadedView.bottomAnchor.constraint(equalTo: composerView.topAnchor),
            composerView.bottomAnchor.constraint(equalTo: keyboardPlaceHolderView.topAnchor),
            keyboardPlaceHolderView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}
