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

    func test_provider_fullNameWithPrefix_withoutPrefix() {
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

    func test_provider_fullNameWithPrefix_withPrefix() {
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

    func test_provider_abbreviatedNameWithPrefix_withoutPrefix() {
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

    func test_provider_abbreviatedNameWithPrefix_withPrefix() {
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

    func test_provider_initials() {
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

    func test_provider_initials_emptyFirstNameLastName() {
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

    func test_maybeProvider_deleted_fullNameWithPrefix() {
        // Given
        let maybeProvider = MaybeProvider.deletedProvider
        // When
        let result = ProviderNameComponentsFormatter(style: .fullNameWithPrefix).string(from: .init(maybeProvider))
        // Then
        XCTAssertEqual(NablaMessagingUI.L10n.providerDeletedName, result)
    }

    func test_maybeProvider_deleted_abbreviatedNameWithPrefix() {
        // Given
        let maybeProvider = MaybeProvider.deletedProvider
        // When
        let result = ProviderNameComponentsFormatter(style: .abbreviatedNameWithPrefix).string(from: .init(maybeProvider))
        // Then
        XCTAssertEqual(NablaMessagingUI.L10n.providerDeletedName, result)
    }

    func test_maybeProvider_deleted_initials() {
        // Given
        let maybeProvider = MaybeProvider.deletedProvider
        // When
        let result = ProviderNameComponentsFormatter(style: .initials).string(from: .init(maybeProvider))
        // Then
        XCTRequireEqual("", result)
    }

    // MARK: case provider

    func test_maybeProvider_provider_fullNameWithPrefix() {
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

    func test_maybeProvider_provider_abbreviatedNameWithPrefix() {
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

    func test_maybeProvider_provider_initials() {
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
