import NablaCore
import UIKit

protocol DocumentPickerDelegate: AnyObject {
    func documentPickerDidCancel(_ viewController: UIViewController)
    func documentPicker(_ viewController: UIViewController, didSelect media: Media)
}

class DocumentPickerModule: NSObject {
    // MARK: - Initializer

    init(delegate: DocumentPickerDelegate) {
        self.delegate = delegate
    }

    // MARK: Public

    func makeViewController() -> UIViewController {
        let viewController = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        viewController.allowsMultipleSelection = false
        viewController.delegate = self
        return viewController
    }

    // MARK: - Private

    private weak var delegate: DocumentPickerDelegate?
}

extension DocumentPickerModule: UIDocumentPickerDelegate {
    // MARK: - UIDocumentPickerDelegate

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else {
            delegate?.documentPickerDidCancel(controller)
            return
        }
        let media = Media(
            type: .pdf,
            fileName: url.lastPathComponent,
            fileUrl: url,
            thumbnailUrl: nil,
            mimeType: .pdf
        )
        delegate?.documentPicker(controller, didSelect: media)
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        delegate?.documentPickerDidCancel(controller)
    }
}
