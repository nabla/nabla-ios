import Foundation
import NablaCore
@testable import NablaMessagingCore
@testable import NablaMessagingUI
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
            avatarURL: nil,
            prefix: prefix,
            firstName: firstName,
            lastName: lastName
        )
    }

    // MARK: - Provider

    func testProviderFullNameWithPrefixNil() {
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

    func testProviderFullNameWithPrefixNonNil() {
        // Given
        let provider = createProvider(
            prefix: prefix,
            firstName: firstName,
            lastName: lastName
        )
        // When
        let result = ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(provider))
        // Then
        XCTAssertEqual("\(prefix) \(firstName) \(lastName)", result)
    }

    func testProviderAbbreviatedNameWithPrefixNil() {
        // Given
        let provider = createProvider(
            prefix: nil,
            firstName: firstName,
            lastName: lastName
        )
        // When
        let result = ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(provider))
        // Then
        XCTAssertEqual("\(firstName) \(lastName)", result)
    }

    func testProviderAbbreviatedNameWithPrefixNonNil() {
        // Given
        let provider = createProvider(
            prefix: prefix,
            firstName: firstName,
            lastName: lastName
        )
        // When
        let result = ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(provider))
        // Then
        XCTAssertEqual("\(prefix) \(lastName)", result)
    }

    func testProviderInitials() {
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

    func testProviderInitialsEmptyFirstNameLastName() {
        // Given
        let provider = createProvider(
            prefix: nil,
            firstName: "",
            lastName: ""
        )
        // When
        let result = ProviderNameComponentsFormatter(style: .initials).string(from: .init(provider))
        // Then
        XCTAssertEqual("", result)
    }

    // MARK: - MaybeProvider

    // MARK: case deletedProvider

    func testMaybeProviderDeletedFullNameWithPrefix() {
        // Given
        let maybeProvider = MaybeProvider.deletedProvider
        // When
        let result = ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(maybeProvider))
        // Then
        XCTAssertEqual(NablaMessagingUI.L10n.providerDeletedName, result)
    }

    func testMaybeProviderDeletedAbbreviatedNameWithPrefix() {
        // Given
        let maybeProvider = MaybeProvider.deletedProvider
        // When
        let result = ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(maybeProvider))
        // Then
        XCTAssertEqual(NablaMessagingUI.L10n.providerDeletedName, result)
    }

    func testMaybeProviderDeletedInitials() {
        // Given
        let maybeProvider = MaybeProvider.deletedProvider
        // When
        let result = ProviderNameComponentsFormatter(style: .initials).string(from: .init(maybeProvider))
        // Then
        XCTRequireEqual("", result)
    }

    // MARK: case provider

    func testMaybeProviderProviderFullNameWithPrefix() {
        // Given
        let provider = createProvider(prefix: prefix, firstName: firstName, lastName: lastName)
        let maybeProvider = MaybeProvider.provider(provider)
        // When
        let result = ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(maybeProvider))
        // Then
        XCTAssertEqual(
            ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(provider)),
            result
        )
    }

    func testMaybeProviderProviderAbbreviatedNameWithPrefix() {
        // Given
        let provider = createProvider(prefix: prefix, firstName: firstName, lastName: lastName)
        let maybeProvider = MaybeProvider.provider(provider)
        // When
        let result = ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(maybeProvider))
        // Then
        XCTAssertEqual(
            ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(provider)),
            result
        )
    }

    func testMaybeProviderProviderInitials() {
        // Given
        let provider = createProvider(prefix: prefix, firstName: firstName, lastName: lastName)
        let maybeProvider = MaybeProvider.provider(provider)
        // When
        let result = ProviderNameComponentsFormatter(style: .initials).string(from: .init(maybeProvider))
        // Then
        XCTAssertEqual(
            ProviderNameComponentsFormatter(style: .initials).string(from: .init(provider)),
            result
        )
    }
}
