import Foundation

enum LocationType {
    case physical
    case remote
}

public enum Location: Equatable {
    case physical(PhysicalLocation)
    case remote(RemoteLocation)
    case unknown
    
    public struct PhysicalLocation: Equatable {
        public let address: Address
    }

    public enum RemoteLocation: Equatable {
        case videoCallRoom(VideoCallRoom?)
        case externalCallURL(URL)

        public struct VideoCallRoom: Equatable {
            public let url: String
            public let token: String
        }
    }
    
    var type: LocationType? {
        switch self {
        case .physical: return .physical
        case .remote: return .remote
        case .unknown: return nil
        }
    }
}

extension Location {
    var asRemote: RemoteLocation? {
        switch self {
        case let .remote(remoteLocation): return remoteLocation
        case .physical: return nil
        case .unknown: return nil
        }
    }
    
    var asPhysical: PhysicalLocation? {
        switch self {
        case .remote: return nil
        case let .physical(physicalLocation): return physicalLocation
        case .unknown: return nil
        }
    }
}
