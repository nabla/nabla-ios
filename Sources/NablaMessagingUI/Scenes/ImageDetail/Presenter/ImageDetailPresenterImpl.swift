import Foundation
import NablaMessagingCore

class ImageDetailPresenterImpl: ImageDetailPresenter {
    // MARK: - Initializer
    
    init(viewContract: ImageDetailViewContract,
         media: Media) {
        self.viewContract = viewContract
        self.media = media
    }
    
    // MARK: - Presenter
    
    func start() {
        let transformer = ImageDetailViewModelTransformer()
        let viewModel = transformer.transform(media: media)
        viewContract?.configure(with: viewModel)
    }
    
    // MARK: - ImageDetailPresenter
    
    // MARK: - Private
    
    private weak var viewContract: ImageDetailViewContract?
    
    private let media: Media
}
