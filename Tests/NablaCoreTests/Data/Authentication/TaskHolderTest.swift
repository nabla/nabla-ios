import Foundation
@testable import NablaCore
import XCTest

class TaskHolderTest: XCTestCase {
    func testFirstTaskIsSharedWhileItRuns() async throws {
        // GIVEN
        let sut = TaskHolder<Int>()
        
        // WHEN
        async let call1 = sut.run {
            try await Task.sleep(nanoseconds: 50000000) // 50 milliseconds
            return 1
        }
        async let call2 = sut.run {
            2
        }
        
        // THEN
        let result1 = try await call1
        let result2 = try await call2
        XCTAssertEqual(result1, 1)
        XCTAssertEqual(result2, 1)
    }
    
    func testFirstTaskIsReleasedAfterItCompletes() async throws {
        // GIVEN
        let sut = TaskHolder<Int>()
        
        // WHEN
        let result1 = try await sut.run {
            1
        }
        let result2 = try await sut.run {
            2
        }
        
        // THEN
        XCTAssertEqual(result1, 1)
        XCTAssertEqual(result2, 2)
    }
}
