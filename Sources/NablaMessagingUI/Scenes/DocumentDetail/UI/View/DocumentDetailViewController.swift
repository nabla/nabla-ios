import Foundation
import UIKit
import WebKit

class DocumentDetailViewController: UIViewController, DocumentDetailViewContract {
    // MARK: - Lifecycle
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presenter?.start()
    }
    
    // MARK: - Public
    
    var presenter: DocumentDetailPresenter?
    
    // MARK: - DocumentDetailViewContract
    
    func configure(with viewModel: DocumentDetailViewModel) {
        pdfView.load(URLRequest(url: viewModel.url))
    }
    
    // MARK: - Private
    
    private lazy var pdfView: WKWebView = {
        let view = WKWebView(frame: self.view.bounds)
        view.scrollView.isScrollEnabled = true
        return view
    }()
    
    private func setUp() {
        view.addSubview(pdfView)
        pdfView.nabla.pinToSuperView()
    }
}
