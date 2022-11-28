import Foundation
import NablaCore

class FileUploadRemoteDataSourceImpl: FileUploadRemoteDataSource {
    // MARK: - Initializer

    init(uploadClient: UploadClient) {
        self.uploadClient = uploadClient
    }

    // MARK: - FileUploadRemoteDataSource
    
    /// - Throws: ``FileUploadRemoteDataSourceError``
    func upload(file: RemoteFileUpload) async throws -> UUID {
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
                throw FileUploadRemoteDataSourceError.cannotReadFileData
            }
        }
        
        let upload = UploadData(
            purpose: file.purpose.rawValue,
            content: uploadData,
            fileName: file.fileName,
            mimeType: file.mimeType
        )
        do {
            return try await uploadClient.upload(upload)
        } catch let error as UploadClientError {
            throw FileUploadRemoteDataSourceError.uploadError(error)
        } catch {
            throw FileUploadRemoteDataSourceError.unknownError(error)
        }
    }
    
    // MARK: - Private
    
    private let uploadClient: UploadClient
}
