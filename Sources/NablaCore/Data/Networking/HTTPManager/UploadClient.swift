import Foundation

public enum UploadClientError: Error {
    case noAccessToken
    case impossibleToBuildFormData(Error)
    case noValidData
    case failedToSerializePurpose
    case failedRequest(HTTPError)
}

public struct UploadData {
    public let purpose: String
    public let content: Data
    public let fileName: String
    public let mimeType: MimeType
    
    public init(
        purpose: String,
        content: Data,
        fileName: String,
        mimeType: MimeType
    ) {
        self.purpose = purpose
        self.content = content
        self.fileName = fileName
        self.mimeType = mimeType
    }
}

public final class UploadClient {
    // MARK: - Initializer

    init(
        httpManager: HTTPManager,
        authenticator: Authenticator
    ) {
        self.httpManager = httpManager
        self.authenticator = authenticator
    }

    // MARK: - Public
    
    /// - Throws: ``UploadClientError``
    public func upload(_ data: UploadData) async throws -> UUID {
        do {
            let auth = try await authenticator.getAuthenticationState()
            
            switch auth {
            case let .authenticated(accessToken: token):
                return try await doUpload(authToken: token, data: data)
            case .notAuthenticated:
                throw UploadClientError.noAccessToken
            }
        } catch let error as UploadClientError {
            throw error
        } catch is AuthenticationError {
            throw UploadClientError.noAccessToken
        }
    }
    
    // MARK: - Private
    
    private let httpManager: HTTPManager
    private let authenticator: Authenticator
    
    private func makeHeaders(authToken: String) -> [String: String] {
        [
            HTTPHeaders.Accept: "application/json",
            HTTPHeaders.NablaAuthorization: "Bearer \(authToken)",
        ]
    }
    
    /// - Throws: ``UploadClientError``
    private func makeMultipartFormData(data: UploadData) async throws -> MultipartFormData.BuildResult {
        guard
            let purpose = data.purpose.data(using: .utf8)
        else {
            throw UploadClientError.failedToSerializePurpose
        }
        do {
            return try MultipartFormData.Builder.build(
                with: [
                    (
                        name: "purpose",
                        filename: nil,
                        mimeType: nil,
                        data: purpose
                    ),
                    (
                        name: "file",
                        filename: data.fileName,
                        mimeType: Self.makeMimeType(from: data.mimeType),
                        data: data.content
                    ),
                ],
                willSeparateBy: RandomBoundaryGenerator.generate()
            )
        } catch {
            throw UploadClientError.impossibleToBuildFormData(error)
        }
    }
    
    /// - Throws: ``UploadClientError``
    private func doUpload(
        authToken: String,
        data: UploadData
    ) async throws -> UUID {
        var request = UploadEndpoint.request()
        var headers = makeHeaders(authToken: authToken)
        var body: Data?
        
        let multipartFormData = try await makeMultipartFormData(data: data)
        headers[HTTPHeaders.ContentType] = multipartFormData.contentType
        body = multipartFormData.body
        
        request = request.headers(headers)
        request = request.body(body)
        
        do {
            let response = try await httpManager.fetch(UploadEndpoint.Result.self, associatedTo: request)
            guard
                let uuidString = response.first,
                let uuid = UUID(uuidString: uuidString)
            else {
                throw UploadClientError.noValidData
            }
            return uuid
        } catch let error as UploadClientError {
            throw error
        } catch let error as HTTPError {
            throw UploadClientError.failedRequest(error)
        } catch {
            throw UploadClientError.noValidData
        }
    }
    
    private static func makeMimeType(from mimeType: MimeType) -> MIMEType {
        switch mimeType {
        case let .image(imageType):
            switch imageType {
            case .png: return MIMEType.imagePng
            case .jpg: return MIMEType.imageJpeg
            case .heic: return MIMEType(text: "image/heic")
            case .heif: return MIMEType(text: "image/heif")
            case .other: return MIMEType(text: "image/*")
            }
        case let .video(videoType):
            switch videoType {
            case .mov: return MIMEType(text: "video/mov")
            case .mp4: return MIMEType(text: "video/mp4")
            case .other: return MIMEType(text: "video/*")
            }
        case let .audio(audioType):
            switch audioType {
            case .mpeg: return MIMEType.audioMpeg
            case .other: return MIMEType(text: "audio/*")
            }
        case let .document(documentType):
            switch documentType {
            case .pdf: return MIMEType(text: "application/pdf")
            case .other: return MIMEType(text: "application/*")
            }
        }
    }
}
