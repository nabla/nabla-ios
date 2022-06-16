import Foundation

public enum MimeType: Equatable, Hashable {
    case image(MimeType.Image)
    case video(MimeType.Video)
    case audio(MimeType.Audio)
    case document(MimeType.Document)

    public enum Image: String {
        case png = "image/png"
        case jpg = "image/jpeg"
        case heic = "image/heic"
        case heif = "image/heif"
        case other = "image/*"
        
        public static func from(rawValue value: String?) -> MimeType.Image {
            MimeType.Image(rawValue: value ?? "") ?? MimeType.Image.other
        }
    }
    
    public enum Video: String {
        case mov = "video/mov"
        case mp4 = "video/mp4"
        case other = "video/*"
        
        public static func from(rawValue value: String?) -> MimeType.Video {
            MimeType.Video(rawValue: value ?? "") ?? MimeType.Video.other
        }
    }
    
    public enum Audio: String {
        case mpeg = "audio/mpeg"
        case other = "audio/*"
        
        public static func from(rawValue value: String?) -> MimeType.Audio {
            MimeType.Audio(rawValue: value ?? "") ?? MimeType.Audio.other
        }
    }
    
    public enum Document: String {
        case pdf = "application/pdf"
        case other = "application/*"
        
        static func from(rawValue value: String?) -> MimeType.Document {
            MimeType.Document(rawValue: value ?? "") ?? MimeType.Document.other
        }
    }
}
