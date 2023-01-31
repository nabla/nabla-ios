import Combine
import Foundation
import NablaCore

final class ConsentsRemoteDataSourceImpl: ConsentsRemoteDataSource {
    // MARK: - Internal

    func watchConsents() -> AnyPublisher<RemoteConsents, GQLError> {
        gqlClient.watch(
            query: GQL.GetAppointmentConfirmationConsentsQuery(),
            policy: .returnCacheDataAndFetch
        )
        .map { data in
            data.appointmentConfirmationConsents
        }
        .eraseToAnyPublisher()
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
