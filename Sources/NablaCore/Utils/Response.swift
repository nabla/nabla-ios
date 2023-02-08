import Foundation

public struct Response<Data> {
    public let data: Data
    public let isDataFresh: Bool
    public let refreshingState: RefreshingState<NablaError>
}
