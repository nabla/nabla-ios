import Foundation

public struct JSONResponse {
    let result: Result<Data, HTTPError>
    let request: URLRequest?
    let response: HTTPURLResponse?
}
