import Foundation
import NablaCore

final class ConsentsRemoteDataSourceImpl: ConsentsRemoteDataSource {
    // MARK: - Internal
    
    /// Throws: `GQLError`
    func fetchConsents() async throws -> RemoteConsents {
        let response = try await gqlClient.fetch(query: GQL.GetAppointmentConfirmationConsentsQuery(), cachePolicy: .returnCacheDataElseFetch)
        return RemoteConsents(
            firstConsentHtml: response.appointmentConfirmationConsents.firstConsentHtml,
            secondConsentHtml: response.appointmentConfirmationConsents.secondConsentHtml
        )
    }
    
    // MARK: Init
    
    init(
        gqlClient: AsyncGQLClient
    ) {
        self.gqlClient = gqlClient
    }
    
    // MARK: - Private
    
    private let gqlClient: AsyncGQLClient
}
