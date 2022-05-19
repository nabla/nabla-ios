import XCTest

public extension XCTestCase {
    func XCTRequire<T>(_ value: Any, toBe expectedType: T.Type, file: StaticString = #filePath, line: UInt = #line) -> T {
        let backup = continueAfterFailure
        continueAfterFailure = false
        defer { continueAfterFailure = backup }
        
        guard let typeSafeValue = value as? T else {
            let message = "XCTRequire failed: (\"\(type(of: value))\") is not of type (\"\(expectedType)\")"
            XCTFail(message, file: file, line: line)
            fatalError(message)
        }
        return typeSafeValue
    }

    func XCTRequireEqual<T>(
        _ expression1: @autoclosure () throws -> T,
        _ expression2: @autoclosure () throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line
    ) rethrows where T: Equatable {
        let backup = continueAfterFailure
        continueAfterFailure = false
        defer { continueAfterFailure = backup }
        
        XCTAssertEqual(try expression1(), try expression2(), message(), file: file, line: line)
    }
}
