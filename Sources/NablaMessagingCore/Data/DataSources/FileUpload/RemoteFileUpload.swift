import Foundation

struct RemoteFileUpload {
    let fileName: String
    let fileUrl: URL
    let mimeType: MimeType
    let purpose: Purpose
    
    enum Purpose: String {
        case message = "MESSAGE"
    }
}
