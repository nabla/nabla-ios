import Foundation

public enum ImagePickerError: Error {
    case unableToReadAssetData(url: URL)
    case failedToCreateJpegData
    case unknownAssetType
    case missingAssetData
    case failedToSaveTemporaryFile
    case internalError
    case invalidType
    case iOS14Only
}
