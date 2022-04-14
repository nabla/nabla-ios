import UIKit

protocol CameraPickerControllerDelegate: AnyObject {
    func cameraPickerControllerDidCancel(_ controller: CameraPickerController)
    func cameraPickerController(_ controller: CameraPickerController, didSelect medias: [Media], errors: [ImagePickerError])
}

class CameraPickerController: UIImagePickerController {
    weak var cameraPickerDelegate: CameraPickerControllerDelegate?

    // MARK: - Initializer
    
    static func make(mediaReader: MediaReader, mediaTypes: [MediaType], defaultCameraType: CameraType) -> CameraPickerController {
        let viewController = CameraPickerController()
        viewController.mediaReader = mediaReader
        viewController.mediaTypes = mediaTypes.flatMap(\.utTypes)
        viewController.sourceType = .camera
        viewController.cameraDevice = defaultCameraType.cameraDevice
        viewController.delegate = viewController
        return viewController
    }
    
    // MARK: - Private
    
    /// Should be `private let` and non-optional, but we can't override the `init` of `UIImagePickerController`
    private var mediaReader: MediaReader!
}

/// We only care about `UIImagePickerControllerDelegate`, but `UINavigationControllerDelegate` is a mandatory requirement.
extension CameraPickerController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        /// We capture `self` until done.  `DispatchQueue.async` guarantees that it will eventually be released.
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.mediaReader.readMedia(from: info)
            DispatchQueue.main.async {
                let medias = [result.value].compactMap { $0 }
                let errors = [result.error].compactMap { $0 }
                self.cameraPickerDelegate?.cameraPickerController(self, didSelect: medias, errors: errors)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_: UIImagePickerController) {
        cameraPickerDelegate?.cameraPickerControllerDidCancel(self)
    }
}

private extension CameraType {
    var cameraDevice: UIImagePickerController.CameraDevice {
        switch self {
        case .front:
            return .front
        case .rear:
            return .rear
        }
    }
}
