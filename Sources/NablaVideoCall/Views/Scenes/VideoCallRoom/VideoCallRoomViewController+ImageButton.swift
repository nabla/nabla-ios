import UIKit

extension VideoCallRoomViewController {
    final class ImageButton: UIControl {
        // MARK: - Internal
        
        var image: UIImage? { didSet { update() } }
        var selectedImage: UIImage? { didSet { update() } }
        
        var imageColor: UIColor = .white { didSet { update() } }
        var selectedImageColor: UIColor = .darkText { didSet { update() } }
        
        var color: UIColor = .darkText { didSet { update() } }
        var selectedColor: UIColor = .white { didSet { update() } }
        
        override var isSelected: Bool {
            didSet { update() }
        }
        
        init(imageSize: CGSize) {
            self.imageSize = imageSize
            super.init(frame: .zero)
            setUpSubviews()
            update()
        }
        
        @available(*, unavailable)
        required init?(coder _: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Private
        
        private let imageSize: CGSize
        
        private lazy var imageView: UIImageView = {
            let view = UIImageView()
            view.contentMode = .scaleAspectFit
            view.nabla.constraintToSize(imageSize)
            return view
        }()
        
        private func setUpSubviews() {
            addSubview(imageView)
            imageView.nabla.constraintToCenterInSuperView()
        }
        
        private func update() {
            imageView.image = isSelected ? selectedImage : image
            imageView.tintColor = isSelected ? selectedImageColor : imageColor
            backgroundColor = isSelected ? selectedColor : color
        }
    }
}
