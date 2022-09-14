import Combine
import Foundation
import NablaCore

protocol ProviderRemoteDataSource {
    func watchProvider(id: UUID) -> AnyPublisher<RemoteProvider, GQLError>
}
