import NablaCore
import UIKit

class NavigationController: UINavigationController {
    // MARK: - Internal
    
    // MARK: Init
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        rootViewController.navigationItem.nabla.addLeftBarButtonItem(closeButton)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private lazy var closeButton: UIBarButtonItem = {
        let view = UIBarButtonItem(image: .nabla.symbol(.chevronDown), style: .plain, target: self, action: #selector(closeButtonHandler))
        view.tintColor = NablaTheme.primaryColor
        return view
    }()
    
    @objc private func closeButtonHandler() {
        /// Make sure to dismiss `self`, not our own `presentedViewController` instead.
        presentingViewController?.dismiss(animated: true)
    }
}
