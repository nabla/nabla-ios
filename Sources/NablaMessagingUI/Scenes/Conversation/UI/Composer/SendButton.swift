import Combine
import NablaCore
import UIKit

extension ComposerView {
    final class SendButton: UIButton {
        // MARK: - Internal
        
        func setTintColor(_ tintColor: UIColor, for state: State) {
            tintColors[state.rawValue] = tintColor
            update()
        }
        
        // MARK: Init
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initialize()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            initialize()
        }
        
        // MARK: - Private
        
        private var tintColors = [State.RawValue: UIColor]()
        private var subscriptions = [AnyCancellable]()
        
        private func initialize() {
            imageView?.nabla.pinToSuperView(insets: .nabla.all(2), priority: .defaultHigh)
            imageView?.contentMode = .scaleAspectFit
            setTintColor(tintColor, for: .normal)
            
            subscriptions = [
                publisher(for: \.isEnabled).sink { [weak self] _ in self?.update() },
                publisher(for: \.isHighlighted).sink { [weak self] _ in self?.update() },
                publisher(for: \.isSelected).sink { [weak self] _ in self?.update() },
            ]
        }
        
        private func update() {
            tintColor = tintColors[state.rawValue] ?? tintColors[State.normal.rawValue]
        }
    }
}
