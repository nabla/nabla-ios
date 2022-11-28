import Foundation

public struct JSONResponse {
    let data: Data
    let request: URLRequest?
    let response: HTTPURLResponse?
}
