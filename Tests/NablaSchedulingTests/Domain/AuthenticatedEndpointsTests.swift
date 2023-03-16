import Combine
import NablaCore
import NablaCoreTestsUtils
@testable import NablaScheduling
import XCTest

class AuthenticatedEndpointsTests: XCTestCase {
    private var authenticator: AuthenticatorMock!
    private var appointmentRepository: AppointmentRepositoryMock!
    private var availabilitySlotRepository: AvailabilitySlotRepositoryMock!
    private var consentsRepository: ConsentsRepositoryMock!
    private var providerRepository: ProviderRepositoryMock!
    
    override func setUp() {
        super.setUp()
        authenticator = .init()
        appointmentRepository = .init()
        availabilitySlotRepository = .init()
        consentsRepository = .init()
        providerRepository = .init()
        
        authenticator.given(.currentUserId(getter: nil))
        authenticator.given(.watchCurrentUserId(willReturn: Just(nil).eraseToAnyPublisher()))
    }
    
    private func assertAuthenticationErrorPublisher<T, E: Error>(_ publisher: AnyPublisher<T, E>) {
        let receiveErrorCalled = expectation(description: "receiveCompletion called with error")
        let receiveCompletionCalled = expectation(description: "receiveCompletion called with finished")
        receiveCompletionCalled.isInverted = true
        let receiveValueCalled = expectation(description: "receiveValue called")
        receiveValueCalled.isInverted = true
        let cancellable = publisher.sink { completion in
            switch completion {
            case .finished:
                receiveCompletionCalled.fulfill()
            case let .failure(error):
                XCTAssert(error is UserIdNotSetError)
                receiveErrorCalled.fulfill()
            }
        } receiveValue: { _ in
            receiveValueCalled.fulfill()
        }
        waitForExpectations(timeout: 0.5)
        XCTAssertNotNil(cancellable)
    }
    
    func testCancelAppointmentFailsWhenNotAuthenticated() async {
        // GIVEN
        let sut = CancelAppointmentInteractorImpl(authenticator: authenticator, repository: appointmentRepository)
        // WHEN
        do {
            try await sut.execute(appointmentId: .init())
            XCTFail("Should throw")
        } catch {
            // THEN
            XCTAssert(error is UserIdNotSetError)
        }
    }
    
    func testCreatePendingAppointmentFailsWhenNotAuthenticated() async {
        // GIVEN
        let sut = CreatePendingAppointmentInteractorImpl(authenticator: authenticator, repository: appointmentRepository)
        // WHEN
        do {
            _ = try await sut.execute(
                location: .physical,
                categoryId: .init(),
                providerId: .init(),
                date: .init()
            )
            XCTFail("Should throw")
        } catch {
            // THEN
            XCTAssert(error is UserIdNotSetError)
        }
    }
    
    func testGetAvailableLocationsFailsWhenNotAuthenticated() async {
        // GIVEN
        let sut = GetAvailableLocationsInteractorImpl(authenticator: authenticator, repository: appointmentRepository)
        // WHEN
        do {
            _ = try await sut.execute()
            XCTFail("Should throw")
        } catch {
            // THEN
            XCTAssert(error is UserIdNotSetError)
        }
    }
    
    func testSchedulingPendingAppointmentFailsWhenNotAuthenticated() async {
        // GIVEN
        let sut = SchedulePendingAppointmentInteractorImpl(authenticator: authenticator, repository: appointmentRepository)
        // WHEN
        do {
            _ = try await sut.execute(appointmentId: .init())
            XCTFail("Should throw")
        } catch {
            // THEN
            XCTAssert(error is UserIdNotSetError)
        }
    }
    
    func testWatchAppointmentFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchAppointmentInteractorImpl(authenticator: authenticator, repository: appointmentRepository)
        // WHEN
        let publisher = sut.execute(id: .init())
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testWatchAppointmentsFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchAppointmentsInteractorImpl(authenticator: authenticator, repository: appointmentRepository)
        // WHEN
        let publisher = sut.execute(state: .upcoming)
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testAvailabilitySlotsFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchAvailabilitySlotsInteractorImpl(authenticator: authenticator, repository: availabilitySlotRepository)
        // WHEN
        let publisher = sut.execute(categoryId: .init(), location: .remote)
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testWatchCategoriesFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchCategoriesInteractorImpl(authenticator: authenticator, repository: availabilitySlotRepository)
        // WHEN
        let publisher = sut.execute()
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testWatchConsentsFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchConsentsInteractorImpl(authenticator: authenticator, repository: consentsRepository)
        // WHEN
        let publisher = sut.execute(location: .remote)
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testWatchProviderFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchProviderInteractorImpl(authenticator: authenticator, repository: providerRepository)
        // WHEN
        let publisher = sut.execute(providerId: .init())
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
}
