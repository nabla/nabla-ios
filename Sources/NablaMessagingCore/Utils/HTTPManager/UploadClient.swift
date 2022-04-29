import Foundation
import NablaUtils
import UIKit

public enum UploadClientError: Error {
    case noSelf
    case noAccessToken
    case noFileData
    case impossibleToBuildFormData
    case noValidData
}

public class UploadClient {
    // MARK: - Public
    
    public func upload(media: Media, completion: @escaping (Result<UUID, UploadClientError>) -> Void) {
        authenticator.getAccessToken { [weak self] result in
            guard let state = result.value else {
                completion(.failure(UploadClientError.noAccessToken))
                return
            }
            switch state {
            case let .authenticated(accessToken: token):
                self?.doUpload(authToken: token, media: media, completion: completion)
            case .unauthenticated:
                completion(.failure(.noSelf))
            }
        }
    }
    
    // MARK: - Private
    
    @Inject private var httpManager: HTTPManager
    @Inject private var authenticator: Authenticator
    
    private func makeHeaders(authToken: String) -> [String: String] {
        [
            HTTPHeaders.Accept: "application/json",
            HTTPHeaders.NablaAuthorization: "Bearer \(authToken)",
        ]
    }
    
    private func makeMultipartFormData(media: Media) -> Result<MultipartFormData.BuildResult, UploadClientError> {
        guard
            // TODO: (Thibault Tourailles) - Create new type of media that carries a purpose instead of
            // hardcoding this one
            let purpose = "MESSAGE".data(using: .utf8),
            let data = try? Data(contentsOf: media.fileUrl)
        else {
            return .failure(UploadClientError.noFileData)
        }
        do {
            let multipartFormData = try MultipartFormData.Builder.build(
                with: [
                    (
                        name: "purpose",
                        filename: nil,
                        mimeType: nil,
                        data: purpose
                    ),
                    (
                        name: "file",
                        filename: media.fileName,
                        mimeType: Self.makeMimeType(from: media.mimeType),
                        data: data
                    ),
                ],
                willSeparateBy: RandomBoundaryGenerator.generate()
            )
            return .success(multipartFormData)
        } catch {
            return .failure(.impossibleToBuildFormData)
        }
    }
    
    private func doUpload(authToken: String, media: Media, completion: @escaping (Result<UUID, UploadClientError>) -> Void) {
        var request = UploadEndpoint.request()
        var headers = makeHeaders(authToken: authToken)
        var body: Data?
        
        switch makeMultipartFormData(media: media) {
        case let .success(multipartFormData):
            headers[HTTPHeaders.ContentType] = multipartFormData.contentType
            body = multipartFormData.body
        case .failure:
            completion(.failure(.impossibleToBuildFormData))
            return
        }
        
        request = request.headers(headers)
        request = request.body(body)
        
        httpManager.fetch(UploadEndpoint.Result.self, associatedTo: request) { result in
            guard
                let uuidString = result.value?.first,
                let uuid = UUID(uuidString: uuidString)
            else {
                completion(.failure(.noValidData))
                return
            }
            completion(.success(uuid))
        }
    }
    
    private static func makeMimeType(from mimeType: MimeType) -> MIMEType {
        switch mimeType {
        case .png:
            return .imagePng
        case .jpg:
            return .imageJpeg
        case .heic:
            return MIMEType(text: "image/heic")
        case .heif:
            return MIMEType(text: "image/heif")
        case .mov:
            return .videoWebm
        case .mpeg:
            return .audioMpeg
        case .pdf:
            return MIMEType(text: "application/pdf")
        }
    }
}
