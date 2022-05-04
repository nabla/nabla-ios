import Foundation
import NablaUtils

class FileUploadRemoteDataSourceImpl: FileUploadRemoteDataSource {
    // MARK: - FileUploadRemoteDataSource
    
    func upload(file: RemoteFileUpload, completion: @escaping (Result<UUID, FileUploadRemoteDataSourceError>) -> Void) {
        guard let data = try? Data(contentsOf: file.fileUrl) else {
            completion(.failure(.cantReadFileData))
            return
        }
        
        let upload = UploadData(
            purpose: file.purpose.rawValue,
            content: data,
            fileName: file.fileName,
            mimeType: file.mimeType
        )
        uploadClient.upload(upload) { result in
            switch result {
            case let .success(uuid):
                completion(.success(uuid))
            case let .failure(error):
                completion(.failure(.uploadError(error)))
            }
        }
    }
    
    // MARK: - Private
    
    @Inject private var uploadClient: UploadClient
}
