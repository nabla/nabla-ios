import Foundation
import NablaCore
import UIKit

protocol ErrorViewDelegate: AnyObject {
    func didTapRetryButton(in errorView: AppointmentConfirmationViewController.ErrorView)
}

extension AppointmentConfirmationViewController {
    final class ErrorView: UIView {
        // MARK: - Internal
        
        var text: String? {
            get { errorTextLabel.text }
            set { errorTextLabel.text = newValue }
        }
        
        var onRetryButtonTap: (() -> Void)?
        
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
        
        private lazy var errorTextLabel: UILabel = {
            let view = UILabel()
            view.numberOfLines = 0
            view.textAlignment = .center
            view.textColor = NablaTheme.AppointmentConfirmationTheme.disclaimersErrorTextColor // TODO:
            view.font = NablaTheme.AppointmentConfirmationTheme.disclaimersErrorFont
            return view
        }()
        
        private lazy var retryButton: NablaViews.PrimaryButton = {
            let view = NablaViews.PrimaryButton()
            view.setTitle(L10n.confirmationScreenErrorRetryButton, for: .normal)
            view.theme = NablaTheme.AppointmentConfirmationTheme.disclaimersErrorRetryButton
            view.onTap = { [weak self] in
                self?.onRetryButtonTap?()
            }
            return view
        }()
        
        private func setUp() {
            let vstack = UIStackView(arrangedSubviews: [errorTextLabel, retryButton])
            vstack.axis = .vertical
            vstack.alignment = .center
            vstack.distribution = .fill
            vstack.spacing = 8
            addSubview(vstack)
            vstack.nabla.pinToSuperView(insets: .nabla.make(horizontal: 8, vertical: 20))
        }
    }
}
