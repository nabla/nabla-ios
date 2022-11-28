import Foundation
import NablaCore

class TransientUUID {
    // MARK: - Internal
    
    let localId: UUID
    var remoteId: UUID?
    
    func set(remoteId: UUID) {
        guard self.remoteId != remoteId else { return }
        self.remoteId = remoteId
        remoteIdNotifier.notify(value: remoteId)
    }
    
    func observeRemoteId(_ callback: @escaping (_ remoteId: UUID) -> Void) -> NablaCancellable {
        remoteIdNotifier.observe { [weak self] remoteId in
            self?.remoteId = remoteId
            callback(remoteId)
        }
    }
    
    // MARK: Init
    
    init(remoteId: UUID) {
        localId = remoteId
        self.remoteId = remoteId
    }
    
    init(localId: UUID, remoteId: UUID?) {
        self.localId = localId
        self.remoteId = remoteId
        
        selfObserveCancellable = observeRemoteId { _ in }
    }
    
    // MARK: - Private
    
    private lazy var remoteIdNotifier: Notifier<UUID> = .init(id: localId.uuidString)
    
    private var selfObserveCancellable: NablaCancellable?
}
