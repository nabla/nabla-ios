import Foundation
import NablaCore
import NablaMessagingCore

extension MaybeProvider {
    var fullNameWithPrefix: String {
        switch self {
        case .deletedProvider:
            return L10n.providerDeletedName
        case let .provider(provider):
            return provider.fullNameWithPrefix
        }
    }
    
    var abbreviatedNameWithPrefix: String {
        switch self {
        case .deletedProvider:
            return L10n.providerDeletedName
        case let .provider(provider):
            return provider.abbreviatedNameWithPrefix
        }
    }
    
    var initials: String? {
        switch self {
        case .deletedProvider:
            return nil
        case let .provider(provider):
            return provider.initials
        }
    }
}

extension Provider {
    var fullNameWithPrefix: String {
        [prefix, firstName, lastName].compactMap(identity).joined(separator: " ")
    }
    
    var abbreviatedNameWithPrefix: String {
        if prefix != nil {
            return [prefix, lastName].compactMap(identity).joined(separator: " ")
        } else {
            return fullNameWithPrefix
        }
    }
    
    var initials: String? {
        String([firstName, lastName].compactMap(\.first)).nabla.nilIfEmpty
    }
}
