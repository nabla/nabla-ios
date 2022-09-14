import NablaCore
import UIKit

extension AppointmentConfirmationViewController {
    final class CheckboxFieldView: UIControl {
        // MARK: - Internal
        
        var isChecked: Bool {
            get { checkBox.isChecked }
            set { checkBox.isChecked = newValue }
        }
        
        var text: String? {
            get { label.text }
            set { label.text = newValue }
        }
        
        var onTap: (() -> Void)?
        
        // MARK: Init
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUp()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setUp()
        }
        
        // MARK: - Private
        
        // MARK: Subviews
        
        private lazy var label: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.textAlignment = .left
            view.textColor = NablaTheme.AppointmentConfirmationTheme.disclaimersTextColor
            view.font = NablaTheme.AppointmentConfirmationTheme.disclaimersFont
            return view
        }()
        
        private lazy var checkBox: NablaViews.CheckboxView = {
            let view = NablaViews.CheckboxView()
            view.nabla.constraintToSize(20)
            view.theme = NablaTheme.AppointmentConfirmationTheme.checkbox
            return view
        }()
        
        private func setUp() {
            let hstack = UIStackView(arrangedSubviews: [checkBox, label])
            hstack.axis = .horizontal
            hstack.distribution = .fill
            hstack.alignment = .center
            hstack.spacing = 8
            addSubview(hstack)
            hstack.nabla.pinToSuperView()
            hstack.isUserInteractionEnabled = false
            
            addTarget(self, action: #selector(tapHandler), for: .touchUpInside)
        }
        
        // MARK: Handlers
        
        @objc private func tapHandler() {
            onTap?()
        }
    }
}
