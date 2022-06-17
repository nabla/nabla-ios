import Foundation
import NablaMessagingCore

struct DocumentDetailViewModelTransformer {
    // MARK: - Public
    
    func transform(document: DocumentFile) -> DocumentDetailViewModel {
        DocumentDetailViewModel(url: document.fileUrl)
    }
}
