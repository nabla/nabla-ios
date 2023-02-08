import Combine
@testable import NablaCore
import XCTest

final class MapResultTests: XCTestCase {
    func testResultMapForwardsErrors() throws {
        // GIVEN
        let publisher = Just(())
        let receivedCompletion = expectation(description: "Received completion")
        
        let sut = publisher
            .setFailureType(to: DummyError.self)
            .nabla.resultMap { _ -> Result<Void, DummyError> in
                .failure(DummyError())
            }
        
        // WHEN
        let sink = sut.sink { completion in
            switch completion {
            case .failure:
                receivedCompletion.fulfill()
            case .finished:
                XCTFail("Should complete with error")
            }
        } receiveValue: { _ in
            XCTFail("Should not receive any value")
        }

        // THEN
        waitForExpectations(timeout: 0.1)
        sink.cancel()
    }
    
    func testResultMapCancelsUpstream() throws {
        // GIVEN
        let upstreamWasCanceled = expectation(description: "Upstream publisher was canceled")
        let receivedCompletion = expectation(description: "Received completion")
        
        var emittedValues = [Int]()
        var receivedValues = [Int]()
        let publisher = [0, 1, 2, 3].publisher
            .handleEvents(
                receiveOutput: { output in
                    emittedValues.append(output)
                },
                receiveCancel: {
                    upstreamWasCanceled.fulfill()
                }
            )
            
        let sut = publisher
            .setFailureType(to: DummyError.self)
            .nabla.resultMap { input -> Result<Int, DummyError> in
                if input < 2 {
                    return .success(input)
                } else {
                    return .failure(DummyError())
                }
            }
        
        // WHEN
        let sink = sut.sink { completion in
            switch completion {
            case .failure:
                receivedCompletion.fulfill()
            case .finished:
                XCTFail("Should complete with error")
            }
        } receiveValue: { value in
            receivedValues.append(value)
        }

        // THEN
        waitForExpectations(timeout: 0.1)
        sink.cancel()
        XCTAssertEqual(emittedValues, [0, 1, 2]) // "2" is emitted...
        XCTAssertEqual(receivedValues, [0, 1]) // ...but not received because it is the one causing the completion of the `mapResult`
    }
}

private struct DummyError: Error {}
