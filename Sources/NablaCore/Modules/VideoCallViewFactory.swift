import UIKit

public protocol VideoCallViewFactory {
    func createVideoCallRoomViewController(url: String, token: String) -> UIViewController
}
