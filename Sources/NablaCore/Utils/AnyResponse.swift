import Foundation

public struct AnyResponse<Data, Failure: Error> {
    public let data: Data
    public let isDataFresh: Bool
    public let refreshingState: RefreshingState<Failure>
    
    public init(
        data: Data,
        isDataFresh: Bool,
        refreshingState: RefreshingState<Failure>
    ) {
        self.data = data
        self.isDataFresh = isDataFresh
        self.refreshingState = refreshingState
    }
}

public extension AnyResponse {
    func map<D, F: Error>(data dataTransform: (Data) -> D, error errorTransform: (Failure) -> F) -> AnyResponse<D, F> {
        .init(
            data: dataTransform(data),
            isDataFresh: isDataFresh,
            refreshingState: refreshingState.mapError(errorTransform)
        )
    }
    
    func mapData<D>(_ transform: (Data) -> D) -> AnyResponse<D, Failure> {
        .init(
            data: transform(data),
            isDataFresh: isDataFresh,
            refreshingState: refreshingState
        )
    }
    
    func mapError<F: Error>(_ transform: (Failure) -> F) -> AnyResponse<Data, F> {
        .init(
            data: data,
            isDataFresh: isDataFresh,
            refreshingState: refreshingState.mapError(transform)
        )
    }
    
    func asResponse(_ errorTransform: (Failure) -> NablaError) -> Response<Data> {
        .init(
            data: data,
            isDataFresh: isDataFresh,
            refreshingState: refreshingState.mapError(errorTransform)
        )
    }
}

public extension AnyResponse where Failure: NablaError {
    func asResponse() -> Response<Data> {
        asResponse { $0 }
    }
}
