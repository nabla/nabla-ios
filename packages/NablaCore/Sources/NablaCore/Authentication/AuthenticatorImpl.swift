import Foundation
import NablaUtils

class AuthenticatorImpl: Authenticator {
    // MARK: - Internal

    func authenticate(
        userID: UUID,
        provider: NablaAuthenticationProvider,
        completion: (Result<Void, AuthenticationError>) -> Void
    ) {
        requireTokens(provider: provider) { [weak self] result in
            switch result {
            case let .success(tokens):
                self?.session = Session(userID: userID, tokens: tokens)
                self?.provider = provider
                completion(.success(()))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func logOut() {
        session = nil
        provider = nil
    }

    func getAccessToken(completion: @escaping (Result<AuthenticationState, AuthenticationError>) -> Void) {
        guard let session = session else {
            completion(.success(.unauthenticated))
            return
        }

        if !isExpired(session.tokens.accessToken) {
            completion(.success(.authenticated(accessToken: session.tokens.accessToken)))
            return
        }

        let task = makeOrReuseRenewTokensTask(tokens: session.tokens)
        task.addOnComplete { [session] result in
            switch result {
            case let .success(tokens):
                session.tokens = tokens
                completion(.success(.authenticated(accessToken: tokens.accessToken)))
            case let .failure(error):
                completion(.failure(error))
            }
        }
        task.resume()
    }

    // MARK: - Private

    private var provider: NablaAuthenticationProvider?
    private var session: Session?
    private var renewTask: SharedTask<Result<Tokens, AuthenticationError>>?

    private func isExpired(_ token: String) -> Bool {
        do {
            let jwt = try decode(jwt: token)
            guard let expiresAt = jwt.expiresAt else { return false }
            return expiresAt.isPast
        } catch {
            return true
        }
    }

    private func makeOrReuseRenewTokensTask(tokens: Tokens) -> SharedTask<Result<Tokens, AuthenticationError>> {
        if let existing = renewTask {
            return existing
        }
        let renewTask = SharedTask<Result<Tokens, AuthenticationError>> { [weak self] completion in
            guard let self = self else { return }
            self.renewTokens(tokens) { result in
                completion(result)
                self.renewTask = nil
            }
        }
        self.renewTask = renewTask
        return renewTask
    }

    private func renewTokens(_ tokens: Tokens, completion: (Result<Tokens, AuthenticationError>) -> Void) {
        if !isExpired(tokens.refreshToken) {
            fetchTokens(refreshToken: tokens.refreshToken, completion: completion)
            return
        }

        guard let provider = provider else {
            completion(.failure(.missingAuthenticationProvider))
            return
        }
        requireTokens(provider: provider, completion: completion)
    }

    private func requireTokens(provider: NablaAuthenticationProvider, completion: (Result<Tokens, AuthenticationError>) -> Void) {
        provider.provideTokens { token in
            if let token = token {
                completion(.success(token))
            } else {
                completion(.failure(.authenticationProviderFailedToProvideTokens))
            }
        }
    }

    private func fetchTokens(refreshToken _: String, completion _: (Result<Tokens, AuthenticationError>) -> Void) {
        // TODO: HttpManager
    }
}
