import Foundation
import NablaCore
@testable import NablaScheduling
import XCTest

final class ProviderNameFormatterTests: XCTestCase {
    private let prefix = "Dr"
    private let firstName = "FirstName"
    private let lastName = "LastName"

    private func createProvider(
        prefix: String?,
        firstName: String,
        lastName: String
    ) -> Provider {
        .init(
            id: .init(),
            prefix: prefix,
            firstName: firstName,
            lastName: lastName,
            title: nil,
            avatarUrl: nil
        )
    }

    func testFormatNameInitials() {
        // Given
        let provider = createProvider(
            prefix: nil,
            firstName: firstName,
            lastName: lastName
        )
        // When
        let result = ProviderNameComponentsFormatter(style: .initials).string(from: .init(provider))
        // Then
        XCTAssertEqual("FL", result)
    }

    func testFormatNameFullNameWithPrefixNil() {
        // Given
        let provider = createProvider(
            prefix: nil,
            firstName: firstName,
            lastName: lastName
        )
        // When
        let result = ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(provider))
        // Then
        XCTAssertEqual("\(firstName) \(lastName)", result)
    }

    func testFormatNameFullNameWithPrefixNonNil() {
        // Given
        let provider = createProvider(
            prefix: "Dr",
            firstName: firstName,
            lastName: lastName
        )
        // When
        let result = ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(provider))
        // Then
        XCTAssertEqual("\(prefix) \(firstName) \(lastName)", result)
    }
}
