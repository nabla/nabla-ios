@testable import NablaCore
@testable import NablaMessagingCore
import XCTest

class NotifierTests: XCTestCase {
    func testDoesNotEmitInitialValue() {
        // GIVEN
        let expectation = expectation(description: "Notifier.observe should not be called")
        expectation.isInverted = true
        let sut = Notifier<String>(id: "id")
        // WHEN
        let cancellable = sut.observe { _ in
            expectation.fulfill()
        }
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(cancellable)
    }

    func testObserveReceivesNotifiedValues() {
        // GIVEN
        let expectation = expectation(description: "Notifier.observe should get called")
        let sut = Notifier<String>(id: "id")
        let cancellable = sut.observe { value in
            XCTAssertEqual(value, "Hello")
            expectation.fulfill()
        }
        // WHEN
        sut.notify(value: "Hello")
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(cancellable)
    }
    
    func testMultipleNotifierWithTheSameIdentifierShareObservers() {
        // GIVEN
        let sut1 = Notifier<String>(id: "id")
        let sut2 = Notifier<String>(id: "id")
        
        let expectation1 = expectation(description: "Notifier.observe shout get called")
        let cancellable1 = sut1.observe { value in
            XCTAssertEqual(value, "Hello")
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Notifier.observe shout get called")
        let cancellable2 = sut2.observe { value in
            XCTAssertEqual(value, "Hello")
            expectation2.fulfill()
        }
        
        // WHEN
        sut1.notify(value: "Hello")
        
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(cancellable1)
        XCTAssertNotNil(cancellable2)
    }
    
    func testMultipleNotifierWithDifferentIdentifiersDontShareObservers() {
        // GIVEN
        let sut1 = Notifier<String>(id: "id1")
        let sut2 = Notifier<String>(id: "id2")
        
        let expectation1 = expectation(description: "Notifier.observe shout get called")
        let cancellable1 = sut1.observe { value in
            XCTAssertEqual(value, "Hello")
            expectation1.fulfill()
        }
        
        let expectation2 = expectation(description: "Notifier.observe shout not get called")
        expectation2.isInverted = true
        let cancellable2 = sut2.observe { _ in
            expectation2.fulfill()
        }
        
        // WHEN
        sut1.notify(value: "Hello")
        
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(cancellable1)
        XCTAssertNotNil(cancellable2)
    }
    
    func testObserverIsCancelledOnDeinit() {
        // GIVEN
        let sut = Notifier<String>(id: "id")
        let expectation = expectation(description: "Notifier.observe should not get called")
        expectation.isInverted = true
        // WHEN
        var cancellable: NablaCancellable? = sut.observe { _ in
            expectation.fulfill()
        }
        cancellable = nil
        sut.notify(value: "Hello")
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertNil(cancellable)
    }
}
