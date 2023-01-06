import Combine
import Foundation
import NablaCore

final class TransientUUID {
    // MARK: - Internal
    
    let localId: UUID
    
    var remoteId: UUID? {
        Self.localToRemoteIdsSubject.value[localId]
    }
    
    func set(remoteId: UUID) {
        guard self.remoteId == nil else { return }
        Self.localToRemoteIdsSubject.value[localId] = remoteId
    }
    
    func observeRemoteId(_ callback: @escaping (_ remoteId: UUID) -> Void) -> AnyCancellable {
        observeRemoteId()
            .compactMap { $0 }
            .sink(receiveValue: callback)
    }
    
    func observeRemoteId() -> AnyPublisher<UUID?, Never> {
        remoteIdSubject
            .eraseToAnyPublisher()
    }
    
    // MARK: Init
    
    init(remoteId: UUID) {
        localId = remoteId
        Self.localToRemoteIdsSubject.value[remoteId] = remoteId
    }
    
    init(localId: UUID, remoteId: UUID?) {
        self.localId = localId
        Self.localToRemoteIdsSubject.value[localId] = remoteId
    }
    
    // MARK: - Private
    
    private static let localToRemoteIdsSubject = CurrentValueSubject<[UUID: UUID], Never>([:])
    
    private lazy var remoteIdSubject: AnyPublisher<UUID?, Never> = Self.localToRemoteIdsSubject
        .map { [localId] localToRemoteIds in
            localToRemoteIds[localId]
        }
        .removeDuplicates()
        .eraseToAnyPublisher()
}
