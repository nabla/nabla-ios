import Foundation
import UIKit

public struct AlertViewModel {
    // MARK: - Public
    
    public let title: String
    public let message: String
    public let actions: [Action]
    
    public init(
        title: String,
        message: String,
        actions: [Action]
    ) {
        self.title = title
        self.message = message
        self.actions = actions
    }
    
    public static func error(
        title: String,
        error: Error,
        fallbackMessage: String
    ) -> AlertViewModel {
        AlertViewModel(
            title: title,
            message: format(error, fallback: fallbackMessage),
            actions: [
                Action(title: L10n.errorDefaultCloseButton, style: .cancel, handler: {}),
            ]
        )
    }
    
    public struct Action {
        public let title: String
        public let style: Style
        public let handler: () -> Void
        
        public enum Style {
            case `default`
            case destructive
            case cancel
        }
        
        public static func `default`(title: String, handler: @escaping () -> Void) -> Action {
            Action(title: title, style: .default, handler: handler)
        }
        
        public static func destructive(title: String, handler: @escaping () -> Void) -> Action {
            Action(title: title, style: .destructive, handler: handler)
        }
        
        public static func cancel(title: String) -> Action {
            Action(title: title, style: .cancel, handler: {})
        }
    }
    
    // MARK: - Private
    
    private static func format(_ error: Error, fallback: String) -> String {
        if let serverError = error as? ServerError {
            return serverError.message ?? fallback
        }
        if let networkError = error as? NetworkError {
            return networkError.message ?? fallback
        }
        return fallback
    }
}
