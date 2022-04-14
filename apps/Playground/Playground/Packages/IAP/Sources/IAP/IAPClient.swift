import Foundation
import GoogleSignIn
import UIKit

public enum IAPError: Error {
    case googleError(Error)
    case missingUser
}

public class IAPClient {
    // MARK: - Public
    
    public struct Configuration {
        let clientId: String
        let serverId: String
        
        public init(
            clientId: String,
            serverId: String
        ) {
            self.clientId = clientId
            self.serverId = serverId
        }
    }
    
    public static func open(url: URL) -> Bool {
        GIDSignIn.sharedInstance.handle(url)
    }
    
    // MARK: - Internal
    
    func authenticate(from viewController: UIViewController, _ completion: @escaping (Result<String, IAPError>) -> Void) {
        restoreState { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.signIn(from: viewController, completion)
            case let .success(user):
                completion(.success(user))
            }
        }
    }
    
    init(
        configuration: Configuration
    ) {
        self.configuration = configuration
    }
    
    // MARK: - Private
    
    private let configuration: Configuration
    
    private func restoreState(_ completion: @escaping (Result<String, IAPError>) -> Void) {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                completion(.failure(.googleError(error)))
                return
            }
            if let token = user?.authentication.idToken {
                completion(.success(token))
                return
            }
            completion(.failure(.missingUser))
        }
    }
    
    private func signIn(from viewController: UIViewController, _ completion: @escaping (Result<String, IAPError>) -> Void) {
        let config = GIDConfiguration(
            clientID: configuration.clientId,
            serverClientID: configuration.serverId
        )
        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewController) { user, error in
            if let error = error {
                completion(.failure(.googleError(error)))
                return
            }
            if let token = user?.authentication.idToken {
                completion(.success(token))
                return
            }
            completion(.failure(.missingUser))
        }
    }
}
