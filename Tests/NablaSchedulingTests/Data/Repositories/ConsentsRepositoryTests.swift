import Combine
import NablaCore
@testable import NablaScheduling
import SnapshotTesting
import XCTest

final class ConsentsRepositoryTests: XCTestCase {
    private var sut: ConsentsRepositoryImpl!
    
    private var remoteDataSource: ConsentsRemoteDataSourceMock!

    override func setUp() {
        remoteDataSource = .init()

        remoteDataSource.given(
            .watchConsents(
                willReturn: Just(
                    RemoteConsents(
                        firstConsentHtml: "firstConsentHtml",
                        secondConsentHtml: "secondConsentHtml",
                        physicalFirstConsentHtml: "physicalFirstConsentHtml",
                        physicalSecondConsentHtml: "physicalSecondConsentHtml"
                    )
                )
                .setFailureType(to: GQLError.self)
                .eraseToAnyPublisher()
            )
        )

        sut = .init(remoteDataSource: remoteDataSource)
    }

    func testFetchPhysicalConsents() {
        // GIVEN
        let watchExpectation = expectation(description: "Watch Consents")
        // WHEN
        let watcher = sut.watchConsents(location: .physical)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { consents in
                    XCTAssertEqual(consents.firstConsentHtml, "physicalFirstConsentHtml")
                    XCTAssertEqual(consents.secondConsentHtml, "physicalSecondConsentHtml")
                    watchExpectation.fulfill()
                }
            )
        // THEN
        waitForExpectations(timeout: 0.5)
        XCTAssertNotNil(watcher)
    }
    
    func testFetchRemoteConsents() {
        // GIVEN
        let watchExpectation = expectation(description: "Watch Consents")
        // WHEN
        let watcher = sut.watchConsents(location: .remote)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { consents in
                    XCTAssertEqual(consents.firstConsentHtml, "firstConsentHtml")
                    XCTAssertEqual(consents.secondConsentHtml, "secondConsentHtml")
                    watchExpectation.fulfill()
                }
            )
        // THEN
        waitForExpectations(timeout: 0.5)
        XCTAssertNotNil(watcher)
    }
}
