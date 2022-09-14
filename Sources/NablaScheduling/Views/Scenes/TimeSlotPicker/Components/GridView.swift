import NablaCore
import UIKit

final class GridView<Subview: UIView, Item: Identifiable>: UIView {
    // MARK: - Internal
    
    var items: [Item] = [] {
        didSet { update() }
    }
    
    // MARK: Init
    
    init(
        columns: Int,
        configure: @escaping (Subview, Int, Item) -> Void
    ) {
        self.columns = columns
        self.configure = configure
        super.init(frame: .infinite)
        setUp()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private let columns: Int
    private let configure: (Subview, Int, Item) -> Void
    
    // MARK: Suviews
    
    private lazy var vstack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .fill
        view.spacing = 12
        return view
    }()
    
    private func setUp() {
        addSubview(vstack)
        vstack.nabla.pinToSuperView()
    }
    
    private func update() {
        let nbRemains = items.count % columns
        let nbRows = items.count / columns + (nbRemains > 0 ? 1 : 0)
        
        for rowIndex in 0 ..< nbRows {
            let row = makeOrRecyleRow(at: rowIndex)
            row.isHidden = false
            
            for columnIndex in 0 ..< columns {
                let itemIndex = (rowIndex * columns) + columnIndex
                let view = makeOrRecycleView(at: columnIndex, in: row)
                if let item = items.nabla.element(at: itemIndex) {
                    configure(view, itemIndex, item)
                    view.alpha = 1
                } else {
                    view.alpha = 0 // Hide but occupy space
                }
            }
        }
        
        for rowIndex in nbRows ..< vstack.arrangedSubviews.count {
            let row = vstack.arrangedSubviews[rowIndex]
            row.isHidden = true // Hide and free space
        }
    }
    
    private func makeOrRecyleRow(at index: Int) -> UIStackView {
        if let row = vstack.arrangedSubviews.nabla.element(at: index) as? UIStackView {
            return row
        }
        let row = UIStackView()
        row.axis = .horizontal
        row.distribution = .fillEqually
        row.alignment = .fill
        row.spacing = 12
        vstack.addArrangedSubview(row)
        return row
    }
    
    private func makeOrRecycleView(at index: Int, in row: UIStackView) -> Subview {
        if let view = row.arrangedSubviews.nabla.element(at: index) as? Subview {
            return view
        }
        let view = Subview()
        row.addArrangedSubview(view)
        return view
    }
}
