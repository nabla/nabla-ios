import Combine
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

class AppointmentConfirmationViewControllerTests: XCTestCase {
    private var sut: AppointmentConfirmationViewController!
    
    private var viewModel: AppointmentConfirmationViewModelMock!
    private var navigationController: UINavigationController!
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        
        sut = AppointmentConfirmationViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: sut)
        
        viewModel.given(.onChange(willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.onChange(throttle: .any, willReturn: Just(()).eraseToAnyPublisher()))
        
        viewModel.given(
            .provider(getter:
                Provider(
                    id: .init(),
                    prefix: "Mr",
                    firstName: "John",
                    lastName: "Doe",
                    title: "Description",
                    avatarUrl: nil
                )))
        viewModel.given(.appointmentDate(getter: .init(timeIntervalSince1970: 0)))
    }
    
    func testAppointmentConfirmationViewControllerLoadingConsents() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: true))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: nil))
        viewModel.given(.agreesWithFirstConsent(getter: false))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerErrorLoadingConsents() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: ConsentsErrorViewModel(
            message: "An error occurred",
            handler: {}
        )))
        viewModel.given(.consents(getter: nil))
        viewModel.given(.agreesWithFirstConsent(getter: false))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerOnlyFirstConsent() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: ConsentsViewModel(
            firstConsentHtml: NSAttributedString(string: "Only 1"),
            firstConsentContainsLink: false,
            secondConsentHtml: nil,
            secondConsentContainsLink: false
        )))
        viewModel.given(.agreesWithFirstConsent(getter: false))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerOnlySecondConsent() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: ConsentsViewModel(
            firstConsentHtml: nil,
            firstConsentContainsLink: false,
            secondConsentHtml: NSAttributedString(string: "Only 2"),
            secondConsentContainsLink: false
        )))
        viewModel.given(.agreesWithFirstConsent(getter: false))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerWithLinks() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: ConsentsViewModel(
            firstConsentHtml: try? NSAttributedString(
                data: Data("This is a consent with a <a href=\"https://www.google.com/\">link</a>".utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue,
                ],
                documentAttributes: nil
            ),
            firstConsentContainsLink: true,
            secondConsentHtml: try? NSAttributedString(
                data: Data("This is a consent with a <a href=\"https://www.google.com/\">link</a> and another <a href=\"https://www.apple.com/\">second link</a> to test this scenario".utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue,
                ],
                documentAttributes: nil
            ),
            secondConsentContainsLink: true
        )))
        viewModel.given(.agreesWithFirstConsent(getter: true))
        viewModel.given(.agreesWithSecondConsent(getter: true))
        viewModel.given(.canConfirm(getter: true))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }

    func testAppointmentConfirmationViewControllerUnchecked() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: false))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerPartialyChecked() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: true))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerChecked() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: true))
        viewModel.given(.agreesWithSecondConsent(getter: true))
        viewModel.given(.canConfirm(getter: true))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerConfirmLoading() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: true))
        viewModel.given(.agreesWithSecondConsent(getter: true))
        viewModel.given(.canConfirm(getter: true))
        viewModel.given(.isConfirming(getter: true))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerWithoutProviderDescription() {
        // GIVEN
        viewModel.given(
            .provider(getter:
                Provider(
                    id: .init(),
                    prefix: "Mr",
                    firstName: "John",
                    lastName: "Doe",
                    title: nil,
                    avatarUrl: nil
                )))
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: false))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.error(getter: nil))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    private let defaultConsents = ConsentsViewModel(
        firstConsentHtml: NSAttributedString(string: "Please accept this"),
        firstConsentContainsLink: false,
        secondConsentHtml: NSAttributedString(string: "Please accept this also with a longer text and still no link, that would be great. Many thanks."),
        secondConsentContainsLink: false
    )
}
