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
    private lazy var deletedAvatarView: UILabel = createDeletedAvatarView()

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
        imageAvatarView.pinToSuperView()

        addSubview(initialsAvatarView)
        initialsAvatarView.pinToSuperView()

        addSubview(deletedAvatarView)
        deletedAvatarView.pinToSuperView()
    }

    private func update() {
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true

        backgroundLayer?.frame = layer.bounds

        let fontSize = min(frame.height, frame.width) / 2.2
        initialsAvatarView.font = .regular(fontSize)
        deletedAvatarView.font = .regular(fontSize)
    }

    private func createImageAvatarView() -> UIURLImageView {
        let view = UIURLImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFill
        return view
    }

    private func createInitialsAvatarView() -> UILabel {
        let view = UILabel()
        // TODO: (Thibault Tourailles) - Change background color
        view.backgroundColor = CoreAssets.Colors.tint.color
        view.textAlignment = .center
        view.textColor = .white
        return view
    }

    private func createDeletedAvatarView() -> UILabel {
        let view = UILabel()
        // TODO: (Thibault Tourailles) - Change background color
        view.backgroundColor = CoreAssets.Colors.tint.color
        view.text = "?"
        view.textAlignment = .center
        view.textColor = .black
        return view
    }

    private func setVisible(subview: UIView) {
        subviews.forEach { $0.isHidden = $0 != subview }
    }
}
