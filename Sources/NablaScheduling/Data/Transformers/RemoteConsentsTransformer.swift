import Foundation

enum RemoteConsentsTransformer {
    static func transform(_ remoteConsents: RemoteConsents, location: LocationType) -> Consents {
        switch location {
        case .physical:
            return Consents(
                firstConsentHtml: remoteConsents.physicalFirstConsentHtml.nullIfEmpty(),
                secondConsentHtml: remoteConsents.physicalSecondConsentHtml.nullIfEmpty()
            )
        case .remote:
            return Consents(
                firstConsentHtml: remoteConsents.firstConsentHtml.nullIfEmpty(),
                secondConsentHtml: remoteConsents.secondConsentHtml.nullIfEmpty()
            )
        }
    }
}

private extension String {
    func nullIfEmpty() -> String? {
        if isEmpty {
            return nil
        }
        
        return self
    }
}
