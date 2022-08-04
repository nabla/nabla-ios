import Foundation

///
/// Callback from Nabla SDK to request new server-made access and refresh tokens.
/// You will typically call your server here and make sure no caching is used:
/// the SDK is only interested in fresh versions each time it calls back.
///
public protocol SessionTokenProvider {
    func provideTokens(forUserId userId: String, completion: @escaping (AuthTokens?) -> Void)
}
