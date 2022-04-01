@testable import NablaCore
import NablaUtils
import XCTest

final class NablaCoreTests: XCTestCase {
    override func setUp() {
        Resolver.shared.register(type: NablaUtils.self, NablaUtils())
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(0 + 0, 0)
    }
}
