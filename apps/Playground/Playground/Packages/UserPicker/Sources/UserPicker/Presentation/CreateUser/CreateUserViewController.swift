import UIKit

protocol CreateUserViewControllerDelegate: AnyObject {
    func createUserViewController(_ viewController: CreateUserViewController, didCreate user: User)
}

final class CreateUserViewController: UIViewController {
    // MARK: - Internal
    
    init(
        delegate: CreateUserViewControllerDelegate
    ) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private let repository = UserRepository()
    
    private weak var delegate: CreateUserViewControllerDelegate?
    
    private let labelField: InputField = {
        let view = InputField(frame: .zero)
        view.title = "Label"
        view.placeholder = "John Smith (Preprod)"
        view.value = nil
        view.error = nil
        view.autocapitalizationType = .none
        return view
    }()
    
    private let uuidField: InputField = {
        let view = InputField(frame: .zero)
        view.title = "UUID"
        view.placeholder = UUID().uuidString
        view.value = nil
        view.error = nil
        view.autocapitalizationType = .allCharacters
        return view
    }()
    
    private lazy var doneButton: UIBarButtonItem = {
        let view = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonHandler))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        navigationItem.addRightBarButtonItem(doneButton)
        
        let vstack = UIStackView(arrangedSubviews: [labelField, uuidField])
        vstack.axis = .vertical
        vstack.alignment = .fill
        vstack.spacing = 8
        view.addSubview(vstack)
        vstack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            vstack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            vstack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
    
    @objc private func doneButtonHandler() {
        guard let user = validateFields() else { return }
        repository.persist(user: user)
        delegate?.createUserViewController(self, didCreate: user)
    }
    
    private func validateFields() -> User? {
        guard let label = labelField.value else {
            labelField.error = "Label can't be empty"
            return nil
        }
        labelField.error = nil
        
        guard let uuid = UUID(uuidString: uuidField.value ?? "") else {
            uuidField.error = "Invalid format"
            return nil
        }
        uuidField.error = nil
        
        return User(label: label, uuid: uuid)
    }
}

private final class InputField: UIView {
    // MARK: - Internal
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var placeholder: String? {
        get { textField.placeholder }
        set { textField.placeholder = newValue }
    }
    
    var value: String? {
        get { textField.text }
        set { textField.text = newValue }
    }
    
    var error: String? {
        get { errorLabel.text }
        set {
            errorLabel.text = newValue
            errorLabel.isHidden = newValue == nil
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType {
        get { textField.autocapitalizationType }
        set { textField.autocapitalizationType = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubviews()
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    
    private let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private let textField: UITextField = {
        let view = TextField()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        view.padding = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return view
    }()
    
    private let errorLabel: UILabel = {
        let view = UILabel()
        view.textColor = .red
        view.textAlignment = .center
        return view
    }()
    
    private func setUpSubviews() {
        let vstack = UIStackView(arrangedSubviews: [titleLabel, textField, errorLabel])
        vstack.axis = .vertical
        vstack.alignment = .fill
        vstack.spacing = 4
        addSubview(vstack)
        vstack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: topAnchor),
            vstack.bottomAnchor.constraint(equalTo: bottomAnchor),
            vstack.leadingAnchor.constraint(equalTo: leadingAnchor),
            vstack.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            textField.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}

private class TextField: UITextField {
    var padding: UIEdgeInsets = .zero

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            x: bounds.origin.x + padding.left,
            y: bounds.origin.y + padding.top,
            width: bounds.size.width - padding.left - padding.right,
            height: bounds.size.height - padding.top - padding.bottom
        )
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }
}
