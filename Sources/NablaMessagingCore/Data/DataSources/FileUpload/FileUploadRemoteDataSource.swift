import Foundation

enum FileUploadRemoteDataSourceError: Error {
    case cantReadFileData
    case uploadError(UploadClientError)
}

protocol FileUploadRemoteDataSource {
    func upload(file: RemoteFileUpload, completion: @escaping (Result<UUID, FileUploadRemoteDataSourceError>) -> Void)
}
