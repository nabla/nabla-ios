import NablaMessagingCore
import PhotosUI
import UIKit

protocol ImagePickerDelegate: AnyObject {
    func imagePickerDidCancel(_ viewController: UIViewController)
    func imagePicker(_ viewController: UIViewController, didSelect medias: [Media], errors: [ImagePickerError])
}

class ImagePickerModule: NSObject {
    // MARK: - Initializer
    
    init(delegate: ImagePickerDelegate) {
        self.delegate = delegate
    }
    
    // MARK: Public
    
    func makeViewController(source: ImagePickerSource, mediaTypes: [MediaType], defaultCameraType: CameraType = .rear) -> UIViewController {
        switch source {
        case .camera:
            let viewController = UIImagePickerController()
            viewController.mediaTypes = mediaTypes.flatMap(\.utTypes)
            viewController.sourceType = .camera
            viewController.cameraDevice = defaultCameraType.cameraDevice
            viewController.delegate = self
            
            return viewController
        case let .library(imageLimit):
            if #available(iOS 14, *) {
                var configuration = PHPickerConfiguration()
                configuration.filter = .any(of: mediaTypes.map(\.pickerFilter))
                configuration.selectionLimit = imageLimit ?? 0
                configuration.preferredAssetRepresentationMode = .current
                
                let viewController = PHPickerViewController(configuration: configuration)
                viewController.delegate = self
                
                return viewController
            } else {
                let viewController = UIImagePickerController()
                viewController.mediaTypes = mediaTypes.flatMap(\.utTypes)
                viewController.sourceType = .photoLibrary
                viewController.delegate = self

                return viewController
            }
        }
    }
    
    // MARK: - Private
    
    private let mediaReader = MediaReader()
    
    private weak var delegate: ImagePickerDelegate?
}

extension ImagePickerModule: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ controller: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.mediaReader.readMedia(from: info)
            DispatchQueue.main.async {
                let medias = [result.value].compactMap { $0 }
                let errors = [result.error].compactMap { $0 }
                self.delegate?.imagePicker(controller, didSelect: medias, errors: errors)
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ controller: UIImagePickerController) {
        delegate?.imagePickerDidCancel(controller)
    }
}

@available(iOS 14, *)
extension ImagePickerModule: PHPickerViewControllerDelegate {
    // MARK: - PHPickerViewControllerDelegate
    
    func picker(_ controller: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        guard !results.isEmpty else {
            delegate?.imagePickerDidCancel(controller)
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            self.mediaReader.readMedia(from: results.map(\.itemProvider)) { results in
                DispatchQueue.main.async {
                    let medias = results.compactMap(\.value)
                    let errors = results.compactMap(\.error)
                    self.delegate?.imagePicker(controller, didSelect: medias, errors: errors)
                }
            }
        }
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

@available(iOS 14, *)
private extension MediaType {
    var pickerFilter: PHPickerFilter {
        switch self {
        case .image:
            return .images
        case .video:
            return .videos
        case .pdf, .audio:
            return .any(of: [])
        }
    }
}
