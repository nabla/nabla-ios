import UIKit

public extension NablaExtension where Base: UIViewController {
    // MARK: - Public
    
    func makeController(for alert: AlertViewModel) -> UIAlertController {
        let controller = UIAlertController(
            title: alert.title,
            message: alert.message,
            preferredStyle: .alert
        )
        
        alert.actions
            .map(transform(_:))
            .forEach(controller.addAction(_:))
        
        return controller
    }
    
    // MARK: - Private
    
    private func transform(_ action: AlertViewModel.Action) -> UIAlertAction {
        UIAlertAction(
            title: action.title,
            style: transform(action.style),
            handler: { _ in action.handler() }
        )
    }
    
    private func transform(_ style: AlertViewModel.Action.Style) -> UIAlertAction.Style {
        switch style {
        case .default: return .default
        case .destructive: return .destructive
        case .cancel: return .cancel
        }
    }
}
