import Foundation

public enum MediaSource: Equatable, Hashable {
    case data(Data)
    case url(URL)
}
