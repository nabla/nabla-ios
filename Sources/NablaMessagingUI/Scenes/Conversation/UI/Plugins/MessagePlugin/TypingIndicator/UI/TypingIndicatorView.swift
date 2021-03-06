import Foundation
import QuartzCore
import UIKit

final class TypingIndicatorView: UIView {
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
        
        replicatorLayer?.instanceCount = 3
        replicatorLayer?.instanceTransform = CATransform3DMakeTranslation(12, 0, 0)
        replicatorLayer?.instanceDelay = 0.2
        
        let redCircle = CALayer()
        redCircle.backgroundColor = NablaTheme.Conversation.typingIndicatorDotColor.cgColor
        redCircle.frame = CGRect(x: 8, y: 20, width: 8, height: 8)
        redCircle.cornerRadius = 4
        
        replicatorLayer?.addSublayer(redCircle)
        
        let group = CAAnimationGroup()
        group.duration = 1.5
        group.repeatCount = .infinity
        
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.duration = 0.3
        animation.fromValue = redCircle.position.y
        animation.toValue = redCircle.position.y - 12
        animation.autoreverses = true
        
        group.animations = [animation]
        redCircle.add(group, forKey: "position.y")
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 52, height: 36)
    }
    
    override class var layerClass: AnyClass {
        CAReplicatorLayer.self
    }
    
    // MARK: - Private
    
    private var replicatorLayer: CAReplicatorLayer? {
        layer as? CAReplicatorLayer
    }
}

#if DEBUG
    import SwiftUI
    
    struct TypingIndicatorView_Previews: PreviewProvider {
        static var preview: TypingIndicatorView {
            TypingIndicatorView()
        }
        
        static var previews: some View {
            UIViewPreview {
                preview
            }
            .frame(width: preview.intrinsicContentSize.width,
                   height: preview.intrinsicContentSize.height,
                   alignment: .center)
            .background(Color(UIColor.lightGray))
            .previewLayout(
                .fixed(
                    width: preview.intrinsicContentSize.width,
                    height: preview.intrinsicContentSize.height
                )
            )
        }
    }
#endif
