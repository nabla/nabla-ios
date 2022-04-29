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
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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
