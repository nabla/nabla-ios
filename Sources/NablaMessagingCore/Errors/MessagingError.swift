import Foundation
import NablaCore

public class MessagingError: NablaError {}

public class InvalidMessageError: MessagingError {}

public class ProviderNotFoundError: MessagingError {
    public let message: String?
    
    init(message: String?) {
        self.message = message
        super.init()
    }
}

public class ProviderMissingPermissionError: MessagingError {
    public let message: String?
    
    init(message: String?) {
        self.message = message
        super.init()
    }
}

public class MessageNotFoundError: MessagingError {}

public class CanNotReadFileDataError: MessagingError {}
