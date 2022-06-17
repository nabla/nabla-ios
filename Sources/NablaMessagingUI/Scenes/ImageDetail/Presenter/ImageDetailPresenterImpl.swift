import Foundation
import NablaMessagingCore

class ImageDetailPresenterImpl: ImageDetailPresenter {
    // MARK: - Initializer
    
    init(viewContract: ImageDetailViewContract,
         image: ImageFile) {
        self.viewContract = viewContract
        self.image = image
    }
    
    // MARK: - Presenter
    
    func start() {
        let transformer = ImageDetailViewModelTransformer()
        let viewModel = transformer.transform(image: image)
        viewContract?.configure(with: viewModel)
    }
    
    // MARK: - ImageDetailPresenter
    
    // MARK: - Private
    
    private weak var viewContract: ImageDetailViewContract?
    
    private let image: ImageFile
}
