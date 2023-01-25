import Combine
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

@MainActor class AppointmentConfirmationViewControllerTests: XCTestCase {
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
        viewModel.given(.caption(getter: "Consultation planned on 1 January 1970 at 01:00"))
        viewModel.given(.captionIcon(getter: .video))
        viewModel.given(.isLoadingConsents(getter: false))
        viewModel.given(.consentsLoadingError(getter: nil))
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: false))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        viewModel.given(.canConfirm(getter: false))
        viewModel.given(.isConfirming(getter: false))
        viewModel.given(.modal(getter: nil))
    }
    
    func testAppointmentConfirmationViewControllerLoadingConsents() {
        // GIVEN
        viewModel.given(.isLoadingConsents(getter: true))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerErrorLoadingConsents() {
        // GIVEN
        viewModel.given(.consentsLoadingError(getter: ConsentsErrorViewModel(
            message: "An error occurred",
            handler: {}
        )))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerOnlyFirstConsent() {
        // GIVEN
        viewModel.given(.consents(getter: ConsentsViewModel(
            firstConsentHtml: NSAttributedString(string: "Only 1"),
            firstConsentContainsLink: false,
            secondConsentHtml: nil,
            secondConsentContainsLink: false
        )))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerOnlySecondConsent() {
        // GIVEN
        viewModel.given(.consents(getter: ConsentsViewModel(
            firstConsentHtml: nil,
            firstConsentContainsLink: false,
            secondConsentHtml: NSAttributedString(string: "Only 2"),
            secondConsentContainsLink: false
        )))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerWithLinks() {
        // GIVEN
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
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerWithSpecialCharacters() {
        // GIVEN
        viewModel.given(.consents(getter: ConsentsViewModel(
            firstConsentHtml: try? NSAttributedString(
                data: Data("<p>This is a consent with <b>bold</b> and a <a href=\"https://www.google.com/\">link</a> and an 🤷‍♂️</p>".utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue,
                ],
                documentAttributes: nil
            ),
            firstConsentContainsLink: true,
            secondConsentHtml: try? NSAttributedString(
                data: Data("<p>This is a consent with a 😆 and a <br /> line break and a 🤷‍♂️ and finishing with empty chars                    </p>".utf8),
                options: [
                    .documentType: NSAttributedString.DocumentType.html,
                    .characterEncoding: String.Encoding.utf8.rawValue,
                ],
                documentAttributes: nil
            ),
            secondConsentContainsLink: true
        )))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }

    func testAppointmentConfirmationViewControllerUnchecked() {
        // GIVEN
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: false))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerPartialyChecked() {
        // GIVEN
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: true))
        viewModel.given(.agreesWithSecondConsent(getter: false))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerChecked() {
        // GIVEN
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: true))
        viewModel.given(.agreesWithSecondConsent(getter: true))
        viewModel.given(.canConfirm(getter: true))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerConfirmLoading() {
        // GIVEN
        viewModel.given(.consents(getter: defaultConsents))
        viewModel.given(.agreesWithFirstConsent(getter: true))
        viewModel.given(.agreesWithSecondConsent(getter: true))
        viewModel.given(.canConfirm(getter: true))
        viewModel.given(.isConfirming(getter: true))
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
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerForPhysicalLocation() {
        // GIVEN
        viewModel.given(.captionIcon(getter: .house))
        viewModel.given(.details1(getter: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France"))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentConfirmationViewControllerForPhysicalLocationWithExtra() {
        // GIVEN
        viewModel.given(.captionIcon(getter: .house))
        viewModel.given(.details1(getter: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France"))
        viewModel.given(.details2(getter: "Deuxième porte à gauche. Mais ce texte aussi devrait utiliser plusieurs lignes"))
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
