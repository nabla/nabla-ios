// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import NablaCore
import Combine
@testable import NablaScheduling


// MARK: - AppointmentCellViewModel

open class AppointmentCellViewModelMock: AppointmentCellViewModel, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var avatar: AvatarViewModel {
		get {	invocations.append(.p_avatar_get); return __p_avatar ?? givenGetterValue(.p_avatar_get, "AppointmentCellViewModelMock - stub value for avatar was not defined") }
	}
	private var __p_avatar: (AvatarViewModel)?

    public var title: String {
		get {	invocations.append(.p_title_get); return __p_title ?? givenGetterValue(.p_title_get, "AppointmentCellViewModelMock - stub value for title was not defined") }
	}
	private var __p_title: (String)?

    public var subtitle: String {
		get {	invocations.append(.p_subtitle_get); return __p_subtitle ?? givenGetterValue(.p_subtitle_get, "AppointmentCellViewModelMock - stub value for subtitle was not defined") }
	}
	private var __p_subtitle: (String)?

    public var enabled: Bool {
		get {	invocations.append(.p_enabled_get); return __p_enabled ?? givenGetterValue(.p_enabled_get, "AppointmentCellViewModelMock - stub value for enabled was not defined") }
	}
	private var __p_enabled: (Bool)?

    public var primaryActionTitle: String? {
		get {	invocations.append(.p_primaryActionTitle_get); return __p_primaryActionTitle ?? optionalGivenGetterValue(.p_primaryActionTitle_get, "AppointmentCellViewModelMock - stub value for primaryActionTitle was not defined") }
	}
	private var __p_primaryActionTitle: (String)?

    public var showSecondaryActionsButton: Bool {
		get {	invocations.append(.p_showSecondaryActionsButton_get); return __p_showSecondaryActionsButton ?? givenGetterValue(.p_showSecondaryActionsButton_get, "AppointmentCellViewModelMock - stub value for showSecondaryActionsButton was not defined") }
	}
	private var __p_showSecondaryActionsButton: (Bool)?





    open func userDidTapPrimaryActionButton() {
        addInvocation(.m_userDidTapPrimaryActionButton)
		let perform = methodPerformValue(.m_userDidTapPrimaryActionButton) as? () -> Void
		perform?()
    }

    open func userDidTapSecondaryActionsButton() {
        addInvocation(.m_userDidTapSecondaryActionsButton)
		let perform = methodPerformValue(.m_userDidTapSecondaryActionsButton) as? () -> Void
		perform?()
    }

    open func onChange() -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange)
		let perform = methodPerformValue(.m_onChange) as? () -> Void
		perform?()
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(). Use given")
			Failure("Stub return value not specified for onChange(). Use given")
		}
		return __value
    }

    open func onChange(throttle: DispatchQueue.SchedulerTimeType.Stride) -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`)))
		let perform = methodPerformValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))) as? (DispatchQueue.SchedulerTimeType.Stride) -> Void
		perform?(`throttle`)
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
			Failure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_userDidTapPrimaryActionButton
        case m_userDidTapSecondaryActionsButton
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_avatar_get
        case p_title_get
        case p_subtitle_get
        case p_enabled_get
        case p_primaryActionTitle_get
        case p_showSecondaryActionsButton_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidTapPrimaryActionButton, .m_userDidTapPrimaryActionButton): return .match

            case (.m_userDidTapSecondaryActionsButton, .m_userDidTapSecondaryActionsButton): return .match

            case (.m_onChange, .m_onChange): return .match

            case (.m_onChange__throttle_throttle(let lhsThrottle), .m_onChange__throttle_throttle(let rhsThrottle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsThrottle, rhs: rhsThrottle, with: matcher), lhsThrottle, rhsThrottle, "throttle"))
				return Matcher.ComparisonResult(results)
            case (.p_avatar_get,.p_avatar_get): return Matcher.ComparisonResult.match
            case (.p_title_get,.p_title_get): return Matcher.ComparisonResult.match
            case (.p_subtitle_get,.p_subtitle_get): return Matcher.ComparisonResult.match
            case (.p_enabled_get,.p_enabled_get): return Matcher.ComparisonResult.match
            case (.p_primaryActionTitle_get,.p_primaryActionTitle_get): return Matcher.ComparisonResult.match
            case (.p_showSecondaryActionsButton_get,.p_showSecondaryActionsButton_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidTapPrimaryActionButton: return 0
            case .m_userDidTapSecondaryActionsButton: return 0
            case .m_onChange: return 0
            case let .m_onChange__throttle_throttle(p0): return p0.intValue
            case .p_avatar_get: return 0
            case .p_title_get: return 0
            case .p_subtitle_get: return 0
            case .p_enabled_get: return 0
            case .p_primaryActionTitle_get: return 0
            case .p_showSecondaryActionsButton_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidTapPrimaryActionButton: return ".userDidTapPrimaryActionButton()"
            case .m_userDidTapSecondaryActionsButton: return ".userDidTapSecondaryActionsButton()"
            case .m_onChange: return ".onChange()"
            case .m_onChange__throttle_throttle: return ".onChange(throttle:)"
            case .p_avatar_get: return "[get] .avatar"
            case .p_title_get: return "[get] .title"
            case .p_subtitle_get: return "[get] .subtitle"
            case .p_enabled_get: return "[get] .enabled"
            case .p_primaryActionTitle_get: return "[get] .primaryActionTitle"
            case .p_showSecondaryActionsButton_get: return "[get] .showSecondaryActionsButton"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func avatar(getter defaultValue: AvatarViewModel...) -> PropertyStub {
            return Given(method: .p_avatar_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func title(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_title_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func subtitle(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_subtitle_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func enabled(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_enabled_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func primaryActionTitle(getter defaultValue: String?...) -> PropertyStub {
            return Given(method: .p_primaryActionTitle_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func showSecondaryActionsButton(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_showSecondaryActionsButton_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func onChange(willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func userDidTapPrimaryActionButton() -> Verify { return Verify(method: .m_userDidTapPrimaryActionButton)}
        public static func userDidTapSecondaryActionsButton() -> Verify { return Verify(method: .m_userDidTapSecondaryActionsButton)}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var avatar: Verify { return Verify(method: .p_avatar_get) }
        public static var title: Verify { return Verify(method: .p_title_get) }
        public static var subtitle: Verify { return Verify(method: .p_subtitle_get) }
        public static var enabled: Verify { return Verify(method: .p_enabled_get) }
        public static var primaryActionTitle: Verify { return Verify(method: .p_primaryActionTitle_get) }
        public static var showSecondaryActionsButton: Verify { return Verify(method: .p_showSecondaryActionsButton_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func userDidTapPrimaryActionButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapPrimaryActionButton, performs: perform)
        }
        public static func userDidTapSecondaryActionsButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapSecondaryActionsButton, performs: perform)
        }
        public static func onChange(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_onChange, performs: perform)
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, perform: @escaping (DispatchQueue.SchedulerTimeType.Stride) -> Void) -> Perform {
            return Perform(method: .m_onChange__throttle_throttle(`throttle`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - AppointmentConfirmationViewModel

open class AppointmentConfirmationViewModelMock: AppointmentConfirmationViewModel, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var provider: Provider? {
		get {	invocations.append(.p_provider_get); return __p_provider ?? optionalGivenGetterValue(.p_provider_get, "AppointmentConfirmationViewModelMock - stub value for provider was not defined") }
	}
	private var __p_provider: (Provider)?

    public var appointmentDate: Date {
		get {	invocations.append(.p_appointmentDate_get); return __p_appointmentDate ?? givenGetterValue(.p_appointmentDate_get, "AppointmentConfirmationViewModelMock - stub value for appointmentDate was not defined") }
	}
	private var __p_appointmentDate: (Date)?

    public var agreesWithFirstConsent: Bool {
		get {	invocations.append(.p_agreesWithFirstConsent_get); return __p_agreesWithFirstConsent ?? givenGetterValue(.p_agreesWithFirstConsent_get, "AppointmentConfirmationViewModelMock - stub value for agreesWithFirstConsent was not defined") }
		set {	invocations.append(.p_agreesWithFirstConsent_set(.value(newValue))); __p_agreesWithFirstConsent = newValue }
	}
	private var __p_agreesWithFirstConsent: (Bool)?

    public var agreesWithSecondConsent: Bool {
		get {	invocations.append(.p_agreesWithSecondConsent_get); return __p_agreesWithSecondConsent ?? givenGetterValue(.p_agreesWithSecondConsent_get, "AppointmentConfirmationViewModelMock - stub value for agreesWithSecondConsent was not defined") }
		set {	invocations.append(.p_agreesWithSecondConsent_set(.value(newValue))); __p_agreesWithSecondConsent = newValue }
	}
	private var __p_agreesWithSecondConsent: (Bool)?

    public var canConfirm: Bool {
		get {	invocations.append(.p_canConfirm_get); return __p_canConfirm ?? givenGetterValue(.p_canConfirm_get, "AppointmentConfirmationViewModelMock - stub value for canConfirm was not defined") }
	}
	private var __p_canConfirm: (Bool)?

    public var isConfirming: Bool {
		get {	invocations.append(.p_isConfirming_get); return __p_isConfirming ?? givenGetterValue(.p_isConfirming_get, "AppointmentConfirmationViewModelMock - stub value for isConfirming was not defined") }
	}
	private var __p_isConfirming: (Bool)?

    public var isLoadingConsents: Bool {
		get {	invocations.append(.p_isLoadingConsents_get); return __p_isLoadingConsents ?? givenGetterValue(.p_isLoadingConsents_get, "AppointmentConfirmationViewModelMock - stub value for isLoadingConsents was not defined") }
	}
	private var __p_isLoadingConsents: (Bool)?

    public var consents: ConsentsViewModel? {
		get {	invocations.append(.p_consents_get); return __p_consents ?? optionalGivenGetterValue(.p_consents_get, "AppointmentConfirmationViewModelMock - stub value for consents was not defined") }
	}
	private var __p_consents: (ConsentsViewModel)?

    public var consentsLoadingError: ConsentsErrorViewModel? {
		get {	invocations.append(.p_consentsLoadingError_get); return __p_consentsLoadingError ?? optionalGivenGetterValue(.p_consentsLoadingError_get, "AppointmentConfirmationViewModelMock - stub value for consentsLoadingError was not defined") }
	}
	private var __p_consentsLoadingError: (ConsentsErrorViewModel)?

    public var error: AlertViewModel? {
		get {	invocations.append(.p_error_get); return __p_error ?? optionalGivenGetterValue(.p_error_get, "AppointmentConfirmationViewModelMock - stub value for error was not defined") }
		set {	invocations.append(.p_error_set(.value(newValue))); __p_error = newValue }
	}
	private var __p_error: (AlertViewModel)?





    open func userDidTapConfirmButton() {
        addInvocation(.m_userDidTapConfirmButton)
		let perform = methodPerformValue(.m_userDidTapConfirmButton) as? () -> Void
		perform?()
    }

    open func onChange() -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange)
		let perform = methodPerformValue(.m_onChange) as? () -> Void
		perform?()
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(). Use given")
			Failure("Stub return value not specified for onChange(). Use given")
		}
		return __value
    }

    open func onChange(throttle: DispatchQueue.SchedulerTimeType.Stride) -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`)))
		let perform = methodPerformValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))) as? (DispatchQueue.SchedulerTimeType.Stride) -> Void
		perform?(`throttle`)
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
			Failure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_userDidTapConfirmButton
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_provider_get
        case p_appointmentDate_get
        case p_agreesWithFirstConsent_get
		case p_agreesWithFirstConsent_set(Parameter<Bool>)
        case p_agreesWithSecondConsent_get
		case p_agreesWithSecondConsent_set(Parameter<Bool>)
        case p_canConfirm_get
        case p_isConfirming_get
        case p_isLoadingConsents_get
        case p_consents_get
        case p_consentsLoadingError_get
        case p_error_get
		case p_error_set(Parameter<AlertViewModel?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidTapConfirmButton, .m_userDidTapConfirmButton): return .match

            case (.m_onChange, .m_onChange): return .match

            case (.m_onChange__throttle_throttle(let lhsThrottle), .m_onChange__throttle_throttle(let rhsThrottle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsThrottle, rhs: rhsThrottle, with: matcher), lhsThrottle, rhsThrottle, "throttle"))
				return Matcher.ComparisonResult(results)
            case (.p_provider_get,.p_provider_get): return Matcher.ComparisonResult.match
            case (.p_appointmentDate_get,.p_appointmentDate_get): return Matcher.ComparisonResult.match
            case (.p_agreesWithFirstConsent_get,.p_agreesWithFirstConsent_get): return Matcher.ComparisonResult.match
			case (.p_agreesWithFirstConsent_set(let left),.p_agreesWithFirstConsent_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<Bool>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_agreesWithSecondConsent_get,.p_agreesWithSecondConsent_get): return Matcher.ComparisonResult.match
			case (.p_agreesWithSecondConsent_set(let left),.p_agreesWithSecondConsent_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<Bool>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_canConfirm_get,.p_canConfirm_get): return Matcher.ComparisonResult.match
            case (.p_isConfirming_get,.p_isConfirming_get): return Matcher.ComparisonResult.match
            case (.p_isLoadingConsents_get,.p_isLoadingConsents_get): return Matcher.ComparisonResult.match
            case (.p_consents_get,.p_consents_get): return Matcher.ComparisonResult.match
            case (.p_consentsLoadingError_get,.p_consentsLoadingError_get): return Matcher.ComparisonResult.match
            case (.p_error_get,.p_error_get): return Matcher.ComparisonResult.match
			case (.p_error_set(let left),.p_error_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AlertViewModel?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidTapConfirmButton: return 0
            case .m_onChange: return 0
            case let .m_onChange__throttle_throttle(p0): return p0.intValue
            case .p_provider_get: return 0
            case .p_appointmentDate_get: return 0
            case .p_agreesWithFirstConsent_get: return 0
			case .p_agreesWithFirstConsent_set(let newValue): return newValue.intValue
            case .p_agreesWithSecondConsent_get: return 0
			case .p_agreesWithSecondConsent_set(let newValue): return newValue.intValue
            case .p_canConfirm_get: return 0
            case .p_isConfirming_get: return 0
            case .p_isLoadingConsents_get: return 0
            case .p_consents_get: return 0
            case .p_consentsLoadingError_get: return 0
            case .p_error_get: return 0
			case .p_error_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidTapConfirmButton: return ".userDidTapConfirmButton()"
            case .m_onChange: return ".onChange()"
            case .m_onChange__throttle_throttle: return ".onChange(throttle:)"
            case .p_provider_get: return "[get] .provider"
            case .p_appointmentDate_get: return "[get] .appointmentDate"
            case .p_agreesWithFirstConsent_get: return "[get] .agreesWithFirstConsent"
			case .p_agreesWithFirstConsent_set: return "[set] .agreesWithFirstConsent"
            case .p_agreesWithSecondConsent_get: return "[get] .agreesWithSecondConsent"
			case .p_agreesWithSecondConsent_set: return "[set] .agreesWithSecondConsent"
            case .p_canConfirm_get: return "[get] .canConfirm"
            case .p_isConfirming_get: return "[get] .isConfirming"
            case .p_isLoadingConsents_get: return "[get] .isLoadingConsents"
            case .p_consents_get: return "[get] .consents"
            case .p_consentsLoadingError_get: return "[get] .consentsLoadingError"
            case .p_error_get: return "[get] .error"
			case .p_error_set: return "[set] .error"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func provider(getter defaultValue: Provider?...) -> PropertyStub {
            return Given(method: .p_provider_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func appointmentDate(getter defaultValue: Date...) -> PropertyStub {
            return Given(method: .p_appointmentDate_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func agreesWithFirstConsent(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_agreesWithFirstConsent_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func agreesWithSecondConsent(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_agreesWithSecondConsent_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func canConfirm(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_canConfirm_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func isConfirming(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isConfirming_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func isLoadingConsents(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoadingConsents_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func consents(getter defaultValue: ConsentsViewModel?...) -> PropertyStub {
            return Given(method: .p_consents_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func consentsLoadingError(getter defaultValue: ConsentsErrorViewModel?...) -> PropertyStub {
            return Given(method: .p_consentsLoadingError_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func error(getter defaultValue: AlertViewModel?...) -> PropertyStub {
            return Given(method: .p_error_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func onChange(willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func userDidTapConfirmButton() -> Verify { return Verify(method: .m_userDidTapConfirmButton)}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var provider: Verify { return Verify(method: .p_provider_get) }
        public static var appointmentDate: Verify { return Verify(method: .p_appointmentDate_get) }
        public static var agreesWithFirstConsent: Verify { return Verify(method: .p_agreesWithFirstConsent_get) }
		public static func agreesWithFirstConsent(set newValue: Parameter<Bool>) -> Verify { return Verify(method: .p_agreesWithFirstConsent_set(newValue)) }
        public static var agreesWithSecondConsent: Verify { return Verify(method: .p_agreesWithSecondConsent_get) }
		public static func agreesWithSecondConsent(set newValue: Parameter<Bool>) -> Verify { return Verify(method: .p_agreesWithSecondConsent_set(newValue)) }
        public static var canConfirm: Verify { return Verify(method: .p_canConfirm_get) }
        public static var isConfirming: Verify { return Verify(method: .p_isConfirming_get) }
        public static var isLoadingConsents: Verify { return Verify(method: .p_isLoadingConsents_get) }
        public static var consents: Verify { return Verify(method: .p_consents_get) }
        public static var consentsLoadingError: Verify { return Verify(method: .p_consentsLoadingError_get) }
        public static var error: Verify { return Verify(method: .p_error_get) }
		public static func error(set newValue: Parameter<AlertViewModel?>) -> Verify { return Verify(method: .p_error_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func userDidTapConfirmButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapConfirmButton, performs: perform)
        }
        public static func onChange(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_onChange, performs: perform)
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, perform: @escaping (DispatchQueue.SchedulerTimeType.Stride) -> Void) -> Perform {
            return Perform(method: .m_onChange__throttle_throttle(`throttle`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - AppointmentListViewModel

open class AppointmentListViewModelMock: AppointmentListViewModel, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var selectedSelector: AppointmentsSelector {
		get {	invocations.append(.p_selectedSelector_get); return __p_selectedSelector ?? givenGetterValue(.p_selectedSelector_get, "AppointmentListViewModelMock - stub value for selectedSelector was not defined") }
		set {	invocations.append(.p_selectedSelector_set(.value(newValue))); __p_selectedSelector = newValue }
	}
	private var __p_selectedSelector: (AppointmentsSelector)?

    public var appointments: [Appointment] {
		get {	invocations.append(.p_appointments_get); return __p_appointments ?? givenGetterValue(.p_appointments_get, "AppointmentListViewModelMock - stub value for appointments was not defined") }
	}
	private var __p_appointments: ([Appointment])?

    public var isLoading: Bool {
		get {	invocations.append(.p_isLoading_get); return __p_isLoading ?? givenGetterValue(.p_isLoading_get, "AppointmentListViewModelMock - stub value for isLoading was not defined") }
	}
	private var __p_isLoading: (Bool)?

    public var modal: AppointmentsViewModal? {
		get {	invocations.append(.p_modal_get); return __p_modal ?? optionalGivenGetterValue(.p_modal_get, "AppointmentListViewModelMock - stub value for modal was not defined") }
		set {	invocations.append(.p_modal_set(.value(newValue))); __p_modal = newValue }
	}
	private var __p_modal: (AppointmentsViewModal)?





    open func userDidReachEndOfList() {
        addInvocation(.m_userDidReachEndOfList)
		let perform = methodPerformValue(.m_userDidReachEndOfList) as? () -> Void
		perform?()
    }

    open func userDidTapCreateAppointmentButton() {
        addInvocation(.m_userDidTapCreateAppointmentButton)
		let perform = methodPerformValue(.m_userDidTapCreateAppointmentButton) as? () -> Void
		perform?()
    }

    open func appointmentCellViewModel(_ viewModel: AppointmentCellViewModel, didTapJoinVideoCall room: Appointment.VideoCallRoom) {
        addInvocation(.m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(Parameter<AppointmentCellViewModel>.value(`viewModel`), Parameter<Appointment.VideoCallRoom>.value(`room`)))
		let perform = methodPerformValue(.m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(Parameter<AppointmentCellViewModel>.value(`viewModel`), Parameter<Appointment.VideoCallRoom>.value(`room`))) as? (AppointmentCellViewModel, Appointment.VideoCallRoom) -> Void
		perform?(`viewModel`, `room`)
    }

    open func appointmentCellViewModel(_ viewModel: AppointmentCellViewModel, didTapSecondaryActionsButtonFor appointment: Appointment) {
        addInvocation(.m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(Parameter<AppointmentCellViewModel>.value(`viewModel`), Parameter<Appointment>.value(`appointment`)))
		let perform = methodPerformValue(.m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(Parameter<AppointmentCellViewModel>.value(`viewModel`), Parameter<Appointment>.value(`appointment`))) as? (AppointmentCellViewModel, Appointment) -> Void
		perform?(`viewModel`, `appointment`)
    }

    open func onChange() -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange)
		let perform = methodPerformValue(.m_onChange) as? () -> Void
		perform?()
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(). Use given")
			Failure("Stub return value not specified for onChange(). Use given")
		}
		return __value
    }

    open func onChange(throttle: DispatchQueue.SchedulerTimeType.Stride) -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`)))
		let perform = methodPerformValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))) as? (DispatchQueue.SchedulerTimeType.Stride) -> Void
		perform?(`throttle`)
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
			Failure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_userDidReachEndOfList
        case m_userDidTapCreateAppointmentButton
        case m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(Parameter<AppointmentCellViewModel>, Parameter<Appointment.VideoCallRoom>)
        case m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(Parameter<AppointmentCellViewModel>, Parameter<Appointment>)
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_selectedSelector_get
		case p_selectedSelector_set(Parameter<AppointmentsSelector>)
        case p_appointments_get
        case p_isLoading_get
        case p_modal_get
		case p_modal_set(Parameter<AppointmentsViewModal?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidReachEndOfList, .m_userDidReachEndOfList): return .match

            case (.m_userDidTapCreateAppointmentButton, .m_userDidTapCreateAppointmentButton): return .match

            case (.m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(let lhsViewmodel, let lhsRoom), .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(let rhsViewmodel, let rhsRoom)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsViewmodel, rhs: rhsViewmodel, with: matcher), lhsViewmodel, rhsViewmodel, "_ viewModel"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRoom, rhs: rhsRoom, with: matcher), lhsRoom, rhsRoom, "didTapJoinVideoCall room"))
				return Matcher.ComparisonResult(results)

            case (.m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(let lhsViewmodel, let lhsAppointment), .m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(let rhsViewmodel, let rhsAppointment)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsViewmodel, rhs: rhsViewmodel, with: matcher), lhsViewmodel, rhsViewmodel, "_ viewModel"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAppointment, rhs: rhsAppointment, with: matcher), lhsAppointment, rhsAppointment, "didTapSecondaryActionsButtonFor appointment"))
				return Matcher.ComparisonResult(results)

            case (.m_onChange, .m_onChange): return .match

            case (.m_onChange__throttle_throttle(let lhsThrottle), .m_onChange__throttle_throttle(let rhsThrottle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsThrottle, rhs: rhsThrottle, with: matcher), lhsThrottle, rhsThrottle, "throttle"))
				return Matcher.ComparisonResult(results)
            case (.p_selectedSelector_get,.p_selectedSelector_get): return Matcher.ComparisonResult.match
			case (.p_selectedSelector_set(let left),.p_selectedSelector_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AppointmentsSelector>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_appointments_get,.p_appointments_get): return Matcher.ComparisonResult.match
            case (.p_isLoading_get,.p_isLoading_get): return Matcher.ComparisonResult.match
            case (.p_modal_get,.p_modal_get): return Matcher.ComparisonResult.match
			case (.p_modal_set(let left),.p_modal_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AppointmentsViewModal?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidReachEndOfList: return 0
            case .m_userDidTapCreateAppointmentButton: return 0
            case let .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(p0, p1): return p0.intValue + p1.intValue
            case let .m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(p0, p1): return p0.intValue + p1.intValue
            case .m_onChange: return 0
            case let .m_onChange__throttle_throttle(p0): return p0.intValue
            case .p_selectedSelector_get: return 0
			case .p_selectedSelector_set(let newValue): return newValue.intValue
            case .p_appointments_get: return 0
            case .p_isLoading_get: return 0
            case .p_modal_get: return 0
			case .p_modal_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidReachEndOfList: return ".userDidReachEndOfList()"
            case .m_userDidTapCreateAppointmentButton: return ".userDidTapCreateAppointmentButton()"
            case .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room: return ".appointmentCellViewModel(_:didTapJoinVideoCall:)"
            case .m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment: return ".appointmentCellViewModel(_:didTapSecondaryActionsButtonFor:)"
            case .m_onChange: return ".onChange()"
            case .m_onChange__throttle_throttle: return ".onChange(throttle:)"
            case .p_selectedSelector_get: return "[get] .selectedSelector"
			case .p_selectedSelector_set: return "[set] .selectedSelector"
            case .p_appointments_get: return "[get] .appointments"
            case .p_isLoading_get: return "[get] .isLoading"
            case .p_modal_get: return "[get] .modal"
			case .p_modal_set: return "[set] .modal"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func selectedSelector(getter defaultValue: AppointmentsSelector...) -> PropertyStub {
            return Given(method: .p_selectedSelector_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func appointments(getter defaultValue: [Appointment]...) -> PropertyStub {
            return Given(method: .p_appointments_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func isLoading(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoading_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func modal(getter defaultValue: AppointmentsViewModal?...) -> PropertyStub {
            return Given(method: .p_modal_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func onChange(willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func userDidReachEndOfList() -> Verify { return Verify(method: .m_userDidReachEndOfList)}
        public static func userDidTapCreateAppointmentButton() -> Verify { return Verify(method: .m_userDidTapCreateAppointmentButton)}
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapJoinVideoCall room: Parameter<Appointment.VideoCallRoom>) -> Verify { return Verify(method: .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(`viewModel`, `room`))}
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapSecondaryActionsButtonFor appointment: Parameter<Appointment>) -> Verify { return Verify(method: .m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(`viewModel`, `appointment`))}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var selectedSelector: Verify { return Verify(method: .p_selectedSelector_get) }
		public static func selectedSelector(set newValue: Parameter<AppointmentsSelector>) -> Verify { return Verify(method: .p_selectedSelector_set(newValue)) }
        public static var appointments: Verify { return Verify(method: .p_appointments_get) }
        public static var isLoading: Verify { return Verify(method: .p_isLoading_get) }
        public static var modal: Verify { return Verify(method: .p_modal_get) }
		public static func modal(set newValue: Parameter<AppointmentsViewModal?>) -> Verify { return Verify(method: .p_modal_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func userDidReachEndOfList(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidReachEndOfList, performs: perform)
        }
        public static func userDidTapCreateAppointmentButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapCreateAppointmentButton, performs: perform)
        }
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapJoinVideoCall room: Parameter<Appointment.VideoCallRoom>, perform: @escaping (AppointmentCellViewModel, Appointment.VideoCallRoom) -> Void) -> Perform {
            return Perform(method: .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(`viewModel`, `room`), performs: perform)
        }
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapSecondaryActionsButtonFor appointment: Parameter<Appointment>, perform: @escaping (AppointmentCellViewModel, Appointment) -> Void) -> Perform {
            return Perform(method: .m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(`viewModel`, `appointment`), performs: perform)
        }
        public static func onChange(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_onChange, performs: perform)
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, perform: @escaping (DispatchQueue.SchedulerTimeType.Stride) -> Void) -> Perform {
            return Perform(method: .m_onChange__throttle_throttle(`throttle`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - CategoryPickerViewModel

open class CategoryPickerViewModelMock: CategoryPickerViewModel, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var isLoading: Bool {
		get {	invocations.append(.p_isLoading_get); return __p_isLoading ?? givenGetterValue(.p_isLoading_get, "CategoryPickerViewModelMock - stub value for isLoading was not defined") }
	}
	private var __p_isLoading: (Bool)?

    public var items: [CategoryViewItem] {
		get {	invocations.append(.p_items_get); return __p_items ?? givenGetterValue(.p_items_get, "CategoryPickerViewModelMock - stub value for items was not defined") }
	}
	private var __p_items: ([CategoryViewItem])?

    public var error: AlertViewModel? {
		get {	invocations.append(.p_error_get); return __p_error ?? optionalGivenGetterValue(.p_error_get, "CategoryPickerViewModelMock - stub value for error was not defined") }
		set {	invocations.append(.p_error_set(.value(newValue))); __p_error = newValue }
	}
	private var __p_error: (AlertViewModel)?





    open func userDidPullToRefresh() {
        addInvocation(.m_userDidPullToRefresh)
		let perform = methodPerformValue(.m_userDidPullToRefresh) as? () -> Void
		perform?()
    }

    open func userDidSelect(category: CategoryViewItem, at index: Int) {
        addInvocation(.m_userDidSelect__category_categoryat_index(Parameter<CategoryViewItem>.value(`category`), Parameter<Int>.value(`index`)))
		let perform = methodPerformValue(.m_userDidSelect__category_categoryat_index(Parameter<CategoryViewItem>.value(`category`), Parameter<Int>.value(`index`))) as? (CategoryViewItem, Int) -> Void
		perform?(`category`, `index`)
    }

    open func onChange() -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange)
		let perform = methodPerformValue(.m_onChange) as? () -> Void
		perform?()
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(). Use given")
			Failure("Stub return value not specified for onChange(). Use given")
		}
		return __value
    }

    open func onChange(throttle: DispatchQueue.SchedulerTimeType.Stride) -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`)))
		let perform = methodPerformValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))) as? (DispatchQueue.SchedulerTimeType.Stride) -> Void
		perform?(`throttle`)
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
			Failure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_userDidPullToRefresh
        case m_userDidSelect__category_categoryat_index(Parameter<CategoryViewItem>, Parameter<Int>)
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_isLoading_get
        case p_items_get
        case p_error_get
		case p_error_set(Parameter<AlertViewModel?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidPullToRefresh, .m_userDidPullToRefresh): return .match

            case (.m_userDidSelect__category_categoryat_index(let lhsCategory, let lhsIndex), .m_userDidSelect__category_categoryat_index(let rhsCategory, let rhsIndex)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIndex, rhs: rhsIndex, with: matcher), lhsIndex, rhsIndex, "at index"))
				return Matcher.ComparisonResult(results)

            case (.m_onChange, .m_onChange): return .match

            case (.m_onChange__throttle_throttle(let lhsThrottle), .m_onChange__throttle_throttle(let rhsThrottle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsThrottle, rhs: rhsThrottle, with: matcher), lhsThrottle, rhsThrottle, "throttle"))
				return Matcher.ComparisonResult(results)
            case (.p_isLoading_get,.p_isLoading_get): return Matcher.ComparisonResult.match
            case (.p_items_get,.p_items_get): return Matcher.ComparisonResult.match
            case (.p_error_get,.p_error_get): return Matcher.ComparisonResult.match
			case (.p_error_set(let left),.p_error_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AlertViewModel?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidPullToRefresh: return 0
            case let .m_userDidSelect__category_categoryat_index(p0, p1): return p0.intValue + p1.intValue
            case .m_onChange: return 0
            case let .m_onChange__throttle_throttle(p0): return p0.intValue
            case .p_isLoading_get: return 0
            case .p_items_get: return 0
            case .p_error_get: return 0
			case .p_error_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidPullToRefresh: return ".userDidPullToRefresh()"
            case .m_userDidSelect__category_categoryat_index: return ".userDidSelect(category:at:)"
            case .m_onChange: return ".onChange()"
            case .m_onChange__throttle_throttle: return ".onChange(throttle:)"
            case .p_isLoading_get: return "[get] .isLoading"
            case .p_items_get: return "[get] .items"
            case .p_error_get: return "[get] .error"
			case .p_error_set: return "[set] .error"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func isLoading(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoading_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func items(getter defaultValue: [CategoryViewItem]...) -> PropertyStub {
            return Given(method: .p_items_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func error(getter defaultValue: AlertViewModel?...) -> PropertyStub {
            return Given(method: .p_error_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func onChange(willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func userDidPullToRefresh() -> Verify { return Verify(method: .m_userDidPullToRefresh)}
        public static func userDidSelect(category: Parameter<CategoryViewItem>, at index: Parameter<Int>) -> Verify { return Verify(method: .m_userDidSelect__category_categoryat_index(`category`, `index`))}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var isLoading: Verify { return Verify(method: .p_isLoading_get) }
        public static var items: Verify { return Verify(method: .p_items_get) }
        public static var error: Verify { return Verify(method: .p_error_get) }
		public static func error(set newValue: Parameter<AlertViewModel?>) -> Verify { return Verify(method: .p_error_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func userDidPullToRefresh(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidPullToRefresh, performs: perform)
        }
        public static func userDidSelect(category: Parameter<CategoryViewItem>, at index: Parameter<Int>, perform: @escaping (CategoryViewItem, Int) -> Void) -> Perform {
            return Perform(method: .m_userDidSelect__category_categoryat_index(`category`, `index`), performs: perform)
        }
        public static func onChange(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_onChange, performs: perform)
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, perform: @escaping (DispatchQueue.SchedulerTimeType.Stride) -> Void) -> Perform {
            return Perform(method: .m_onChange__throttle_throttle(`throttle`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - InternalSchedulingViewFactory

open class InternalSchedulingViewFactoryMock: InternalSchedulingViewFactory, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given
    public typealias Category = NablaScheduling.Category

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }





    open func createCategoryPickerViewController(delegate: CategoryPickerViewModelDelegate) -> UIViewController {
        addInvocation(.m_createCategoryPickerViewController__delegate_delegate(Parameter<CategoryPickerViewModelDelegate>.value(`delegate`)))
		let perform = methodPerformValue(.m_createCategoryPickerViewController__delegate_delegate(Parameter<CategoryPickerViewModelDelegate>.value(`delegate`))) as? (CategoryPickerViewModelDelegate) -> Void
		perform?(`delegate`)
		var __value: UIViewController
		do {
		    __value = try methodReturnValue(.m_createCategoryPickerViewController__delegate_delegate(Parameter<CategoryPickerViewModelDelegate>.value(`delegate`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createCategoryPickerViewController(delegate: CategoryPickerViewModelDelegate). Use given")
			Failure("Stub return value not specified for createCategoryPickerViewController(delegate: CategoryPickerViewModelDelegate). Use given")
		}
		return __value
    }

    open func createTimeSlotPickerViewController(category: Category, delegate: TimeSlotPickerViewModelDelegate) -> UIViewController {
        addInvocation(.m_createTimeSlotPickerViewController__category_categorydelegate_delegate(Parameter<Category>.value(`category`), Parameter<TimeSlotPickerViewModelDelegate>.value(`delegate`)))
		let perform = methodPerformValue(.m_createTimeSlotPickerViewController__category_categorydelegate_delegate(Parameter<Category>.value(`category`), Parameter<TimeSlotPickerViewModelDelegate>.value(`delegate`))) as? (Category, TimeSlotPickerViewModelDelegate) -> Void
		perform?(`category`, `delegate`)
		var __value: UIViewController
		do {
		    __value = try methodReturnValue(.m_createTimeSlotPickerViewController__category_categorydelegate_delegate(Parameter<Category>.value(`category`), Parameter<TimeSlotPickerViewModelDelegate>.value(`delegate`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createTimeSlotPickerViewController(category: Category, delegate: TimeSlotPickerViewModelDelegate). Use given")
			Failure("Stub return value not specified for createTimeSlotPickerViewController(category: Category, delegate: TimeSlotPickerViewModelDelegate). Use given")
		}
		return __value
    }

    open func createAppointmentConfirmationViewController(category: Category, timeSlot: AvailabilitySlot, delegate: AppointmentConfirmationViewModelDelegate) -> UIViewController {
        addInvocation(.m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(Parameter<Category>.value(`category`), Parameter<AvailabilitySlot>.value(`timeSlot`), Parameter<AppointmentConfirmationViewModelDelegate>.value(`delegate`)))
		let perform = methodPerformValue(.m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(Parameter<Category>.value(`category`), Parameter<AvailabilitySlot>.value(`timeSlot`), Parameter<AppointmentConfirmationViewModelDelegate>.value(`delegate`))) as? (Category, AvailabilitySlot, AppointmentConfirmationViewModelDelegate) -> Void
		perform?(`category`, `timeSlot`, `delegate`)
		var __value: UIViewController
		do {
		    __value = try methodReturnValue(.m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(Parameter<Category>.value(`category`), Parameter<AvailabilitySlot>.value(`timeSlot`), Parameter<AppointmentConfirmationViewModelDelegate>.value(`delegate`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createAppointmentConfirmationViewController(category: Category, timeSlot: AvailabilitySlot, delegate: AppointmentConfirmationViewModelDelegate). Use given")
			Failure("Stub return value not specified for createAppointmentConfirmationViewController(category: Category, timeSlot: AvailabilitySlot, delegate: AppointmentConfirmationViewModelDelegate). Use given")
		}
		return __value
    }

    open func createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate) -> AppointmentCellViewModel {
        addInvocation(.m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(Parameter<Appointment>.value(`appointment`), Parameter<AppointmentCellViewModelDelegate>.value(`delegate`)))
		let perform = methodPerformValue(.m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(Parameter<Appointment>.value(`appointment`), Parameter<AppointmentCellViewModelDelegate>.value(`delegate`))) as? (Appointment, AppointmentCellViewModelDelegate) -> Void
		perform?(`appointment`, `delegate`)
		var __value: AppointmentCellViewModel
		do {
		    __value = try methodReturnValue(.m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(Parameter<Appointment>.value(`appointment`), Parameter<AppointmentCellViewModelDelegate>.value(`delegate`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate). Use given")
			Failure("Stub return value not specified for createAppointmentCellViewModel(appointment: Appointment, delegate: AppointmentCellViewModelDelegate). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_createCategoryPickerViewController__delegate_delegate(Parameter<CategoryPickerViewModelDelegate>)
        case m_createTimeSlotPickerViewController__category_categorydelegate_delegate(Parameter<Category>, Parameter<TimeSlotPickerViewModelDelegate>)
        case m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(Parameter<Category>, Parameter<AvailabilitySlot>, Parameter<AppointmentConfirmationViewModelDelegate>)
        case m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(Parameter<Appointment>, Parameter<AppointmentCellViewModelDelegate>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createCategoryPickerViewController__delegate_delegate(let lhsDelegate), .m_createCategoryPickerViewController__delegate_delegate(let rhsDelegate)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDelegate, rhs: rhsDelegate, with: matcher), lhsDelegate, rhsDelegate, "delegate"))
				return Matcher.ComparisonResult(results)

            case (.m_createTimeSlotPickerViewController__category_categorydelegate_delegate(let lhsCategory, let lhsDelegate), .m_createTimeSlotPickerViewController__category_categorydelegate_delegate(let rhsCategory, let rhsDelegate)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDelegate, rhs: rhsDelegate, with: matcher), lhsDelegate, rhsDelegate, "delegate"))
				return Matcher.ComparisonResult(results)

            case (.m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(let lhsCategory, let lhsTimeslot, let lhsDelegate), .m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(let rhsCategory, let rhsTimeslot, let rhsDelegate)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTimeslot, rhs: rhsTimeslot, with: matcher), lhsTimeslot, rhsTimeslot, "timeSlot"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDelegate, rhs: rhsDelegate, with: matcher), lhsDelegate, rhsDelegate, "delegate"))
				return Matcher.ComparisonResult(results)

            case (.m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(let lhsAppointment, let lhsDelegate), .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(let rhsAppointment, let rhsDelegate)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAppointment, rhs: rhsAppointment, with: matcher), lhsAppointment, rhsAppointment, "appointment"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDelegate, rhs: rhsDelegate, with: matcher), lhsDelegate, rhsDelegate, "delegate"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_createCategoryPickerViewController__delegate_delegate(p0): return p0.intValue
            case let .m_createTimeSlotPickerViewController__category_categorydelegate_delegate(p0, p1): return p0.intValue + p1.intValue
            case let .m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createCategoryPickerViewController__delegate_delegate: return ".createCategoryPickerViewController(delegate:)"
            case .m_createTimeSlotPickerViewController__category_categorydelegate_delegate: return ".createTimeSlotPickerViewController(category:delegate:)"
            case .m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate: return ".createAppointmentConfirmationViewController(category:timeSlot:delegate:)"
            case .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate: return ".createAppointmentCellViewModel(appointment:delegate:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func createCategoryPickerViewController(delegate: Parameter<CategoryPickerViewModelDelegate>, willReturn: UIViewController...) -> MethodStub {
            return Given(method: .m_createCategoryPickerViewController__delegate_delegate(`delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createTimeSlotPickerViewController(category: Parameter<Category>, delegate: Parameter<TimeSlotPickerViewModelDelegate>, willReturn: UIViewController...) -> MethodStub {
            return Given(method: .m_createTimeSlotPickerViewController__category_categorydelegate_delegate(`category`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createAppointmentConfirmationViewController(category: Parameter<Category>, timeSlot: Parameter<AvailabilitySlot>, delegate: Parameter<AppointmentConfirmationViewModelDelegate>, willReturn: UIViewController...) -> MethodStub {
            return Given(method: .m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(`category`, `timeSlot`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createAppointmentCellViewModel(appointment: Parameter<Appointment>, delegate: Parameter<AppointmentCellViewModelDelegate>, willReturn: AppointmentCellViewModel...) -> MethodStub {
            return Given(method: .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(`appointment`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createCategoryPickerViewController(delegate: Parameter<CategoryPickerViewModelDelegate>, willProduce: (Stubber<UIViewController>) -> Void) -> MethodStub {
            let willReturn: [UIViewController] = []
			let given: Given = { return Given(method: .m_createCategoryPickerViewController__delegate_delegate(`delegate`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UIViewController).self)
			willProduce(stubber)
			return given
        }
        public static func createTimeSlotPickerViewController(category: Parameter<Category>, delegate: Parameter<TimeSlotPickerViewModelDelegate>, willProduce: (Stubber<UIViewController>) -> Void) -> MethodStub {
            let willReturn: [UIViewController] = []
			let given: Given = { return Given(method: .m_createTimeSlotPickerViewController__category_categorydelegate_delegate(`category`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UIViewController).self)
			willProduce(stubber)
			return given
        }
        public static func createAppointmentConfirmationViewController(category: Parameter<Category>, timeSlot: Parameter<AvailabilitySlot>, delegate: Parameter<AppointmentConfirmationViewModelDelegate>, willProduce: (Stubber<UIViewController>) -> Void) -> MethodStub {
            let willReturn: [UIViewController] = []
			let given: Given = { return Given(method: .m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(`category`, `timeSlot`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UIViewController).self)
			willProduce(stubber)
			return given
        }
        public static func createAppointmentCellViewModel(appointment: Parameter<Appointment>, delegate: Parameter<AppointmentCellViewModelDelegate>, willProduce: (Stubber<AppointmentCellViewModel>) -> Void) -> MethodStub {
            let willReturn: [AppointmentCellViewModel] = []
			let given: Given = { return Given(method: .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(`appointment`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AppointmentCellViewModel).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createCategoryPickerViewController(delegate: Parameter<CategoryPickerViewModelDelegate>) -> Verify { return Verify(method: .m_createCategoryPickerViewController__delegate_delegate(`delegate`))}
        public static func createTimeSlotPickerViewController(category: Parameter<Category>, delegate: Parameter<TimeSlotPickerViewModelDelegate>) -> Verify { return Verify(method: .m_createTimeSlotPickerViewController__category_categorydelegate_delegate(`category`, `delegate`))}
        public static func createAppointmentConfirmationViewController(category: Parameter<Category>, timeSlot: Parameter<AvailabilitySlot>, delegate: Parameter<AppointmentConfirmationViewModelDelegate>) -> Verify { return Verify(method: .m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(`category`, `timeSlot`, `delegate`))}
        public static func createAppointmentCellViewModel(appointment: Parameter<Appointment>, delegate: Parameter<AppointmentCellViewModelDelegate>) -> Verify { return Verify(method: .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(`appointment`, `delegate`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createCategoryPickerViewController(delegate: Parameter<CategoryPickerViewModelDelegate>, perform: @escaping (CategoryPickerViewModelDelegate) -> Void) -> Perform {
            return Perform(method: .m_createCategoryPickerViewController__delegate_delegate(`delegate`), performs: perform)
        }
        public static func createTimeSlotPickerViewController(category: Parameter<Category>, delegate: Parameter<TimeSlotPickerViewModelDelegate>, perform: @escaping (Category, TimeSlotPickerViewModelDelegate) -> Void) -> Perform {
            return Perform(method: .m_createTimeSlotPickerViewController__category_categorydelegate_delegate(`category`, `delegate`), performs: perform)
        }
        public static func createAppointmentConfirmationViewController(category: Parameter<Category>, timeSlot: Parameter<AvailabilitySlot>, delegate: Parameter<AppointmentConfirmationViewModelDelegate>, perform: @escaping (Category, AvailabilitySlot, AppointmentConfirmationViewModelDelegate) -> Void) -> Perform {
            return Perform(method: .m_createAppointmentConfirmationViewController__category_categorytimeSlot_timeSlotdelegate_delegate(`category`, `timeSlot`, `delegate`), performs: perform)
        }
        public static func createAppointmentCellViewModel(appointment: Parameter<Appointment>, delegate: Parameter<AppointmentCellViewModelDelegate>, perform: @escaping (Appointment, AppointmentCellViewModelDelegate) -> Void) -> Perform {
            return Perform(method: .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(`appointment`, `delegate`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

// MARK: - TimeSlotPickerViewModel

open class TimeSlotPickerViewModelMock: TimeSlotPickerViewModel, Mock {
    public init(sequencing sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst, stubbing stubbingPolicy: StubbingPolicy = .wrap, file: StaticString = #file, line: UInt = #line) {
        SwiftyMockyTestObserver.setup()
        self.sequencingPolicy = sequencingPolicy
        self.stubbingPolicy = stubbingPolicy
        self.file = file
        self.line = line
    }

    var matcher: Matcher = Matcher.default
    var stubbingPolicy: StubbingPolicy = .wrap
    var sequencingPolicy: SequencingPolicy = .lastWrittenResolvedFirst

    private var queue = DispatchQueue(label: "com.swiftymocky.invocations", qos: .userInteractive)
    private var invocations: [MethodType] = []
    private var methodReturnValues: [Given] = []
    private var methodPerformValues: [Perform] = []
    private var file: StaticString?
    private var line: UInt?

    public typealias PropertyStub = Given
    public typealias MethodStub = Given
    public typealias SubscriptStub = Given

    /// Convenience method - call setupMock() to extend debug information when failure occurs
    public func setupMock(file: StaticString = #file, line: UInt = #line) {
        self.file = file
        self.line = line
    }

    /// Clear mock internals. You can specify what to reset (invocations aka verify, givens or performs) or leave it empty to clear all mock internals
    public func resetMock(_ scopes: MockScope...) {
        let scopes: [MockScope] = scopes.isEmpty ? [.invocation, .given, .perform] : scopes
        if scopes.contains(.invocation) { invocations = [] }
        if scopes.contains(.given) { methodReturnValues = [] }
        if scopes.contains(.perform) { methodPerformValues = [] }
    }

    public var isLoading: Bool {
		get {	invocations.append(.p_isLoading_get); return __p_isLoading ?? givenGetterValue(.p_isLoading_get, "TimeSlotPickerViewModelMock - stub value for isLoading was not defined") }
	}
	private var __p_isLoading: (Bool)?

    public var groups: [TimeSlotGroupViewItem] {
		get {	invocations.append(.p_groups_get); return __p_groups ?? givenGetterValue(.p_groups_get, "TimeSlotPickerViewModelMock - stub value for groups was not defined") }
	}
	private var __p_groups: ([TimeSlotGroupViewItem])?

    public var canContinue: Bool {
		get {	invocations.append(.p_canContinue_get); return __p_canContinue ?? givenGetterValue(.p_canContinue_get, "TimeSlotPickerViewModelMock - stub value for canContinue was not defined") }
	}
	private var __p_canContinue: (Bool)?

    public var error: AlertViewModel? {
		get {	invocations.append(.p_error_get); return __p_error ?? optionalGivenGetterValue(.p_error_get, "TimeSlotPickerViewModelMock - stub value for error was not defined") }
		set {	invocations.append(.p_error_set(.value(newValue))); __p_error = newValue }
	}
	private var __p_error: (AlertViewModel)?





    open func userDidPullToRefresh() {
        addInvocation(.m_userDidPullToRefresh)
		let perform = methodPerformValue(.m_userDidPullToRefresh) as? () -> Void
		perform?()
    }

    open func userDidReachEndOfList() {
        addInvocation(.m_userDidReachEndOfList)
		let perform = methodPerformValue(.m_userDidReachEndOfList) as? () -> Void
		perform?()
    }

    open func userDidTapGroup(_ group: TimeSlotGroupViewItem, at index: Int) {
        addInvocation(.m_userDidTapGroup__groupat_index(Parameter<TimeSlotGroupViewItem>.value(`group`), Parameter<Int>.value(`index`)))
		let perform = methodPerformValue(.m_userDidTapGroup__groupat_index(Parameter<TimeSlotGroupViewItem>.value(`group`), Parameter<Int>.value(`index`))) as? (TimeSlotGroupViewItem, Int) -> Void
		perform?(`group`, `index`)
    }

    open func userDidTapTimeSlot(_ timeSlot: TimeSlotViewItem, at timeSlotIndex: Int, in group: TimeSlotGroupViewItem, at groupIndex: Int) {
        addInvocation(.m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(Parameter<TimeSlotViewItem>.value(`timeSlot`), Parameter<Int>.value(`timeSlotIndex`), Parameter<TimeSlotGroupViewItem>.value(`group`), Parameter<Int>.value(`groupIndex`)))
		let perform = methodPerformValue(.m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(Parameter<TimeSlotViewItem>.value(`timeSlot`), Parameter<Int>.value(`timeSlotIndex`), Parameter<TimeSlotGroupViewItem>.value(`group`), Parameter<Int>.value(`groupIndex`))) as? (TimeSlotViewItem, Int, TimeSlotGroupViewItem, Int) -> Void
		perform?(`timeSlot`, `timeSlotIndex`, `group`, `groupIndex`)
    }

    open func userDidTapConfirmButton() {
        addInvocation(.m_userDidTapConfirmButton)
		let perform = methodPerformValue(.m_userDidTapConfirmButton) as? () -> Void
		perform?()
    }

    open func onChange() -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange)
		let perform = methodPerformValue(.m_onChange) as? () -> Void
		perform?()
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(). Use given")
			Failure("Stub return value not specified for onChange(). Use given")
		}
		return __value
    }

    open func onChange(throttle: DispatchQueue.SchedulerTimeType.Stride) -> AnyPublisher<Void, Never> {
        addInvocation(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`)))
		let perform = methodPerformValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))) as? (DispatchQueue.SchedulerTimeType.Stride) -> Void
		perform?(`throttle`)
		var __value: AnyPublisher<Void, Never>
		do {
		    __value = try methodReturnValue(.m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>.value(`throttle`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
			Failure("Stub return value not specified for onChange(throttle: DispatchQueue.SchedulerTimeType.Stride). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_userDidPullToRefresh
        case m_userDidReachEndOfList
        case m_userDidTapGroup__groupat_index(Parameter<TimeSlotGroupViewItem>, Parameter<Int>)
        case m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(Parameter<TimeSlotViewItem>, Parameter<Int>, Parameter<TimeSlotGroupViewItem>, Parameter<Int>)
        case m_userDidTapConfirmButton
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_isLoading_get
        case p_groups_get
        case p_canContinue_get
        case p_error_get
		case p_error_set(Parameter<AlertViewModel?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidPullToRefresh, .m_userDidPullToRefresh): return .match

            case (.m_userDidReachEndOfList, .m_userDidReachEndOfList): return .match

            case (.m_userDidTapGroup__groupat_index(let lhsGroup, let lhsIndex), .m_userDidTapGroup__groupat_index(let rhsGroup, let rhsIndex)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsGroup, rhs: rhsGroup, with: matcher), lhsGroup, rhsGroup, "_ group"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIndex, rhs: rhsIndex, with: matcher), lhsIndex, rhsIndex, "at index"))
				return Matcher.ComparisonResult(results)

            case (.m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(let lhsTimeslot, let lhsTimeslotindex, let lhsGroup, let lhsGroupindex), .m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(let rhsTimeslot, let rhsTimeslotindex, let rhsGroup, let rhsGroupindex)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTimeslot, rhs: rhsTimeslot, with: matcher), lhsTimeslot, rhsTimeslot, "_ timeSlot"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTimeslotindex, rhs: rhsTimeslotindex, with: matcher), lhsTimeslotindex, rhsTimeslotindex, "at timeSlotIndex"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsGroup, rhs: rhsGroup, with: matcher), lhsGroup, rhsGroup, "in group"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsGroupindex, rhs: rhsGroupindex, with: matcher), lhsGroupindex, rhsGroupindex, "at groupIndex"))
				return Matcher.ComparisonResult(results)

            case (.m_userDidTapConfirmButton, .m_userDidTapConfirmButton): return .match

            case (.m_onChange, .m_onChange): return .match

            case (.m_onChange__throttle_throttle(let lhsThrottle), .m_onChange__throttle_throttle(let rhsThrottle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsThrottle, rhs: rhsThrottle, with: matcher), lhsThrottle, rhsThrottle, "throttle"))
				return Matcher.ComparisonResult(results)
            case (.p_isLoading_get,.p_isLoading_get): return Matcher.ComparisonResult.match
            case (.p_groups_get,.p_groups_get): return Matcher.ComparisonResult.match
            case (.p_canContinue_get,.p_canContinue_get): return Matcher.ComparisonResult.match
            case (.p_error_get,.p_error_get): return Matcher.ComparisonResult.match
			case (.p_error_set(let left),.p_error_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AlertViewModel?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidPullToRefresh: return 0
            case .m_userDidReachEndOfList: return 0
            case let .m_userDidTapGroup__groupat_index(p0, p1): return p0.intValue + p1.intValue
            case let .m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case .m_userDidTapConfirmButton: return 0
            case .m_onChange: return 0
            case let .m_onChange__throttle_throttle(p0): return p0.intValue
            case .p_isLoading_get: return 0
            case .p_groups_get: return 0
            case .p_canContinue_get: return 0
            case .p_error_get: return 0
			case .p_error_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidPullToRefresh: return ".userDidPullToRefresh()"
            case .m_userDidReachEndOfList: return ".userDidReachEndOfList()"
            case .m_userDidTapGroup__groupat_index: return ".userDidTapGroup(_:at:)"
            case .m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex: return ".userDidTapTimeSlot(_:at:in:at:)"
            case .m_userDidTapConfirmButton: return ".userDidTapConfirmButton()"
            case .m_onChange: return ".onChange()"
            case .m_onChange__throttle_throttle: return ".onChange(throttle:)"
            case .p_isLoading_get: return "[get] .isLoading"
            case .p_groups_get: return "[get] .groups"
            case .p_canContinue_get: return "[get] .canContinue"
            case .p_error_get: return "[get] .error"
			case .p_error_set: return "[set] .error"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func isLoading(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoading_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func groups(getter defaultValue: [TimeSlotGroupViewItem]...) -> PropertyStub {
            return Given(method: .p_groups_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func canContinue(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_canContinue_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func error(getter defaultValue: AlertViewModel?...) -> PropertyStub {
            return Given(method: .p_error_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func onChange(willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willReturn: AnyPublisher<Void, Never>...) -> MethodStub {
            return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func onChange(willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, willProduce: (Stubber<AnyPublisher<Void, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Void, Never>] = []
			let given: Given = { return Given(method: .m_onChange__throttle_throttle(`throttle`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Void, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func userDidPullToRefresh() -> Verify { return Verify(method: .m_userDidPullToRefresh)}
        public static func userDidReachEndOfList() -> Verify { return Verify(method: .m_userDidReachEndOfList)}
        public static func userDidTapGroup(_ group: Parameter<TimeSlotGroupViewItem>, at index: Parameter<Int>) -> Verify { return Verify(method: .m_userDidTapGroup__groupat_index(`group`, `index`))}
        public static func userDidTapTimeSlot(_ timeSlot: Parameter<TimeSlotViewItem>, at timeSlotIndex: Parameter<Int>, in group: Parameter<TimeSlotGroupViewItem>, at groupIndex: Parameter<Int>) -> Verify { return Verify(method: .m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(`timeSlot`, `timeSlotIndex`, `group`, `groupIndex`))}
        public static func userDidTapConfirmButton() -> Verify { return Verify(method: .m_userDidTapConfirmButton)}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var isLoading: Verify { return Verify(method: .p_isLoading_get) }
        public static var groups: Verify { return Verify(method: .p_groups_get) }
        public static var canContinue: Verify { return Verify(method: .p_canContinue_get) }
        public static var error: Verify { return Verify(method: .p_error_get) }
		public static func error(set newValue: Parameter<AlertViewModel?>) -> Verify { return Verify(method: .p_error_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func userDidPullToRefresh(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidPullToRefresh, performs: perform)
        }
        public static func userDidReachEndOfList(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidReachEndOfList, performs: perform)
        }
        public static func userDidTapGroup(_ group: Parameter<TimeSlotGroupViewItem>, at index: Parameter<Int>, perform: @escaping (TimeSlotGroupViewItem, Int) -> Void) -> Perform {
            return Perform(method: .m_userDidTapGroup__groupat_index(`group`, `index`), performs: perform)
        }
        public static func userDidTapTimeSlot(_ timeSlot: Parameter<TimeSlotViewItem>, at timeSlotIndex: Parameter<Int>, in group: Parameter<TimeSlotGroupViewItem>, at groupIndex: Parameter<Int>, perform: @escaping (TimeSlotViewItem, Int, TimeSlotGroupViewItem, Int) -> Void) -> Perform {
            return Perform(method: .m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(`timeSlot`, `timeSlotIndex`, `group`, `groupIndex`), performs: perform)
        }
        public static func userDidTapConfirmButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapConfirmButton, performs: perform)
        }
        public static func onChange(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_onChange, performs: perform)
        }
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>, perform: @escaping (DispatchQueue.SchedulerTimeType.Stride) -> Void) -> Perform {
            return Perform(method: .m_onChange__throttle_throttle(`throttle`), performs: perform)
        }
    }

    public func given(_ method: Given) {
        methodReturnValues.append(method)
    }

    public func perform(_ method: Perform) {
        methodPerformValues.append(method)
        methodPerformValues.sort { $0.method.intValue() < $1.method.intValue() }
    }

    public func verify(_ method: Verify, count: Count = Count.moreOrEqual(to: 1), file: StaticString = #file, line: UInt = #line) {
        let fullMatches = matchingCalls(method, file: file, line: line)
        let success = count.matches(fullMatches)
        let assertionName = method.method.assertionName()
        let feedback: String = {
            guard !success else { return "" }
            return Utils.closestCallsMessage(
                for: self.invocations.map { invocation in
                    matcher.set(file: file, line: line)
                    defer { matcher.clearFileAndLine() }
                    return MethodType.compareParameters(lhs: invocation, rhs: method.method, matcher: matcher)
                },
                name: assertionName
            )
        }()
        MockyAssert(success, "Expected: \(count) invocations of `\(assertionName)`, but was: \(fullMatches).\(feedback)", file: file, line: line)
    }

    private func addInvocation(_ call: MethodType) {
        self.queue.sync { invocations.append(call) }
    }
    private func methodReturnValue(_ method: MethodType) throws -> StubProduct {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let candidates = sequencingPolicy.sorted(methodReturnValues, by: { $0.method.intValue() > $1.method.intValue() })
        let matched = candidates.first(where: { $0.isValid && MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch })
        guard let product = matched?.getProduct(policy: self.stubbingPolicy) else { throw MockError.notStubed }
        return product
    }
    private func methodPerformValue(_ method: MethodType) -> Any? {
        matcher.set(file: self.file, line: self.line)
        defer { matcher.clearFileAndLine() }
        let matched = methodPerformValues.reversed().first { MethodType.compareParameters(lhs: $0.method, rhs: method, matcher: matcher).isFullMatch }
        return matched?.performs
    }
    private func matchingCalls(_ method: MethodType, file: StaticString?, line: UInt?) -> [MethodType] {
        matcher.set(file: file ?? self.file, line: line ?? self.line)
        defer { matcher.clearFileAndLine() }
        return invocations.filter { MethodType.compareParameters(lhs: $0, rhs: method, matcher: matcher).isFullMatch }
    }
    private func matchingCalls(_ method: Verify, file: StaticString?, line: UInt?) -> Int {
        return matchingCalls(method.method, file: file, line: line).count
    }
    private func givenGetterValue<T>(_ method: MethodType, _ message: String) -> T {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            onFatalFailure(message)
            Failure(message)
        }
    }
    private func optionalGivenGetterValue<T>(_ method: MethodType, _ message: String) -> T? {
        do {
            return try methodReturnValue(method).casted()
        } catch {
            return nil
        }
    }
    private func onFatalFailure(_ message: String) {
        guard let file = self.file, let line = self.line else { return } // Let if fail if cannot handle gratefully
        SwiftyMockyTestObserver.handleFatalError(message: message, file: file, line: line)
    }
}

