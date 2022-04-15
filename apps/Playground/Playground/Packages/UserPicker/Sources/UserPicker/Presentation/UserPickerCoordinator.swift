import ADCoordinator
import UIKit

public protocol UserPickerCoordinatorDelegate: AnyObject {
    func userPickerCoordinator(_ coordinator: UserPickerCoordinator, didAuthenticate user: User, with tokens: Tokens)
}

public class UserPickerCoordinator: Coordinator {
    // MARK: - Public
    
    public init(
        navigationController: UINavigationController,
        delegate: UserPickerCoordinatorDelegate
    ) {
        self.navigationController = navigationController
        self.delegate = delegate
    }
    
    public func start() {
        let viewController = UserListViewController(delegate: self)
        viewController.title = "Select user"
        viewController.navigationItem.addRightBarButtonItem(createUserBarButton)
        navigationController.pushViewController(viewController, animated: false)
        bindToLifecycle(of: viewController)
    }
    
    // MARK: - Private
    
    private unowned var navigationController: UINavigationController
    private weak var delegate: UserPickerCoordinatorDelegate?
    
    private lazy var createUserBarButton: UIBarButtonItem = {
        let view = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(createUserButtonHandler)
        )
        return view
    }()
    
    @objc private func createUserButtonHandler() {
        navigateToCreateUserScreen()
    }
    
    private func navigateToCreateUserScreen() {
        let viewController = CreateUserViewController(delegate: self)
        viewController.title = "Create user"
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func navigateToLobby(user: User) {
        let viewController = UserLobbyViewController()
        let presenter = UserLobbyPresenter(
            user: user,
            view: viewController,
            delegate: self
        )
        viewController.presenter = presenter
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension UserPickerCoordinator: UserListViewControllerDelegate {
    func userListViewController(_: UserListViewController, didSelect user: User) {
        navigateToLobby(user: user)
    }
}

extension UserPickerCoordinator: CreateUserViewControllerDelegate {
    func createUserViewController(_: CreateUserViewController, didCreate user: User) {
        navigateToLobby(user: user)
    }
}

extension UserPickerCoordinator: UserLobbyPresenterDelegate {
    func userLobbyPresenter(_: UserLobbyPresenter, didFetch tokens: Tokens, for user: User) {
        delegate?.userPickerCoordinator(self, didAuthenticate: user, with: tokens)
    }
}
