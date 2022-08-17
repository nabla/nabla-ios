import UIKit

protocol PictureInPicturePresentable: UIViewController {
    func contentViewForPictureInPictureViewController(_ viewController: PictureInPictureViewController) -> UIView
    
    func pictureInPictureViewController(_ viewController: PictureInPictureViewController, willMinimize view: UIView)
    func pictureInPictureViewController(_ viewController: PictureInPictureViewController, didMinimize view: UIView)
    func pictureInPictureViewController(_ viewController: PictureInPictureViewController, willRestore view: UIView)
    func pictureInPictureViewController(_ viewController: PictureInPictureViewController, didRestore view: UIView)
}

extension PictureInPicturePresentable {
    func pictureInPictureViewController(_: PictureInPictureViewController, willMinimize _: UIView) {}
    func pictureInPictureViewController(_: PictureInPictureViewController, didMinimize _: UIView) {}
    func pictureInPictureViewController(_: PictureInPictureViewController, willRestore _: UIView) {}
    func pictureInPictureViewController(_: PictureInPictureViewController, didRestore _: UIView) {}
}
