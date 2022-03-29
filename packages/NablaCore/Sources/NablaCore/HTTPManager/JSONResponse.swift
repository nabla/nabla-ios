import Foundation

public struct JSONResponse {
    let result: Result<Data, Error>
    let request: URLRequest?
    let response: HTTPURLResponse?
}
