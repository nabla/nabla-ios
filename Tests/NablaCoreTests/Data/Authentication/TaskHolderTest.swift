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
    
    func testFirstTaskIsSharedWhileItRunsFromDifferentThreads() {
        // GIVEN
        let sut = TaskHolder<Int>()
        let queue1 = DispatchQueue(label: "com.nabla.tests.queue1", qos: .background)
        let queue2 = DispatchQueue(label: "com.nabla.tests.queue2", qos: .background)
        let result1 = Reference<Int?>(value: nil)
        let result2 = Reference<Int?>(value: nil)
        let expectation1 = expectation(description: "Queue 1 did complete")
        let expectation2 = expectation(description: "Queue 2 did complete")

        // WHEN
        queue1.async { // Start immediately...
            Task {
                result1.value = try await sut.run {
                    try await Task.sleep(nanoseconds: 100000000) // ... and wait 100 milliseconds
                    return 1
                }
                expectation1.fulfill()
            }
        }

        queue2.asyncAfter(deadline: .now() + 0.05) { // Wait 50 milliseconds...
            Task {
                result2.value = try await sut.run {
                    2 // ... and return immediately
                }
                expectation2.fulfill()
            }
        }

        // THEN
        waitForExpectations(timeout: 2)
        XCTAssertEqual(result1.value, 1)
        XCTAssertEqual(result2.value, 1)
    }
}

private final class Reference<T> {
    var value: T

    init(value: T) {
        self.value = value
    }
}
