import NablaCore
@testable import NablaScheduling
import SnapshotTesting
import XCTest

final class ConsentsRepositoryTests: XCTestCase {
    private var sut: ConsentsRepositoryImpl!
    
    private var remoteDataSource: ConsentsRemoteDataSourceMock!

    override func setUp() {
        remoteDataSource = .init()
        
        sut = .init(remoteDataSource: remoteDataSource)
        
        remoteDataSource.given(.fetchConsents(willReturn: .init(
            firstConsentHtml: "firstConsentHtml",
            secondConsentHtml: "secondConsentHtml",
            physicalFirstConsentHtml: "physicalFirstConsentHtml",
            physicalSecondConsentHtml: "physicalSecondConsentHtml"
        )))
    }

    func testFetchPhysicalConsents() async throws {
        // GIVEN
        // WHEN
        let consents = try await sut.fetchConsents(location: .physical)
        // THEN
        XCTAssertEqual(consents.firstConsentHtml, "physicalFirstConsentHtml")
        XCTAssertEqual(consents.secondConsentHtml, "physicalSecondConsentHtml")
    }
    
    func testFetchRemoteConsents() async throws {
        // GIVEN
        // WHEN
        let consents = try await sut.fetchConsents(location: .remote)
        // THEN
        XCTAssertEqual(consents.firstConsentHtml, "firstConsentHtml")
        XCTAssertEqual(consents.secondConsentHtml, "secondConsentHtml")
    }
}
