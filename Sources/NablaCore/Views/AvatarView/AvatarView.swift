import UIKit

public extension NablaViews {
    class AvatarView: UIView {
        // MARK: - Public
        
        public var avatar: AvatarViewModel = .init(url: nil, text: nil) {
            didSet { configure(with: avatar) }
        }
        
        // MARK: Init
        
        override public init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        public required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        // MARK: - Private
        
        private lazy var imageAvatarView: ImageView = createImageAvatarView()
        private lazy var initialsAvatarView: UILabel = createInitialsAvatarView()
        private lazy var defaultAvatarView: UIView = createDefaultAvatarView()
        
        private func createImageAvatarView() -> ImageView {
            let view = ImageView()
            view.backgroundColor = .clear
            view.contentMode = .scaleAspectFill
            return view
        }
        
        private func createInitialsAvatarView() -> UILabel {
            let view = UILabel()
            view.backgroundColor = .clear
            view.textAlignment = .center
            view.textColor = NablaTheme.AvatarView.tintColor
            return view
        }
        
        private func createDefaultAvatarView() -> UIView {
            let imageView = UIImageView()
            imageView.backgroundColor = .clear
            imageView.image = NablaTheme.AvatarView.defaultIcon
            imageView.tintColor = NablaTheme.AvatarView.tintColor
            imageView.contentMode = .scaleAspectFill
            return imageView
        }
        
        private var backgroundLayer: CALayer? {
            didSet {
                if let oldValue = oldValue {
                    oldValue.removeFromSuperlayer()
                }
                if let newValue = backgroundLayer {
                    layer.insertSublayer(newValue, at: 0)
                }
            }
        }
        
        private func setUp() {
            addSubview(imageAvatarView)
            imageAvatarView.nabla.pinToSuperView()
            
            addSubview(initialsAvatarView)
            initialsAvatarView.nabla.pinToSuperView()
            
            addSubview(defaultAvatarView)
            defaultAvatarView.nabla.constraintToCenterInSuperView()
        }

        // MARK: Lifecycle
        
        override public func layoutSubviews() {
            super.layoutSubviews()
            update()
        }
        
        private func configure(with viewModel: AvatarViewModel) {
            backgroundColor = NablaTheme.AvatarView.backgroundColor
            if let url = URL(string: viewModel.url) {
                backgroundColor = .clear
                imageAvatarView.source = .url(url)
                setVisible(subview: imageAvatarView)
            } else if let text = viewModel.text {
                initialsAvatarView.text = text
                setVisible(subview: initialsAvatarView)
            } else {
                setVisible(subview: defaultAvatarView)
            }
        }
        
        private func update() {
            layer.cornerRadius = frame.height / 2
            layer.masksToBounds = true
            
            backgroundLayer?.frame = layer.bounds
            
            let fontSize = min(frame.height, frame.width) / 2.2
            initialsAvatarView.font = .nabla.regular(fontSize)

            defaultAvatarView.nabla.constraintToSize(
                CGSize(
                    width: min(frame.height, frame.width) / 2,
                    height: min(frame.height, frame.width) / 2
                ))
        }
        
        private func setVisible(subview: UIView) {
            [imageAvatarView, initialsAvatarView, defaultAvatarView].forEach { $0.isHidden = $0 != subview }
        }
    }
}
