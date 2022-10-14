import NablaMessagingCore
import UIKit

protocol DocumentPickerDelegate: AnyObject {
    func documentPickerDidCancel(_ viewController: UIViewController)
    func documentPicker(_ viewController: UIViewController, didSelect media: Media)
}

@available(iOS 14, *)
class DocumentPickerModule: NSObject {
    // MARK: - Internal
    
    static func makeViewController(delegate: DocumentPickerDelegate) -> UIViewController {
        let viewController = DocumentPickerViewController(forOpeningContentTypes: [.pdf])
        viewController.allowsMultipleSelection = false
        viewController.delegate = viewController
        viewController._delegate = delegate
        return viewController
    }
    
    // MARK: - Private
    
    private weak var delegate: DocumentPickerDelegate?
}

@available(iOS 14, *)
class DocumentPickerViewController: UIDocumentPickerViewController, UIDocumentPickerDelegate {
    // swiftlint:disable:next identifier_name
    weak var _delegate: DocumentPickerDelegate?
    
    // MARK: - UIDocumentPickerDelegate
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            _delegate?.documentPickerDidCancel(controller)
            return
        }
        let media = DocumentFile(
            fileName: url.lastPathComponent,
            content: .url(url),
            thumbnailUrl: nil,
            mimeType: .pdf
        )
        _delegate?.documentPicker(controller, didSelect: media)
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        _delegate?.documentPickerDidCancel(controller)
    }
}
