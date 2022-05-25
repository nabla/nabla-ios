import Foundation
import XCTest

extension XCUIElement {
    @discardableResult
    func waitUntilExists(_ timeout: TimeInterval = 3) -> XCUIElement {
        if exists {
            return self
        }
        let test = XCTestCase()
        test.continueAfterFailure = true
        let predicate = NSPredicate(format: "exists == true")
        let exp = test.expectation(for: predicate, evaluatedWith: self, handler: nil)
        XCTWaiter().wait(for: [exp], timeout: timeout)
        return self
    }
    
    @discardableResult
    func waitUntilExistsAssert(
        _ timeout: TimeInterval = 3,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> XCUIElement {
        let r = waitUntilExists(timeout)
        XCTAssert(r.exists, "Element should exist: \(r)", file: file, line: line)
        return r
    }
}
