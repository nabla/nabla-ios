import UIKit

public extension NablaExtension where Base: UIViewController {
    // MARK: - Public
    
    func makeController<Source>(for sheet: SheetViewModel<Source>, sourceView: UIView) -> UIAlertController {
        makeController(for: sheet, sourceViewProvider: { _ in sourceView })
    }
    
    func makeController<Source>(for sheet: SheetViewModel<Source>, sourceViewProvider: (Source) -> UIView?) -> UIAlertController {
        let style: UIAlertController.Style
        let sourceView: UIView?
        let cancel: UIAlertAction?
        if UIDevice.current.userInterfaceIdiom == .phone {
            // If on iPhone, no need to care about `sourceView`
            style = .actionSheet
            sourceView = nil
            cancel = UIAlertAction(title: sheet.cancel, style: .cancel)
        } else if let view = sourceViewProvider(sheet.source) {
            style = .actionSheet
            sourceView = view
            cancel = nil
        } else {
            // We must fallback to `.alert` when we are unable to provide the `sourceView`. Otherwise, it crashes on iPads.
            style = .alert
            sourceView = nil
            cancel = UIAlertAction(title: sheet.cancel, style: .cancel)
        }
        
        let controller = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: style
        )
        
        sheet.actions
            .map(transform(_:))
            .forEach(controller.addAction(_:))
        
        if let cancel = cancel {
            controller.addAction(cancel)
        }
        
        controller.popoverPresentationController?.sourceView = sourceView
        controller.popoverPresentationController?.sourceRect = sourceView?.frame ?? .zero
        return controller
    }
    
    // MARK: - Private
    
    private func transform<Source>(_ action: SheetViewModel<Source>.Action) -> UIAlertAction {
        UIAlertAction(
            title: action.title,
            style: transform(action.style),
            handler: { _ in action.handler() }
        )
    }
    
    private func transform<Source>(_ style: SheetViewModel<Source>.Action.Style) -> UIAlertAction.Style {
        switch style {
        case .default: return .default
        case .destructive: return .destructive
        }
    }
}
