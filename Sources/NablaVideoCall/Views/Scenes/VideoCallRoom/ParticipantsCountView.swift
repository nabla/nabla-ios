import Foundation
import NablaCore
import UIKit

final class ParticipantsCountView: UIView {
    var text: String? {
        get {
            label.text
        }
        set {
            label.text = newValue
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setUpSubviews()
        backgroundColor = .black.withAlphaComponent(0.7)
        nabla.constraintHeight(32)
        layer.cornerRadius = 16
        layer.borderWidth = 1
        layer.borderColor = UIColor(
            red: 33.0 / 255,
            green: 42.0 / 255,
            blue: 47.0 / 255,
            alpha: 1
        ).cgColor
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private let label = UILabel()
    
    private func setUpSubviews() {
        label.textColor = .white
        label.font = NablaTheme.Fonts.body
        
        let imageView = UIImageView(
            image: UIImage(
                systemName: "person",
                withConfiguration: UIImage.SymbolConfiguration(font: NablaTheme.Fonts.body)
            )
        )
        imageView.contentMode = .center
        imageView.nabla.constraintToSize(.init(width: 20, height: 20))
        imageView.tintColor = .white
        
        let hStack = UIStackView(arrangedSubviews: [imageView, label])
        hStack.axis = .horizontal
        hStack.spacing = 4
        
        addSubview(hStack)
        hStack.nabla.pinToSuperView(insets: .nabla.make(horizontal: 12, vertical: 6))
    }
}
