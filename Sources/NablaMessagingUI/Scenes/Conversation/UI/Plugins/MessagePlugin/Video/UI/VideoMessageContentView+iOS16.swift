import UIKit

extension VideoMessageContentView {
    class PassthroughiOS16Overlay: UIView {
        /// Mimics the play indicator missing on iOS 16.
        /// Does not support theming in order to always match with the system appearance.
        /// class PassthroughiOS16Overlay: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        // MARK: Overrides
        
        override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
            if super.hitTest(point, with: event) != nil {
                // If touched, hide the icon
                container.isHidden = true
            }
            // But always pretend nothing happened
            return nil
        }
        
        // MARK: - Private
        
        private lazy var iconView: UIView = {
            let view = UIImageView(image: .nabla.symbol(.playFill))
            view.tintColor = .white
            view.contentMode = .scaleAspectFill
            view.nabla.constraintToSize(44)
            return view
        }()
        
        private lazy var container: UIView = {
            let view = UIView()
            view.backgroundColor = .black.withAlphaComponent(0.5)
            view.nabla.constraintToSize(70)
            view.layer.cornerRadius = 35
            return view
        }()
        
        private func setUp() {
            container.addSubview(iconView)
            iconView.nabla.constraintToCenterInSuperView()
            addSubview(container)
            container.nabla.constraintToCenterInSuperView()
        }
    }
}
