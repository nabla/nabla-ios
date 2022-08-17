import UIKit

class OverlayViewController: UIViewController {
    var window: OverlayWindow? {
        view.window as? OverlayWindow
    }
    
    override func loadView() {
        view = PassthroughView()
    }
}

private final class PassthroughView: UIView {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === self {
            return nil
        }
        return view
    }
}
