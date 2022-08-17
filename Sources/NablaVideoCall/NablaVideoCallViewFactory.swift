import NablaCore
import UIKit

public class NablaVideoCallViewFactory: VideoCallViewFactory {
    // MARK: - Public
    
    public func createVideoCallRoomViewController(url: String, token: String) -> UIViewController {
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
