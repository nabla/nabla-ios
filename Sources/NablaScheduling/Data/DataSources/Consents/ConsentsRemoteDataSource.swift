import Combine
import Foundation
import NablaCore

// sourcery: AutoMockable
protocol ConsentsRemoteDataSource {
    func watchConsents() -> AnyPublisher<RemoteConsents, GQLError>
}
