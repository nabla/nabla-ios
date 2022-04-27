import Foundation
import UIKit

public struct ContextMenuConfiguration {
    let indexPath: IndexPath
    let title: String?
    let items: [UIMenuElement]

    func makeUIConfiguration() -> UIContextMenuConfiguration {
        .init(
            identifier: Self.serialize(indexPath: indexPath),
            previewProvider: nil,
            actionProvider: { _ in
                if let title = title {
                    return .init(title: title, children: items)
                } else {
                    return .init(children: items)
                }
            }
        )
    }

    private static let separator = ":"

    private static func serialize(indexPath: IndexPath) -> NSString {
        "\(indexPath.section)\(separator)\(indexPath.row)" as NSString
    }

    fileprivate static func deserialize(identifier rawValue: NSCopying) -> IndexPath? {
        guard let identifier = rawValue as? String else { return nil }
        let components = identifier.components(separatedBy: separator)
        guard
            components.count == 2,
            let first = components.first,
            let last = components.last,
            let section = Int(first),
            let row = Int(last)
        else { return nil }
        return .init(row: row, section: section)
    }
}

protocol ConversationContextCell {
    func makeContextMenuConfiguration(for indexPatch: IndexPath) -> ContextMenuConfiguration?
    func previewForHighlightingContextMenu() -> UITargetedPreview?
}

extension UIContextMenuConfiguration {
    var indexPath: IndexPath? {
        ContextMenuConfiguration.deserialize(identifier: identifier)
    }
}
