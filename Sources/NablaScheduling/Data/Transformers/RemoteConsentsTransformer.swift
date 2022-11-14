import Foundation

enum RemoteConsentsTransformer {
    static func transform(_ remoteConsents: RemoteConsents) -> Consents {
        Consents(
            firstConsentHtml: remoteConsents.firstConsentHtml.nullIfEmpty(),
            secondConsentHtml: remoteConsents.secondConsentHtml.nullIfEmpty()
        )
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
