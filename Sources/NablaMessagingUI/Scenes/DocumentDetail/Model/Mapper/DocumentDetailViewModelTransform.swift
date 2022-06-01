import Foundation
import NablaMessagingCore

struct DocumentDetailViewModelTransformer {
    // MARK: - Public
    
    func transform(document: Media) -> DocumentDetailViewModel {
        DocumentDetailViewModel(url: document.fileUrl)
    }
}
