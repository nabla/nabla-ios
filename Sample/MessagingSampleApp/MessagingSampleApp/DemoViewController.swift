import NablaCore
import UIKit

class DemoViewController: UIViewController {
    // MARK: - Internal
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: createConversationButton)
        
        setContentView(Label(text: "Hello world!"))
    }
    
    func setContentView(_ contentView: UIView) {
        view.subviews.forEach { $0.removeFromSuperview() }
        view.addSubview(contentView)
        contentView.nabla.pinToSuperView()
    }
    
    // MARK: Handlers
    
    @objc func createConversationButtonHandler() {}
    
    // MARK: - Private
    
    private lazy var createConversationButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        view.addTarget(self, action: #selector(createConversationButtonHandler), for: .touchUpInside)
        return view
    }()
}

class Label: UILabel {
    init(text: String) {
        super.init(frame: .zero)
        self.text = text
        textAlignment = .center
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
