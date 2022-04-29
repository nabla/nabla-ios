import Foundation
import NablaMessagingCore

struct DocumentDetailViewModelMapper {
    // MARK: - Public
    
    func map(document: Media) -> DocumentDetailViewModel {
        DocumentDetailViewModel(url: document.fileUrl)
    }
}
