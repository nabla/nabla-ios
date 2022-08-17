import UIKit

class AvatarView: UIView {
    // MARK: Lifecycle
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        update()
    }
    
    // MARK: - Public
    
    func configure(with viewModel: AvatarViewModel) {
        if let url = URL(string: viewModel.url) {
            imageAvatarView.url = url
            setVisible(subview: imageAvatarView)
        } else if let text = viewModel.text {
            initialsAvatarView.text = text
            setVisible(subview: initialsAvatarView)
        } else {
            setVisible(subview: deletedAvatarView)
        }
    }
    
    // MARK: - Private
    
    private lazy var imageAvatarView: UIURLImageView = createImageAvatarView()
    private lazy var initialsAvatarView: UILabel = createInitialsAvatarView()
    private lazy var deletedAvatarView: UIView = createDeletedAvatarView()
    
    fileprivate var backgroundLayer: CALayer? {
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
        
        addSubview(deletedAvatarView)
        deletedAvatarView.nabla.pinToSuperView()
    }
    
    private func update() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        
        backgroundLayer?.frame = layer.bounds
        
        let fontSize = min(frame.height, frame.width) / 2.2
        initialsAvatarView.font = .regular(fontSize)
    }
    
    private func createImageAvatarView() -> UIURLImageView {
        let view = UIURLImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        return view
    }
    
    private func createInitialsAvatarView() -> UILabel {
        let view = UILabel()
        view.backgroundColor = NablaTheme.Shared.avatarViewBackgroundColor
        view.textAlignment = .center
        view.textColor = .white
        return view
    }
    
    private func createDeletedAvatarView() -> UIView {
        let view = UIView()
        view.backgroundColor = NablaTheme.Shared.avatarViewBackgroundColor
        return view
    }
    
    private func setVisible(subview: UIView) {
        [imageAvatarView, initialsAvatarView, deletedAvatarView].forEach { $0.isHidden = $0 != subview }
    }
}
