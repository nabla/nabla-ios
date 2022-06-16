import Combine
import Foundation
import MobileCoreServices
import NablaMessagingCore
import Photos
import PhotosUI
import UIKit

final class MediaReader {
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Internal
    
    func readMedia(from info: [UIImagePickerController.InfoKey: Any]) -> Result<Media, ImagePickerError> {
        guard let mediaType = getMediaType(from: info) else {
            return .failure(.unknownAssetType)
        }
        switch mediaType {
        case .image: return readImage(from: info)
        case .video: return readVideo(from: info)
        case .pdf, .audio: return .failure(.invalidType)
        }
    }
    
    func readMedia(from providers: [NSItemProvider], completion: @escaping ([Result<Media, ImagePickerError>]) -> Void) {
        let promises = providers.map { decodeMedia(from: $0) }
        Publishers.MergeMany(promises).collect().sink { result in
            completion(result)
        }.store(in: &subscriptions)
    }
    
    // MARK: - Private
    
    private func decodeMedia(from provider: NSItemProvider) -> Future<Result<Media, ImagePickerError>, Never> {
        Future { promise in
            self.decodeMedia(from: provider) { result in
                promise(Result.success(result))
            }
        }
    }
    
    private func decodeMedia(from provider: NSItemProvider, completion: @escaping (Result<Media, ImagePickerError>) -> Void) {
        if provider.canLoadObject(ofClass: UIImage.self) {
            readImage(from: provider, completion: completion)
        } else {
            if #available(iOS 14, *) {
                readVideo(from: provider, completion: completion)
            } else {
                completion(.failure(.iOS14Only))
            }
        }
    }
    
    private func readImage(from info: [UIImagePickerController.InfoKey: Any]) -> Result<Media, ImagePickerError> {
        let fileUrl: URL
        if let assetUrl = info[.mediaURL] as? URL {
            fileUrl = assetUrl
        } else if let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage {
            guard let jpegData = image.jpegData(compressionQuality: 0.9) else {
                return .failure(.failedToCreateJpegData)
            }
            let fileName = getFileName(from: info) ?? makeRandomFileName(extension: "jpg")
            guard let temporaryFileUrl = saveDataToTemporaryFile(jpegData, fileName: fileName) else {
                return .failure(.failedToSaveTemporaryFile)
            }
            fileUrl = temporaryFileUrl
        } else {
            return .failure(.missingAssetData)
        }
        let media = Media(
            type: .image,
            fileName: fileUrl.lastPathComponent,
            fileUrl: fileUrl,
            thumbnailUrl: fileUrl,
            mimeType: .image(.from(rawValue: MediaReader.mimeType(for: fileUrl.path)))
        )
        return .success(media)
    }
    
    private func readImage(from provider: NSItemProvider, completion: @escaping (Result<Media, ImagePickerError>) -> Void) {
        provider.loadObject(ofClass: UIImage.self) { object, _ in
            if let image = object as? UIImage {
                guard let jpegData = image.jpegData(compressionQuality: 0.9) else {
                    completion(.failure(.failedToCreateJpegData))
                    return
                }
                
                let fileName = provider.suggestedName ?? self.makeRandomFileName(extension: "jpg")
                
                guard let temporaryFileUrl = self.saveDataToTemporaryFile(jpegData, fileName: fileName) else {
                    completion(.failure(.failedToSaveTemporaryFile))
                    return
                }
                
                let media = Media(
                    type: .image,
                    fileName: fileName,
                    fileUrl: temporaryFileUrl,
                    thumbnailUrl: temporaryFileUrl,
                    mimeType: .image(.jpg)
                )
                completion(.success(media))
            }
        }
    }
    
    private func readVideo(from info: [UIImagePickerController.InfoKey: Any]) -> Result<Media, ImagePickerError> {
        let fileUrl: URL
        if let assetUrl = info[.mediaURL] as? URL {
            fileUrl = assetUrl
        } else {
            return .failure(.missingAssetData)
        }
        let media = Media(
            type: .video,
            fileName: fileUrl.lastPathComponent,
            fileUrl: fileUrl,
            thumbnailUrl: fileUrl,
            mimeType: .video(.mov) // The videos are always compressed as .mov files by UIImagePickerController when selected
        )
        return .success(media)
    }
    
    @available(iOS 14, *)
    private func readVideo(from provider: NSItemProvider, completion: @escaping (Result<Media, ImagePickerError>) -> Void) {
        provider.loadInPlaceFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, _, _ in
            guard let url = url else {
                completion(.failure(.missingAssetData))
                return
            }
            
            let media = Media(
                type: .video,
                fileName: url.lastPathComponent,
                fileUrl: url,
                thumbnailUrl: url,
                mimeType: .video(.from(rawValue: MediaReader.mimeType(for: url.path)))
            )
            completion(.success(media))
        }
    }
    
    // Taken from https://gist.github.com/robertmryan/62dcb3a7c67091d7e2b9aaaea8b55634
    private static func mimeType(for path: String) -> String? {
        let url = URL(fileURLWithPath: path)
        let pathExtension = url.pathExtension
        
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return nil
    }
    
    private func readData(at url: URL) -> Data? {
        try? Data(contentsOf: url)
    }
    
    private func saveDataToTemporaryFile(_ data: Data, fileName: String) -> URL? {
        let manager = FileManager.default
        let url = manager.temporaryDirectory
            .appendingPathComponent(fileName)
        guard manager.createFile(atPath: url.path, contents: data, attributes: nil) else {
            return nil
        }
        return url
    }
    
    private func getMediaType(from info: [UIImagePickerController.InfoKey: Any]) -> MediaType? {
        guard let rawValue = info[.mediaType] as? String else { return nil }
        return MediaType.allCases.first { mediaType in
            mediaType.utTypes.contains(rawValue)
        }
    }
    
    private func getMediaType(from provider: NSItemProvider) -> MediaType? {
        if provider.canLoadObject(ofClass: UIImage.self) {
            return .image
        }
        return nil
    }
    
    private func getFileName(from info: [UIImagePickerController.InfoKey: Any]) -> String? {
        guard
            let asset = info[.phAsset] as? PHAsset,
            let resource = PHAssetResource.assetResources(for: asset).first
        else { return nil }
        return resource.originalFilename
    }
    
    private func makeRandomFileName(extension: String) -> String {
        UUID().uuidString + "." + `extension`
    }
}

private extension NSItemProvider {
    var mediaType: MediaType? {
        if canLoadObject(ofClass: UIImage.self) {
            return .image
        }
        return nil
    }
}
