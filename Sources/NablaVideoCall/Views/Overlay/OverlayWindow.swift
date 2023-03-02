import UIKit

private extension UIWindow.Level {
    static let overlay = UIWindow.Level(rawValue: 500)
}

final class OverlayWindow: UIWindow {
    // MARK: - Internal
    
    init(viewController: UIViewController) {
        if let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            super.init(windowScene: windowScene)
        } else {
            super.init(frame: UIScreen.main.bounds)
        }
        rootViewController = viewController
        windowLevel = .overlay
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func makeKeyAndVisible() {
        super.makeKeyAndVisible()
        Self.overlays.append(self)
    }
    
    override func resignKey() {
        // Do not call super. We always deny requests to resign key.
        // We forward every hit by overriding the `hitTest(_:with:)` method.
        // If you need to explicitly remove the `OverlayWindow`, call `dismiss()` instead.
    }
    
    func dismiss() {
        super.resignKey()
        if let index = Self.overlays.firstIndex(where: { $0 === self }) {
            Self.overlays.remove(at: index)
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        if view === self {
            return nil
        }
        return view
    }
    
    // MARK: - Private
    
    private static var overlays = [OverlayWindow]()
}
