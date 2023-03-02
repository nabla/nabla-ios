import NablaCore
import UIKit

final class PictureInPictureViewController: OverlayViewController {
    // MARK: - Internal
    
    func close(animated: Bool, completion: (() -> Void)?) {
        guard let context = context else { return }
        
        source.pictureInPictureViewController(self, willRestore: context.contentView)
        UIView.animate(
            withDuration: animated ? Constants.animationDuration : 0,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.expandContainer()
            },
            completion: { _ in
                self.initialPresentingViewController.present(self.source, animated: false) {
                    self.restoreContentView(context: context)
                    self.window?.dismiss()
                    context.contentView.window?.makeKey()
                    self.source.pictureInPictureViewController(self, didRestore: context.contentView)
                    completion?()
                }
            }
        )
    }
    
    init?(source: PictureInPicturePresentable) {
        guard let initialPresentingViewController = source.presentingViewController else {
            return nil // PictureInPictureViewController only supports modals
        }
        guard source.modalPresentationStyle == .overFullScreen else {
            return nil // PictureInPictureViewController only supports `.overFullScreen` modals
        }
        self.source = source
        self.initialPresentingViewController = initialPresentingViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private enum Constants {
        static let animationDuration = TimeInterval(0.25)
        static let maxMinimizedSize = CGSize(width: 138, height: 224)
        static let padding = CGFloat(16)
    }
    
    private struct Context {
        let contentView: UIView
        let minimizedScale: CGFloat
        let frameInWindow: CGRect
        let superview: UIView?
        let translatesAutoresizingMaskIntoConstraints: Bool
        let constraints: [NSLayoutConstraint]
    }
    
    private let source: PictureInPicturePresentable
    private let initialPresentingViewController: UIViewController
    
    private var context: Context?
    
    private lazy var safeAreaView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.addGestureRecognizer(tapRecognizer)
        view.addGestureRecognizer(panRecognizer)
        return view
    }()
    
    private lazy var tapRecognizer: UITapGestureRecognizer = .init(target: self, action: #selector(tapRecognizerHandler))
    
    private lazy var panRecognizer: UIPanGestureRecognizer = .init(target: self, action: #selector(panGestureDidChange(_:)))
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(safeAreaView)
        safeAreaView.nabla.pin(to: view.safeAreaLayoutGuide, insets: .nabla.all(Constants.padding))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let context = extractContentView()
        setUpContainer(context: context)
        
        source.pictureInPictureViewController(self, willMinimize: context.contentView)
        initialPresentingViewController.dismiss(animated: false)
        UIView.animate(
            withDuration: Constants.animationDuration,
            delay: 0,
            options: .curveEaseInOut,
            animations: {
                self.minimizeContainer(scale: context.minimizedScale)
            },
            completion: { _ in
                self.source.pictureInPictureViewController(self, didMinimize: context.contentView)
            }
        )
        self.context = context
    }
    
    // MARK: - Container handling
    
    private func extractContentView() -> Context {
        let contentView = source.contentViewForPictureInPictureViewController(self)
        let superview = contentView.superview
        let frame = contentView.convert(contentView.bounds, to: contentView.window)
        let translatesAutoresizingMaskIntoConstraints = contentView.translatesAutoresizingMaskIntoConstraints
        let constraints = contentView.selfConstraints
        NSLayoutConstraint.deactivate(constraints)
        let scale = min(
            Constants.maxMinimizedSize.width / frame.width,
            Constants.maxMinimizedSize.height / frame.height
        )
        return Context(
            contentView: contentView,
            minimizedScale: scale,
            frameInWindow: frame,
            superview: superview,
            translatesAutoresizingMaskIntoConstraints: translatesAutoresizingMaskIntoConstraints,
            constraints: constraints
        )
    }
    
    private func setUpContainer(context: Context) {
        view.addSubview(container)
        container.frame = view.convert(context.frameInWindow, to: view)
        container.frame.origin = clampToSafeArea(.zero)
        
        context.contentView.removeFromSuperview()
        container.addSubview(context.contentView)
        context.contentView.translatesAutoresizingMaskIntoConstraints = true
        context.contentView.frame = container.bounds
    }
    
    private func minimizeContainer(scale: CGFloat) {
        container.transform = CGAffineTransform(scaleX: scale, y: scale)
        container.frame.origin = clampToSafeArea(.zero)
        container.layer.cornerRadius = 8 / scale
    }
    
    private func expandContainer() {
        container.transform = .identity
        container.frame.origin = .zero
        container.layer.cornerRadius = 0
    }
    
    private func restoreContentView(context: Context) {
        guard let superview = context.superview, let window = superview.window else { return }
        superview.addSubview(context.contentView)
        context.contentView.frame = window.convert(context.frameInWindow, to: superview)
        context.contentView.translatesAutoresizingMaskIntoConstraints = context.translatesAutoresizingMaskIntoConstraints
        NSLayoutConstraint.activate(context.constraints)
    }
    
    private func clampToSafeArea(_ position: CGPoint) -> CGPoint {
        var frame = safeAreaView.frame
        frame.size.width -= container.frame.width
        frame.size.height -= container.frame.height
        return CGPoint(
            x: position.x.nabla.clamped(to: frame.minX ... frame.maxX),
            y: position.y.nabla.clamped(to: frame.minY ... frame.maxY)
        )
    }
    
    @objc private func tapRecognizerHandler() {
        close(animated: true, completion: nil)
    }
    
    private var initialPanPosition: CGPoint?
    @objc private func panGestureDidChange(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            initialPanPosition = container.frame.origin
        case .changed:
            guard let initialPanPosition = initialPanPosition else { return }
            let translation = recognizer.translation(in: safeAreaView)
            container.frame.origin = initialPanPosition + translation
        case .ended, .cancelled:
            guard let initialPanPosition = initialPanPosition else { return }
            let translation = recognizer.translation(in: safeAreaView)
            let newPosition = clampToSafeArea(initialPanPosition + translation)
            UIView.animate(withDuration: Constants.animationDuration, delay: 0, options: .curveEaseInOut) { [container] in
                container.frame.origin = newPosition
            }
            self.initialPanPosition = nil
        case .possible, .failed: return
        @unknown default: return
        }
    }
}

private extension UIView {
    var selfConstraints: [NSLayoutConstraint] {
        let selfConstraints = constraints.filter(affectsSelf(_:))
        let superviewConstraints = superview?.constraints.filter(affectsSelf(_:)) ?? []
        return selfConstraints + superviewConstraints
    }
    
    private func affectsSelf(_ constraint: NSLayoutConstraint) -> Bool {
        constraint.firstItem === superview && constraint.secondItem === self
            || constraint.firstItem === self && constraint.secondItem === superview
            || constraint.firstItem === self && constraint.secondItem == nil // for `widthAnchor` and `heightAnchor`
    }
}
