import Foundation
import UIKit

extension UIAlertController {
    static func create(with viewModel: AlertViewModel) -> Self {
        let alertController = Self(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        alertController.addAction(.init(title: viewModel.defaultAction, style: .default))
        return alertController
    }
}
