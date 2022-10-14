import NablaCore
import NablaMessagingCore
import UIKit

class MediaComposerView: UIView, MediaComposerViewContract {
    struct Dependencies {
        let logger: Logger
    }

    let logger: Logger
    var presenter: MediaComposerPresenter?
    
    // MARK: Lifecycle

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(dependencies: Dependencies) {
        logger = dependencies.logger
        super.init(frame: .zero)
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }

    // MARK: - MediaComposerViewContract

    func configure(with viewModels: [MediaComposerItemViewModel]) {
        self.viewModels = viewModels
        collectionView.reloadData()
    }

    func emptyMedias() {
        presenter?.emptyMedias()
    }

    func add(_ medias: [Media]) {
        presenter?.add(medias)
    }
    
    // MARK: - Private

    private var viewModels: [MediaComposerItemViewModel] = []

    private lazy var collectionView: UICollectionView = self.makeCollectionView()
    
    private func setUp() {
        guard subviews.isEmpty else { return }
        addSubview(collectionView)
        collectionView.nabla.pinToSuperView()
    }
    
    private func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: 40, height: 40)
        flowLayout.sectionInset = .nabla.make(horizontal: 16.0, vertical: 8.0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 16.0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.dataSource = self
        view.delegate = self
        view.bounces = true
        view.backgroundColor = .clear
        
        view.nabla.register(MediaComposerCollectionViewCell.self)
        return view
    }
}

extension MediaComposerView: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.nabla.dequeueReusableCell(ofClass: MediaComposerCollectionViewCell.self, for: indexPath)
        let viewModel = viewModels[indexPath.item]
        do {
            try cell.configure(with: viewModel)
        } catch {
            logger.error(
                message: "Could not configure the media in the composer (indexPath: \(indexPath.item), type: \(viewModel.type)",
                extra: ["reason": InternalError(underlyingError: error)]
            )
        }
        cell.delegate = self
        return cell
    }
}

extension MediaComposerView: UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate
}

extension MediaComposerView: MediaComposerCollectionViewCellDelegate {
    // MARK: - MediaComposerCollectionViewCellDelegate

    func mediaComposerCollectionViewCellDidTapDeleteButton(_ cell: MediaComposerCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        presenter?.didTapDeleteButtonForMedia(at: indexPath.item)
    }
}
