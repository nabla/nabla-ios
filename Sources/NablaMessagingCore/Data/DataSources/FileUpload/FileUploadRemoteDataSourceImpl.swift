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
        let uploadData: Data
        switch file.content {
        case let .data(data):
            uploadData = data
        case let .url(url):
            do {
                let secure = url.startAccessingSecurityScopedResource()
                uploadData = try Data(contentsOf: url)
                if secure {
                    url.stopAccessingSecurityScopedResource()
                }
            } catch {
                handler(.failure(.cannotReadFileData))
                return Failure()
            }
        }
        
        let upload = UploadData(
            purpose: file.purpose.rawValue,
            content: uploadData,
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
