import Foundation

struct VideoCallActionRequestContentViewModelTransformer {
    // MARK: - Public

    static func transform(item: VideoCallActionRequestViewItem, isCallInProgress: Bool) -> VideoCallActionRequestContentView.ContentViewModel {
        if item.room != nil {
            return .init(state: isCallInProgress ? .opened : .waiting)
        } else {
            return .init(state: .closed)
        }
    }
}
