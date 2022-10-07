import Foundation
import NablaMessagingCore

struct DocumentDetailViewModelTransformer {
    // MARK: - Public
    
    func transform(document: DocumentFile) -> DocumentDetailViewModel {
        DocumentDetailViewModel(
            fileName: document.fileName,
            url: document.fileUrl
        )
    }
}
