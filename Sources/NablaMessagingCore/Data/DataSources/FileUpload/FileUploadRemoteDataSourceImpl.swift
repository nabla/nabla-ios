import Foundation
import NablaCore

class FileUploadRemoteDataSourceImpl: FileUploadRemoteDataSource {
    // MARK: - Initializer

    init(uploadClient: UploadClient) {
        self.uploadClient = uploadClient
    }

    // MARK: - FileUploadRemoteDataSource
    
    func upload(
        file: RemoteFileUpload,
        handler: ResultHandler<UUID, FileUploadRemoteDataSourceError>
    ) -> Cancellable {
        guard let data = try? Data(contentsOf: file.fileUrl) else {
            handler(.failure(.cannotReadFileData))
            return Failure()
        }
        
        let upload = UploadData(
            purpose: file.purpose.rawValue,
            content: data,
            fileName: file.fileName,
            mimeType: file.mimeType
        )
        return uploadClient.upload(
            upload,
            handler: handler.pullbackError(FileUploadRemoteDataSourceError.uploadError)
        )
    }
    
    // MARK: - Private
    
    private let uploadClient: UploadClient
}
