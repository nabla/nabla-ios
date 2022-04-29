import UIKit

class UISpacerView: UIView {
    // MARK: - Public
    
    public enum Size {
        case fixed(value: CGFloat) // Uses the exact size
        case flexible // Can hugg parent but try to be as small as possible
        case expands // Tries to be as big as possible
    }
    
    // MARK: - Initializer
    
    init(axis: NSLayoutConstraint.Axis, size: Size = .flexible, color: UIColor = .clear) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        
        switch size {
        case let .fixed(value):
            switch axis {
            case .horizontal:
                widthAnchor.constraint(equalToConstant: value).isActive = true
            case .vertical:
                heightAnchor.constraint(equalToConstant: value).isActive = true
            @unknown default:
                break
            }
        case .expands:
            switch axis {
            case .horizontal:
                widthAnchor.constraint(equalToConstant: 1000).with(priority: .defaultLow).isActive = true
            case .vertical:
                heightAnchor.constraint(equalToConstant: 1000).with(priority: .defaultLow).isActive = true
            @unknown default:
                break
            }
            
        case .flexible:
            break
        }
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
