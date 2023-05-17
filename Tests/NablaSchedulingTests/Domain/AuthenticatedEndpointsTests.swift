import Combine
import NablaCore
import NablaCoreTestsUtils
@testable import NablaScheduling
import XCTest

class AuthenticatedEndpointsTests: XCTestCase {
    private var userRepository: UserRepositoryMock!
    private var appointmentRepository: AppointmentRepositoryMock!
    private var availabilitySlotRepository: AvailabilitySlotRepositoryMock!
    private var consentsRepository: ConsentsRepositoryMock!
    private var providerRepository: ProviderRepositoryMock!
    
    override func setUp() {
        super.setUp()
        userRepository = .init()
        appointmentRepository = .init()
        availabilitySlotRepository = .init()
        consentsRepository = .init()
        providerRepository = .init()
        
        userRepository.given(.getCurrentUser(willReturn: nil))
        userRepository.given(.watchCurrentUser(willReturn: Just(nil).eraseToAnyPublisher()))
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
        let sut = CancelAppointmentInteractorImpl(
            userRepository: userRepository,
            appointmentRepository: appointmentRepository
        )
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
        let sut = CreatePendingAppointmentInteractorImpl(
            userRepository: userRepository,
            appointmentRepository: appointmentRepository
        )
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
        let sut = GetAvailableLocationsInteractorImpl(
            userRepository: userRepository,
            appointmentRepository: appointmentRepository
        )
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
        let sut = SchedulePendingAppointmentInteractorImpl(
            userRepository: userRepository,
            appointmentRepository: appointmentRepository
        )
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
        let sut = WatchAppointmentInteractorImpl(
            userRepository: userRepository,
            appointmentRepository: appointmentRepository
        )
        // WHEN
        let publisher = sut.execute(id: .init())
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testWatchAppointmentsFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchAppointmentsInteractorImpl(
            userRepository: userRepository,
            appointmentRepository: appointmentRepository
        )
        // WHEN
        let publisher = sut.execute(state: .scheduled)
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testAvailabilitySlotsFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchAvailabilitySlotsInteractorImpl(
            userRepository: userRepository,
            availabilitySlotRepository: availabilitySlotRepository
        )
        // WHEN
        let publisher = sut.execute(categoryId: .init(), location: .remote)
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testWatchCategoriesFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchCategoriesInteractorImpl(
            userRepository: userRepository,
            availabilitySlotRepository: availabilitySlotRepository
        )
        // WHEN
        let publisher = sut.execute()
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testWatchConsentsFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchConsentsInteractorImpl(
            userRepository: userRepository,
            consentsRepository: consentsRepository
        )
        // WHEN
        let publisher = sut.execute(location: .remote)
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
    
    func testWatchProviderFailsWhenNotAuthenticated() {
        // GIVEN
        let sut = WatchProviderInteractorImpl(
            userRepository: userRepository,
            providerRepository: providerRepository
        )
        // WHEN
        let publisher = sut.execute(providerId: .init())
        // THEN
        assertAuthenticationErrorPublisher(publisher)
    }
}
