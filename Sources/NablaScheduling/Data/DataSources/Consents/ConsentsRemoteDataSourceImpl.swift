import Foundation
import NablaCore

final class ConsentsRemoteDataSourceImpl: ConsentsRemoteDataSource {
    // MARK: - Internal
    
    /// - Throws: ``GQLError``
    func fetchConsents() async throws -> RemoteConsents {
        let response = try await gqlClient.fetch(
            query: GQL.GetAppointmentConfirmationConsentsQuery(),
            policy: .returnCacheDataElseFetch
        )
        return RemoteConsents(
            firstConsentHtml: response.appointmentConfirmationConsents.firstConsentHtml,
            secondConsentHtml: response.appointmentConfirmationConsents.secondConsentHtml
        )
    }
    
    // MARK: Init
    
    init(
        gqlClient: GQLClient
    ) {
        self.gqlClient = gqlClient
    }
    
    // MARK: - Private
    
    private let gqlClient: GQLClient
}
