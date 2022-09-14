import Foundation
import UIKit

public struct SheetViewModel<Source> {
    public let source: Source
    public let actions: [Action]
    public let cancel: String
    
    public init(
        source: Source,
        actions: [Action],
        cancel: String
    ) {
        self.source = source
        self.actions = actions
        self.cancel = cancel
    }
    
    public struct Action {
        public let title: String
        public let style: Style
        public let handler: () -> Void
        
        public enum Style {
            case `default`
            case destructive
        }
        
        public static func `default`(title: String, handler: @escaping () -> Void) -> Action {
            Action(title: title, style: .default, handler: handler)
        }
        
        public static func destructive(title: String, handler: @escaping () -> Void) -> Action {
            Action(title: title, style: .destructive, handler: handler)
        }
    }
}
