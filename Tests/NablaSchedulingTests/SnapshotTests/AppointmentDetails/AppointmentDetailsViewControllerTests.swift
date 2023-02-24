import Combine
import NablaCoreTestsUtils
@testable import NablaScheduling
import SnapshotTesting
import XCTest

@MainActor class AppointmentDetailsViewControllerTests: XCTestCase {
    private var sut: AppointmentDetailsViewController!
    
    private var viewModel: AppointmentDetailsViewModelMock!
    private var navigationController: UINavigationController!
    
    private func makeReadyItem(
        locationType: LocationType = .physical,
        location: String? = "22 rue Chapon",
        locationDetails: String? = "Extra location information",
        date: Date = Date(timeIntervalSinceReferenceDate: 0),
        price: String? = nil,
        showCancelButton: Bool = true
    ) -> AppointmentsDetailsViewItem {
        .init(
            provider: Provider(
                id: .init(),
                prefix: "Mr",
                firstName: "John",
                lastName: "Doe",
                title: "Description",
                avatarUrl: nil
            ),
            locationType: locationType,
            location: location,
            locationDetails: locationDetails,
            date: date,
            price: price,
            showCancelButton: showCancelButton
        )
    }
    
    override func setUp() {
        super.setUp()
        viewModel = .init()
        
        sut = AppointmentDetailsViewController(viewModel: viewModel)
        navigationController = UINavigationController(rootViewController: sut)
        
        viewModel.given(.onChange(willReturn: Just(()).eraseToAnyPublisher()))
        viewModel.given(.onChange(throttle: .any, willReturn: Just(()).eraseToAnyPublisher()))
    }
    
    func testAppointmentDetailsViewControllerLoading() {
        // GIVEN
        viewModel.given(.state(getter: .loading))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }

    func testAppointmentDetailsViewControllerForRemoteLocation() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            locationType: .remote,
            location: nil,
            locationDetails: nil
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerForPhysicalLocation() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            locationType: .physical,
            location: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France",
            locationDetails: nil
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerForPhysicalLocationWithExtra() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            locationType: .physical,
            location: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France",
            locationDetails: "Deuxième porte à gauche. Mais ce texte aussi devrait utiliser plusieurs lignes"
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerForPhysicalLocationWithPrice() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            locationType: .physical,
            location: "22 rue Chapon mais en plus long car il faut que ça prenne plusieurs lignes, 75003 Paris, France",
            locationDetails: "Deuxième porte à gauche. Mais ce texte aussi devrait utiliser plusieurs lignes",
            price: "25.00 €"
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerForRemoteLocationWithPrice() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            locationType: .remote,
            price: "25.00 €"
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
    
    func testAppointmentDetailsViewControllerWithoutCancelButton() {
        // GIVEN
        viewModel.given(.state(getter: .ready(makeReadyItem(
            showCancelButton: false
        ))))
        // WHEN
        // THEN
        assertSnapshots(matching: navigationController, as: .lightAndDarkImages())
    }
}
