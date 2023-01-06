import Combine
@testable import NablaCore
@testable import NablaMessagingCore
import XCTest

class TransientUUIDTests: XCTestCase {
    func testCreatedFromLocalIdAndNilRemoteId() {
        // GIVEN
        let localId = UUID()
        // WHEN
        let sut = TransientUUID(localId: localId, remoteId: nil)
        // THEN
        XCTAssertEqual(sut.localId, localId)
        XCTAssertNil(sut.remoteId)
    }
    
    func testCreatedFromLocalIdAndSomeRemoteId() {
        // GIVEN
        let localId = UUID()
        let remoteId = UUID()
        // WHEN
        let sut = TransientUUID(localId: localId, remoteId: remoteId)
        // THEN
        XCTAssertEqual(sut.localId, localId)
        XCTAssertEqual(sut.remoteId, remoteId)
    }
    
    func testCreatedFromRemoteId() {
        // GIVEN
        let remoteId = UUID()
        // WHEN
        let sut = TransientUUID(remoteId: remoteId)
        // THEN
        XCTAssertEqual(sut.localId, remoteId)
        XCTAssertEqual(sut.remoteId, remoteId)
    }
    
    func testSetRemoteIdChangesTheRemoteId() {
        // GIVEN
        let localId = UUID()
        let sut = TransientUUID(localId: localId, remoteId: nil)
        // WHEN
        let remoteId = UUID()
        sut.set(remoteId: remoteId)
        // THEN
        XCTAssertEqual(sut.localId, localId)
        XCTAssertEqual(sut.remoteId, remoteId)
    }
    
    func testSetRemoteIdTriggersObserveRemoteId() {
        // GIVEN
        let sut = TransientUUID(localId: UUID(), remoteId: nil)
        let futurRemoteId = UUID()
        let expection = expectation(description: "TransientUUID.observeRemoteId should get called")
        let cancellable = sut.observeRemoteId { remoteId in
            XCTAssertEqual(remoteId, futurRemoteId)
            expection.fulfill()
        }
        // WHEN
        sut.set(remoteId: futurRemoteId)
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertNotNil(cancellable)
    }
    
    func testMultipleInstancesWithTheSameLocalIdShareRemoteIdObserver() {
        // GIVEN
        let localId = UUID()
        let sut1 = TransientUUID(localId: localId, remoteId: nil)
        let sut2 = TransientUUID(localId: localId, remoteId: nil)
        
        let futurRemoteId = UUID()
        
        let expection1 = expectation(description: "TransientUUID.observeRemoteId should get called")
        let cancellable1 = sut1.observeRemoteId { remoteId in
            XCTAssertEqual(remoteId, futurRemoteId)
            expection1.fulfill()
        }
        
        let expection2 = expectation(description: "TransientUUID.observeRemoteId should get called")
        let cancellable2 = sut2.observeRemoteId { remoteId in
            XCTAssertEqual(remoteId, futurRemoteId)
            expection2.fulfill()
        }
        // WHEN
        sut1.set(remoteId: futurRemoteId)
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertEqual(sut1.remoteId, futurRemoteId)
        XCTAssertEqual(sut2.remoteId, futurRemoteId)
        XCTAssertNotNil(cancellable1)
        XCTAssertNotNil(cancellable2)
    }
    
    func testMultipleInstancesWithTheSameLocalIdShareRemoteIdEvenWithoutObserver() {
        // GIVEN
        let localId = UUID()
        let sut1 = TransientUUID(localId: localId, remoteId: nil)
        let sut2 = TransientUUID(localId: localId, remoteId: nil)
        let futurRemoteId = UUID()
        // WHEN
        sut1.set(remoteId: futurRemoteId)
        // THEN
        XCTAssertEqual(sut1.remoteId, futurRemoteId)
        XCTAssertEqual(sut2.remoteId, futurRemoteId)
    }
    
    func testMultipleInstancesWithDifferentLocalIdDontShareRemoteIdObserver() {
        // GIVEN
        let sut1 = TransientUUID(localId: UUID(), remoteId: nil)
        let sut2 = TransientUUID(localId: UUID(), remoteId: nil)
        
        let futurRemoteId = UUID()
        
        let expection1 = expectation(description: "TransientUUID.observeRemoteId should get called")
        let cancellable1 = sut1.observeRemoteId { remoteId in
            XCTAssertEqual(remoteId, futurRemoteId)
            expection1.fulfill()
        }
        
        let expection2 = expectation(description: "TransientUUID.observeRemoteId should get called")
        expection2.isInverted = true
        let cancellable2 = sut2.observeRemoteId { _ in
            expection2.fulfill()
        }
        // WHEN
        sut1.set(remoteId: futurRemoteId)
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertEqual(sut1.remoteId, futurRemoteId)
        XCTAssertNil(sut2.remoteId)
        XCTAssertNotNil(cancellable1)
        XCTAssertNotNil(cancellable2)
    }
    
    func testObserverIsCancelledOnDeinit() {
        // GIVEN
        let sut = TransientUUID(localId: UUID(), remoteId: nil)
        let expectation = expectation(description: "TransientUUID.observeRemoteId should not get called")
        expectation.isInverted = true
        // WHEN
        var cancellable: AnyCancellable? = sut.observeRemoteId { _ in
            expectation.fulfill()
        }
        cancellable = nil
        sut.set(remoteId: UUID())
        // THEN
        waitForExpectations(timeout: 0.1)
        XCTAssertNil(cancellable)
    }
}
