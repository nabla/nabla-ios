import Foundation

public protocol MessagingModule: Module {
    func makeClient(container: CoreContainer) -> MessagingClient
}

public protocol MessagingClient {}
