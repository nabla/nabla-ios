import Foundation
import NablaCore

enum FileUploadRemoteDataSourceError: Error {
    case cannotReadFileData
    case uploadError(UploadClientError)
    case unknownError(Error)
}

// sourcery: AutoMockable
protocol FileUploadRemoteDataSource {
    /// - Throws: ``FileUploadRemoteDataSourceError``
    func upload(file: RemoteFileUpload) async throws -> UUID
}

extension FileUploadRemoteDataSource {
    // To be removed when migrating to combine
    // https://github.com/nabla/health/issues/22332
    func upload(file: RemoteFileUpload, handler: ResultHandler<UUID, FileUploadRemoteDataSourceError>) -> NablaCancellable {
        Task {
            do {
                let uuid = try await upload(file: file)
                handler(.success(uuid))
            } catch let error as FileUploadRemoteDataSourceError {
                handler(.failure(error))
            } catch {
                handler(.failure(.unknownError(error)))
            }
        }
        return UmbrellaCancellable() // Temporary, the `upload` cannot be cancelled anyway
    }
}
