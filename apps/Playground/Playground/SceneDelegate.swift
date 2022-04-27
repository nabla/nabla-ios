import IAP
import NablaCore
import NablaUIMessaging
import NablaUtils
import Networking
import UIKit
import UserPicker

enum HTTPHeaders {
    static let Authorization = "Authorization"
    static let NablaAuthorization = "X-Nabla-Authorization"
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var rootCoordinator: Coordinator?
    var iapToken: String?
    var patientTokens: NablaCore.Tokens?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        
        if XCConfig.current.iapRequired {
            openIAP()
        } else {
            openUserPicker()
        }
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    private func openIAP() {
        let viewController = IAPViewController(
            configuration: .init(
                clientId: XCConfig.current.iapClientId,
                serverId: XCConfig.current.iapServerId
            ),
            delegate: self
        )
        setRootViewController(viewController, coordinator: nil, animated: true)
    }
    
    private func openUserPicker() {
        assemble()
        let navigationController = UINavigationController()
        let coordinator = UserPickerCoordinator(
            navigationController: navigationController,
            delegate: self
        )
        coordinator.start()
        setRootViewController(navigationController, coordinator: coordinator, animated: true)
    }
    
    private func openApp(user _: User) {
        let navigationController = UINavigationController()
        let coordinator = ConversationsCoordinator(navigationController: navigationController)
        coordinator.start(animated: false)
        setRootViewController(navigationController, coordinator: coordinator, animated: true)
    }
    
    private func assemble() {
        var extraHeaders = [
            // Prepare the Playground's headers as if it was our customers' backend.
            HTTPHeaders.NablaAuthorization: "Bearer \(XCConfig.current.apiToken)",
        ]
        if let iapToken = iapToken {
            // Prepare both the Playground's and the SDK's headers to pass the IAP.
            extraHeaders[HTTPHeaders.Authorization] = "Bearer \(iapToken)"
            NablaClient.shared.addHTTPHeader(name: HTTPHeaders.Authorization, value: "Bearer \(iapToken)")
        }
        
        let assembler = Assembler(assemblies: [
            NetworkAssembly(
                baseUrl: baseUrl,
                extraHeaders: extraHeaders
            ),
        ])
        assembler.assemble()
    }
    
    private var baseUrl: URL {
        var components = URLComponents()
        components.host = XCConfig.current.domain
        components.scheme = XCConfig.current.scheme
        components.port = XCConfig.current.port
        components.path = XCConfig.current.path
        // swiftlint:disable:next force_unwrapping
        return components.url!
    }
    
    private func setRootViewController(_ rootViewController: UIViewController, coordinator: Coordinator?, animated: Bool) {
        guard let window = window else { return }
        rootCoordinator = coordinator
        let isFirstViewController = window.rootViewController == nil
        let duration = animated && !isFirstViewController ? 0.25 : 0
        UIView.transition(with: window, duration: duration) {
            window.rootViewController = rootViewController
        }
    }
}

extension SceneDelegate: IAPViewControllerDelegate {
    func iapViewController(_: IAPViewController, didSucceedWithToken token: String) {
        iapToken = token
        openUserPicker()
    }
}

extension SceneDelegate: UserPickerCoordinatorDelegate {
    func userPickerCoordinator(_: UserPickerCoordinator, didAuthenticate user: User, with tokens: UserPicker.Tokens) {
        patientTokens = .init(
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken
        )
        openApp(user: user)
    }
}

extension SceneDelegate: NablaAuthenticationProvider {
    func provideTokens(completion: (NablaCore.Tokens?) -> Void) {
        completion(patientTokens)
    }
}

extension UserPickerCoordinator: Coordinator {}
