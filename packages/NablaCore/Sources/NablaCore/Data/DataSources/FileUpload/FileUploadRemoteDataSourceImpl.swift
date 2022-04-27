import Foundation
import NablaUtils

class FileUploadRemoteDataSourceImpl: FileUploadRemoteDataSource {
    // MARK: - FileUploadRemoteDataSource

    func upload(media: Media, completion: @escaping (Result<UUID, UploadClientError>) -> Void) {
        uploadClient.upload(media: media) { result in
            switch result {
            case let .success(uuid):
                completion(.success(uuid))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private

    @Inject private var uploadClient: UploadClient
}
