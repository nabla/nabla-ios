import NablaMessagingCore
import UIKit

class MediaComposerView: UIView, MediaComposerViewContract {
    var presenter: MediaComposerPresenter?
    
    // MARK: Lifecycle
    
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
        collectionView.pinToSuperView()
    }
    
    private func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: 40, height: 40)
        flowLayout.sectionInset = .init(horizontal: 16.0, vertical: 8.0)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 16.0
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.dataSource = self
        view.delegate = self
        view.bounces = true
        view.backgroundColor = .white
        
        view.register(MediaComposerCollectionViewCell.self)
        return view
    }
}

extension MediaComposerView: UICollectionViewDataSource {
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofClass: MediaComposerCollectionViewCell.self, for: indexPath)
        cell.configure(with: viewModels[indexPath.item])
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
