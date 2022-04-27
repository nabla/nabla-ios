import NablaCore
import UIKit

protocol MediaComposerViewDelegate: AnyObject {
    func mediaComposerView(_ view: MediaComposerView, didTapDeleteButtonOn media: Media)
    func mediaComposerView(_ view: MediaComposerView, didUpdateMedias medias: [Media])
}

class MediaComposerView: UIView {
    weak var delegate: MediaComposerViewDelegate?
    
    private lazy var collectionView: UICollectionView = self.makeCollectionView()
    
    var medias: [Media] = [] {
        didSet {
            delegate?.mediaComposerView(self, didUpdateMedias: medias)
            collectionView.reloadData()
        }
    }
    
    // MARK: Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }
    
    // MARK: - Private
    
    private func setUp() {
        guard subviews.isEmpty else { return }
        addSubview(collectionView)
        collectionView.pinToSuperView()
    }
    
    private func makeCollectionView() -> UICollectionView {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = .init(width: 60, height: 50)
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
        medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ofClass: MediaComposerCollectionViewCell.self, for: indexPath)
        cell.configure(with: medias[indexPath.item])
        cell.delegate = self
        return cell
    }
}

extension MediaComposerView: UICollectionViewDelegate {
    // MARK: - UICollectionViewDelegate
}

extension MediaComposerView: MediaComposerCollectionViewCellDelegate {
    // MARK: - MediaComposerCollectionViewCellDelegate
    
    func mediaComposerCollectionVIewCell(_: MediaComposerCollectionViewCell, didTapDeleteButtonFor media: Media) {
        delegate?.mediaComposerView(self, didTapDeleteButtonOn: media)
    }
}
