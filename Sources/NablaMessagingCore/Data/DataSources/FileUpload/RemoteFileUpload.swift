import Foundation
import NablaCore

struct RemoteFileUpload {
    let fileName: String
    let content: MediaContent
    let mimeType: MimeType
    let purpose: Purpose
    
    enum Purpose: String {
        case message = "MESSAGE"
    }
}
