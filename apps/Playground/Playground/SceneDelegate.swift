import IAP
import NablaCore
import NablaUIMessaging
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.makeKeyAndVisible()
        self.window = window
        
        NablaClient.shared.addRefetchTriggers(
            NotificationRefetchTrigger(name: UIApplication.willEnterForegroundNotification)
        )
        
        switch XCConfig().env {
        case .development, .staging:
            openIAP()
        case .production:
            openApp()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            NablaClient.shared.authenticate(userID: UUID(), provider: self) { result in
                print("auth \(result)")
                
                // swiftlint:disable:next force_unwrapping
                self.cancellable = NablaClient.shared.observeItems(ofConversationWithId: UUID(uuidString: "63206A0E-0487-4425-96FB-AAE662985BA2")!) { result in
                    print("gql \(result)")
                }
            }
        }
    }
    
    var cancellable: Cancellable?

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
    
    private func openApp() {
        window?.rootViewController = UINavigationController(rootViewController: InboxViewController())
    }
    
    private func openIAP() {
        let config = XCConfig()
        window?.rootViewController = IAPViewController(
            configuration: .init(
                clientId: config.iapClientId,
                serverId: config.iapServerId
            ),
            delegate: self
        )
    }
}

extension SceneDelegate: IAPViewControllerDelegate {
    func iapViewController(_: IAPViewController, didSucceedWithToken token: String) {
        NablaClient.shared.addHTTPHeader(name: "Authorization", value: "Bearer \(token)")
        openApp()
    }
}

extension SceneDelegate: NablaAuthenticationProvider {
    func provideTokens(completion: (Tokens?) -> Void) {
        let tokens = Tokens(
            accessToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiOTRiMmQwMi1iNWY4LTQ2ODYtOWI5Zi1lNDk4OWE2Yzc5ODkiLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IkJlYXJlciIsImV4cCI6MTY0OTk0Mzg3OSwic2Vzc2lvbl91dWlkIjoiZDY2Mjc4YzMtZjlmNi00ODRiLTg0OWMtNGI4NDE5NmNhMjQwIiwib3JnYW5pemF0aW9uU3RyaW5nSWQiOiJuYWJsYSJ9.KmS5TctsE-74m1vSNwbj0XJdmu10RQDBUh390Uczz7Q",
            refreshToken: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJiOTRiMmQwMi1iNWY4LTQ2ODYtOWI5Zi1lNDk4OWE2Yzc5ODkiLCJpc3MiOiJkZXYtcGF0aWVudCIsInR5cCI6IlJlZnJlc2giLCJleHAiOjE2NTc3MTk1NzksInNlc3Npb25fdXVpZCI6ImQ2NjI3OGMzLWY5ZjYtNDg0Yi04NDljLTRiODQxOTZjYTI0MCIsIm9yZ2FuaXphdGlvblN0cmluZ0lkIjoibmFibGEifQ.q8HXs-fnF8XTpU9XuYRgtrvFFkl_CN0jVAMBOs3bcFo"
        )
        completion(tokens)
    }
}
