import Foundation
import NablaCore
import NablaUtils
import Networking

protocol UserLobbyPresenterDelegate: AnyObject {
    func userLobbyPresenter(_ presenter: UserLobbyPresenter, didFetch tokens: Tokens, for user: User)
}

protocol UserLobbyViewContract: AnyObject {
    func set(error: String?)
    func set(loading: Bool)
}

class UserLobbyPresenter {
    // MARK: - Internal
    
    func start() {
        authenticate()
    }
    
    func userDidTapRetryButton() {
        authenticate()
    }
    
    init(
        user: User,
        view: UserLobbyViewContract,
        delegate: UserLobbyPresenterDelegate
    ) {
        self.user = user
        self.view = view
        self.delegate = delegate
    }
    
    // MARK: - Private
    
    @Inject private var httpManager: HTTPManager
    
    private let user: User
    
    private weak var view: UserLobbyViewContract?
    private weak var delegate: UserLobbyPresenterDelegate?
    
    private func set(error: Error) {
        DispatchQueue.main.async { [view] in
            view?.set(error: error.localizedDescription)
            view?.set(loading: false)
        }
    }
    
    private func set(loading _: Bool) {
        DispatchQueue.main.async { [view] in
            view?.set(error: nil)
            view?.set(loading: true)
        }
    }
    
    private func authenticate() {
        view?.set(error: nil)
        view?.set(loading: true)
        
        mockServerAuthentication(user: user) { [weak self, user] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                self.set(error: error)
            case let .success(tokens):
                Self.authenticateSDK(user: user, tokens: tokens) { result in
                    switch result {
                    case let .failure(error):
                        self.set(error: error)
                    case .success:
                        DispatchQueue.main.async {
                            self.delegate?.userLobbyPresenter(self, didFetch: tokens, for: self.user)
                        }
                    }
                }
            }
        }
    }
    
    private func mockServerAuthentication(user: User, completion: @escaping (Result<Tokens, Error>) -> Void) {
        let request = AuthenticateEndpoint.request(userId: user.uuid)
        httpManager.fetch(AuthenticateEndpoint.Response.self, associatedTo: request) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(response):
                let tokens = Tokens(
                    accessToken: response.accessToken,
                    refreshToken: response.refreshToken
                )
                completion(.success(tokens))
            }
        }
    }
    
    private static func authenticateSDK(user: User, tokens: Tokens, completion: @escaping (Result<Void, Error>) -> Void) {
        NablaClient.shared.authenticate(
            userID: user.uuid,
            provider: NablaTokensHolder(tokens: tokens)
        ) { result in
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case .success:
                completion(.success(()))
            }
        }
    }
}

private class NablaTokensHolder: NablaAuthenticationProvider {
    let tokens: NablaCore.Tokens
    
    init(tokens: Tokens) {
        self.tokens = .init(
            accessToken: tokens.accessToken,
            refreshToken: tokens.refreshToken
        )
    }
    
    func provideTokens(completion: (NablaCore.Tokens?) -> Void) {
        completion(tokens)
    }
}
