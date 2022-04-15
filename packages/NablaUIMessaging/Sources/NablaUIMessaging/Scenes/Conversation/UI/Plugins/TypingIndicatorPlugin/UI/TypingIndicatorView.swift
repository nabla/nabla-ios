import Foundation
import QuartzCore
import UIKit

final class TypingIndicatorView: UIView {
    // MARK: - Init

    init() {
        super.init(frame: .zero)

        replicatorLayer?.instanceCount = 3
        replicatorLayer?.instanceTransform = CATransform3DMakeTranslation(15, 0, 0)
        replicatorLayer?.instanceDelay = 0.2

        let redCircle = CALayer()
        redCircle.backgroundColor = CoreAssets.Colors.tint.color.cgColor
        redCircle.frame = CGRect(x: 10, y: 25, width: 10, height: 10)
        redCircle.cornerRadius = 5

        replicatorLayer?.addSublayer(redCircle)

        let animation = CABasicAnimation(keyPath: "position.y")
        animation.duration = 0.3
        animation.fromValue = redCircle.position.y
        animation.toValue = redCircle.position.y - 15
        animation.autoreverses = true
        animation.repeatCount = .infinity

        redCircle.add(animation, forKey: "position.y")
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal

    override var intrinsicContentSize: CGSize {
        CGSize(width: 60, height: 45)
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
