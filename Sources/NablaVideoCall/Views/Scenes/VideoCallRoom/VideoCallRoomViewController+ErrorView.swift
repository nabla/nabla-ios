import UIKit

extension VideoCallRoomViewController {
    final class ErrorView: UIView {
        // MARK: - Internal
        
        var message: String? {
            get { label.text }
            set { label.text = newValue }
        }
        
        var action: String? {
            get { button.title(for: .normal) }
            set { button.setTitle(newValue, for: .normal) }
        }
        
        var onTapAction: (() -> Void)?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUpSubviews()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUpSubviews()
        }
        
        // MARK: - Private
        
        private let label: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.textColor = .white
            view.textAlignment = .center
            view.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            return view
        }()
        
        private lazy var button: UIButton = {
            let view = UIButton(type: .custom)
            view.setTitleColor(.darkText, for: .normal)
            view.backgroundColor = .white
            view.layer.cornerRadius = 10
            view.layer.masksToBounds = true
            view.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            view.addTarget(self, action: #selector(buttonTapHandler), for: .touchUpInside)
            view.contentEdgeInsets = .init(top: 8, left: 16, bottom: 8, right: 16)
            return view
        }()
        
        private func setUpSubviews() {
            let vstack = UIStackView(arrangedSubviews: [label, button])
            vstack.axis = .vertical
            vstack.distribution = .fill
            vstack.alignment = .center
            vstack.spacing = 16
            addSubview(vstack)
            vstack.nabla.constraintToCenter(in: safeAreaLayoutGuide, insets: 32)
        }
        
        @objc private func buttonTapHandler() {
            onTapAction?()
        }
    }
}
