import Combine
import Foundation
import NablaCore

final class ProviderRemoteDataSourceImpl: ProviderRemoteDataSource {
    // MARK: - Internal

    func watchProvider(id: UUID) -> AnyPublisher<RemoteProvider, GQLError> {
        gqlClient.watch(query: GQL.GetProviderQuery(providerId: id))
            .compactMap { response -> RemoteProvider? in
                response.provider.provider.fragments.providerFragment
            }
            .eraseToAnyPublisher()
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
