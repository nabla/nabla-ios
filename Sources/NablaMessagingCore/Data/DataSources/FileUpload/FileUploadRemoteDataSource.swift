import Foundation
import NablaCore

enum FileUploadRemoteDataSourceError: Error {
    case cannotReadFileData
    case uploadError(UploadClientError)
}

// sourcery: AutoMockable
protocol FileUploadRemoteDataSource {
    func upload(file: RemoteFileUpload, handler: ResultHandler<UUID, FileUploadRemoteDataSourceError>) -> Cancellable
}
