import NablaCore
import UIKit

public class NablaVideoCallViewFactory: VideoCallViewFactory {
    // MARK: - Public
    
    public func createVideoCallRoomViewController(url: String, token: String) -> UIViewController {
        #if targetEnvironment(simulator)
            let alert = UIAlertController(
                title: L10n.notAvailableOnSimulatorErrorTitle,
                message: L10n.notAvailableOnSimulatorErrorMessage,
                preferredStyle: .alert
            )
            let action = UIAlertAction(title: L10n.notAvailableOnSimulatorErrorAction, style: .cancel)
            alert.addAction(action)
            return alert
        #else
            let presenter = VideoCallRoomPresenterImpl(
                url: url,
                token: token,
                dependencies: .init(
                    currentVideoCallInteractor: client.container.currentVideoCallInteractor,
                    logger: client.container.logger
                )
            )
            let viewController = VideoCallRoomViewController(presenter: presenter)
            presenter.bind(to: viewController)
            return viewController
        #endif
    }
    
    // MARK: Initializer
    
    public init(
        client: NablaVideoCallClient
    ) {
        self.client = client
    }
    
    // MARK: - Internal
    
    // MARK: - Private
    
    private let client: NablaVideoCallClient
}
