import Foundation

protocol FileUploadRemoteDataSource {
    func upload(media: Media, completion: @escaping (Result<UUID, UploadClientError>) -> Void)
}
