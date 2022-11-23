import Foundation

public enum ImageSource: Equatable, Hashable {
    case data(Data)
    case url(URL)
    
    public func asMedia() -> MediaSource {
        switch self {
        case let .data(data): return .data(data)
        case let .url(url): return .url(url)
        }
    }
    
    public static func fromString(_ string: String?) -> ImageSource? {
        guard
            let string = string,
            let url = URL(string: string)
        else { return nil }
        return .url(url)
    }
}
