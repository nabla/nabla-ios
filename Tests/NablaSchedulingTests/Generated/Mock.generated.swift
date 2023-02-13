// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import NablaCore
import Combine
@testable import NablaScheduling


// MARK: - AddressFormatter

open class AddressFormatterMock: AddressFormatter, Mock {
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





    open func format(_ address: Address) -> String {
        addInvocation(.m_format__address(Parameter<Address>.value(`address`)))
		let perform = methodPerformValue(.m_format__address(Parameter<Address>.value(`address`))) as? (Address) -> Void
		perform?(`address`)
		var __value: String
		do {
		    __value = try methodReturnValue(.m_format__address(Parameter<Address>.value(`address`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for format(_ address: Address). Use given")
			Failure("Stub return value not specified for format(_ address: Address). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_format__address(Parameter<Address>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_format__address(let lhsAddress), .m_format__address(let rhsAddress)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsAddress, rhs: rhsAddress, with: matcher), lhsAddress, rhsAddress, "_ address"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_format__address(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_format__address: return ".format(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func format(_ address: Parameter<Address>, willReturn: String...) -> MethodStub {
            return Given(method: .m_format__address(`address`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func format(_ address: Parameter<Address>, willProduce: (Stubber<String>) -> Void) -> MethodStub {
            let willReturn: [String] = []
			let given: Given = { return Given(method: .m_format__address(`address`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (String).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func format(_ address: Parameter<Address>) -> Verify { return Verify(method: .m_format__address(`address`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func format(_ address: Parameter<Address>, perform: @escaping (Address) -> Void) -> Perform {
            return Perform(method: .m_format__address(`address`), performs: perform)
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

    @MainActor
		public var avatar: AvatarViewModel {
		get {	invocations.append(.p_avatar_get); return __p_avatar ?? givenGetterValue(.p_avatar_get, "AppointmentCellViewModelMock - stub value for avatar was not defined") }
	}
	private var __p_avatar: (AvatarViewModel)?

    @MainActor
		public var title: String {
		get {	invocations.append(.p_title_get); return __p_title ?? givenGetterValue(.p_title_get, "AppointmentCellViewModelMock - stub value for title was not defined") }
	}
	private var __p_title: (String)?

    @MainActor
		public var subtitle: String {
		get {	invocations.append(.p_subtitle_get); return __p_subtitle ?? givenGetterValue(.p_subtitle_get, "AppointmentCellViewModelMock - stub value for subtitle was not defined") }
	}
	private var __p_subtitle: (String)?

    @MainActor
		public var enabled: Bool {
		get {	invocations.append(.p_enabled_get); return __p_enabled ?? givenGetterValue(.p_enabled_get, "AppointmentCellViewModelMock - stub value for enabled was not defined") }
	}
	private var __p_enabled: (Bool)?

    @MainActor
		public var primaryActionTitle: String? {
		get {	invocations.append(.p_primaryActionTitle_get); return __p_primaryActionTitle ?? optionalGivenGetterValue(.p_primaryActionTitle_get, "AppointmentCellViewModelMock - stub value for primaryActionTitle was not defined") }
	}
	private var __p_primaryActionTitle: (String)?

    @MainActor
		public var showDisclosureIndicator: Bool {
		get {	invocations.append(.p_showDisclosureIndicator_get); return __p_showDisclosureIndicator ?? givenGetterValue(.p_showDisclosureIndicator_get, "AppointmentCellViewModelMock - stub value for showDisclosureIndicator was not defined") }
	}
	private var __p_showDisclosureIndicator: (Bool)?





    @MainActor
	open func userDidTapPrimaryActionButton() {
        addInvocation(.m_userDidTapPrimaryActionButton)
		let perform = methodPerformValue(.m_userDidTapPrimaryActionButton) as? () -> Void
		perform?()
    }

    @MainActor
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
        case p_showDisclosureIndicator_get

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
            case (.p_showDisclosureIndicator_get,.p_showDisclosureIndicator_get): return Matcher.ComparisonResult.match
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
            case .p_showDisclosureIndicator_get: return 0
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
            case .p_showDisclosureIndicator_get: return "[get] .showDisclosureIndicator"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        @MainActor
		public static func avatar(getter defaultValue: AvatarViewModel...) -> PropertyStub {
            return Given(method: .p_avatar_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func title(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_title_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func subtitle(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_subtitle_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func enabled(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_enabled_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func primaryActionTitle(getter defaultValue: String?...) -> PropertyStub {
            return Given(method: .p_primaryActionTitle_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func showDisclosureIndicator(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_showDisclosureIndicator_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
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

        @MainActor
		public static func userDidTapPrimaryActionButton() -> Verify { return Verify(method: .m_userDidTapPrimaryActionButton)}
        @MainActor
		public static func userDidTapSecondaryActionsButton() -> Verify { return Verify(method: .m_userDidTapSecondaryActionsButton)}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var avatar: Verify { return Verify(method: .p_avatar_get) }
        public static var title: Verify { return Verify(method: .p_title_get) }
        public static var subtitle: Verify { return Verify(method: .p_subtitle_get) }
        public static var enabled: Verify { return Verify(method: .p_enabled_get) }
        public static var primaryActionTitle: Verify { return Verify(method: .p_primaryActionTitle_get) }
        public static var showDisclosureIndicator: Verify { return Verify(method: .p_showDisclosureIndicator_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        @MainActor
		public static func userDidTapPrimaryActionButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapPrimaryActionButton, performs: perform)
        }
        @MainActor
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

    @MainActor
		public var provider: Provider? {
		get {	invocations.append(.p_provider_get); return __p_provider ?? optionalGivenGetterValue(.p_provider_get, "AppointmentConfirmationViewModelMock - stub value for provider was not defined") }
	}
	private var __p_provider: (Provider)?

    @MainActor
		public var caption: String {
		get {	invocations.append(.p_caption_get); return __p_caption ?? givenGetterValue(.p_caption_get, "AppointmentConfirmationViewModelMock - stub value for caption was not defined") }
	}
	private var __p_caption: (String)?

    @MainActor
		public var captionIcon: AppointmentDetailsView.CaptionIcon {
		get {	invocations.append(.p_captionIcon_get); return __p_captionIcon ?? givenGetterValue(.p_captionIcon_get, "AppointmentConfirmationViewModelMock - stub value for captionIcon was not defined") }
	}
	private var __p_captionIcon: (AppointmentDetailsView.CaptionIcon)?

    @MainActor
		public var details1: String? {
		get {	invocations.append(.p_details1_get); return __p_details1 ?? optionalGivenGetterValue(.p_details1_get, "AppointmentConfirmationViewModelMock - stub value for details1 was not defined") }
	}
	private var __p_details1: (String)?

    @MainActor
		public var details2: String? {
		get {	invocations.append(.p_details2_get); return __p_details2 ?? optionalGivenGetterValue(.p_details2_get, "AppointmentConfirmationViewModelMock - stub value for details2 was not defined") }
	}
	private var __p_details2: (String)?

    @MainActor
		public var agreesWithFirstConsent: Bool {
		get {	invocations.append(.p_agreesWithFirstConsent_get); return __p_agreesWithFirstConsent ?? givenGetterValue(.p_agreesWithFirstConsent_get, "AppointmentConfirmationViewModelMock - stub value for agreesWithFirstConsent was not defined") }
		set {	invocations.append(.p_agreesWithFirstConsent_set(.value(newValue))); __p_agreesWithFirstConsent = newValue }
	}
	private var __p_agreesWithFirstConsent: (Bool)?

    @MainActor
		public var agreesWithSecondConsent: Bool {
		get {	invocations.append(.p_agreesWithSecondConsent_get); return __p_agreesWithSecondConsent ?? givenGetterValue(.p_agreesWithSecondConsent_get, "AppointmentConfirmationViewModelMock - stub value for agreesWithSecondConsent was not defined") }
		set {	invocations.append(.p_agreesWithSecondConsent_set(.value(newValue))); __p_agreesWithSecondConsent = newValue }
	}
	private var __p_agreesWithSecondConsent: (Bool)?

    @MainActor
		public var canConfirm: Bool {
		get {	invocations.append(.p_canConfirm_get); return __p_canConfirm ?? givenGetterValue(.p_canConfirm_get, "AppointmentConfirmationViewModelMock - stub value for canConfirm was not defined") }
	}
	private var __p_canConfirm: (Bool)?

    @MainActor
		public var isConfirming: Bool {
		get {	invocations.append(.p_isConfirming_get); return __p_isConfirming ?? givenGetterValue(.p_isConfirming_get, "AppointmentConfirmationViewModelMock - stub value for isConfirming was not defined") }
	}
	private var __p_isConfirming: (Bool)?

    @MainActor
		public var isLoadingConsents: Bool {
		get {	invocations.append(.p_isLoadingConsents_get); return __p_isLoadingConsents ?? givenGetterValue(.p_isLoadingConsents_get, "AppointmentConfirmationViewModelMock - stub value for isLoadingConsents was not defined") }
	}
	private var __p_isLoadingConsents: (Bool)?

    @MainActor
		public var consents: ConsentsViewModel? {
		get {	invocations.append(.p_consents_get); return __p_consents ?? optionalGivenGetterValue(.p_consents_get, "AppointmentConfirmationViewModelMock - stub value for consents was not defined") }
	}
	private var __p_consents: (ConsentsViewModel)?

    @MainActor
		public var consentsLoadingError: ConsentsErrorViewModel? {
		get {	invocations.append(.p_consentsLoadingError_get); return __p_consentsLoadingError ?? optionalGivenGetterValue(.p_consentsLoadingError_get, "AppointmentConfirmationViewModelMock - stub value for consentsLoadingError was not defined") }
	}
	private var __p_consentsLoadingError: (ConsentsErrorViewModel)?

    @MainActor
		public var modal: AppointmentConfirmationModal? {
		get {	invocations.append(.p_modal_get); return __p_modal ?? optionalGivenGetterValue(.p_modal_get, "AppointmentConfirmationViewModelMock - stub value for modal was not defined") }
		set {	invocations.append(.p_modal_set(.value(newValue))); __p_modal = newValue }
	}
	private var __p_modal: (AppointmentConfirmationModal)?





    @MainActor
	open func userDidTapAppointmentDetails() {
        addInvocation(.m_userDidTapAppointmentDetails)
		let perform = methodPerformValue(.m_userDidTapAppointmentDetails) as? () -> Void
		perform?()
    }

    @MainActor
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
        case m_userDidTapAppointmentDetails
        case m_userDidTapConfirmButton
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_provider_get
        case p_caption_get
        case p_captionIcon_get
        case p_details1_get
        case p_details2_get
        case p_agreesWithFirstConsent_get
		case p_agreesWithFirstConsent_set(Parameter<Bool>)
        case p_agreesWithSecondConsent_get
		case p_agreesWithSecondConsent_set(Parameter<Bool>)
        case p_canConfirm_get
        case p_isConfirming_get
        case p_isLoadingConsents_get
        case p_consents_get
        case p_consentsLoadingError_get
        case p_modal_get
		case p_modal_set(Parameter<AppointmentConfirmationModal?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidTapAppointmentDetails, .m_userDidTapAppointmentDetails): return .match

            case (.m_userDidTapConfirmButton, .m_userDidTapConfirmButton): return .match

            case (.m_onChange, .m_onChange): return .match

            case (.m_onChange__throttle_throttle(let lhsThrottle), .m_onChange__throttle_throttle(let rhsThrottle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsThrottle, rhs: rhsThrottle, with: matcher), lhsThrottle, rhsThrottle, "throttle"))
				return Matcher.ComparisonResult(results)
            case (.p_provider_get,.p_provider_get): return Matcher.ComparisonResult.match
            case (.p_caption_get,.p_caption_get): return Matcher.ComparisonResult.match
            case (.p_captionIcon_get,.p_captionIcon_get): return Matcher.ComparisonResult.match
            case (.p_details1_get,.p_details1_get): return Matcher.ComparisonResult.match
            case (.p_details2_get,.p_details2_get): return Matcher.ComparisonResult.match
            case (.p_agreesWithFirstConsent_get,.p_agreesWithFirstConsent_get): return Matcher.ComparisonResult.match
			case (.p_agreesWithFirstConsent_set(let left),.p_agreesWithFirstConsent_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<Bool>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_agreesWithSecondConsent_get,.p_agreesWithSecondConsent_get): return Matcher.ComparisonResult.match
			case (.p_agreesWithSecondConsent_set(let left),.p_agreesWithSecondConsent_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<Bool>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_canConfirm_get,.p_canConfirm_get): return Matcher.ComparisonResult.match
            case (.p_isConfirming_get,.p_isConfirming_get): return Matcher.ComparisonResult.match
            case (.p_isLoadingConsents_get,.p_isLoadingConsents_get): return Matcher.ComparisonResult.match
            case (.p_consents_get,.p_consents_get): return Matcher.ComparisonResult.match
            case (.p_consentsLoadingError_get,.p_consentsLoadingError_get): return Matcher.ComparisonResult.match
            case (.p_modal_get,.p_modal_get): return Matcher.ComparisonResult.match
			case (.p_modal_set(let left),.p_modal_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AppointmentConfirmationModal?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidTapAppointmentDetails: return 0
            case .m_userDidTapConfirmButton: return 0
            case .m_onChange: return 0
            case let .m_onChange__throttle_throttle(p0): return p0.intValue
            case .p_provider_get: return 0
            case .p_caption_get: return 0
            case .p_captionIcon_get: return 0
            case .p_details1_get: return 0
            case .p_details2_get: return 0
            case .p_agreesWithFirstConsent_get: return 0
			case .p_agreesWithFirstConsent_set(let newValue): return newValue.intValue
            case .p_agreesWithSecondConsent_get: return 0
			case .p_agreesWithSecondConsent_set(let newValue): return newValue.intValue
            case .p_canConfirm_get: return 0
            case .p_isConfirming_get: return 0
            case .p_isLoadingConsents_get: return 0
            case .p_consents_get: return 0
            case .p_consentsLoadingError_get: return 0
            case .p_modal_get: return 0
			case .p_modal_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidTapAppointmentDetails: return ".userDidTapAppointmentDetails()"
            case .m_userDidTapConfirmButton: return ".userDidTapConfirmButton()"
            case .m_onChange: return ".onChange()"
            case .m_onChange__throttle_throttle: return ".onChange(throttle:)"
            case .p_provider_get: return "[get] .provider"
            case .p_caption_get: return "[get] .caption"
            case .p_captionIcon_get: return "[get] .captionIcon"
            case .p_details1_get: return "[get] .details1"
            case .p_details2_get: return "[get] .details2"
            case .p_agreesWithFirstConsent_get: return "[get] .agreesWithFirstConsent"
			case .p_agreesWithFirstConsent_set: return "[set] .agreesWithFirstConsent"
            case .p_agreesWithSecondConsent_get: return "[get] .agreesWithSecondConsent"
			case .p_agreesWithSecondConsent_set: return "[set] .agreesWithSecondConsent"
            case .p_canConfirm_get: return "[get] .canConfirm"
            case .p_isConfirming_get: return "[get] .isConfirming"
            case .p_isLoadingConsents_get: return "[get] .isLoadingConsents"
            case .p_consents_get: return "[get] .consents"
            case .p_consentsLoadingError_get: return "[get] .consentsLoadingError"
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

        @MainActor
		public static func provider(getter defaultValue: Provider?...) -> PropertyStub {
            return Given(method: .p_provider_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func caption(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_caption_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func captionIcon(getter defaultValue: AppointmentDetailsView.CaptionIcon...) -> PropertyStub {
            return Given(method: .p_captionIcon_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func details1(getter defaultValue: String?...) -> PropertyStub {
            return Given(method: .p_details1_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func details2(getter defaultValue: String?...) -> PropertyStub {
            return Given(method: .p_details2_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func agreesWithFirstConsent(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_agreesWithFirstConsent_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func agreesWithSecondConsent(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_agreesWithSecondConsent_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func canConfirm(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_canConfirm_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func isConfirming(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isConfirming_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func isLoadingConsents(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoadingConsents_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func consents(getter defaultValue: ConsentsViewModel?...) -> PropertyStub {
            return Given(method: .p_consents_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func consentsLoadingError(getter defaultValue: ConsentsErrorViewModel?...) -> PropertyStub {
            return Given(method: .p_consentsLoadingError_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func modal(getter defaultValue: AppointmentConfirmationModal?...) -> PropertyStub {
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

        @MainActor
		public static func userDidTapAppointmentDetails() -> Verify { return Verify(method: .m_userDidTapAppointmentDetails)}
        @MainActor
		public static func userDidTapConfirmButton() -> Verify { return Verify(method: .m_userDidTapConfirmButton)}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var provider: Verify { return Verify(method: .p_provider_get) }
        public static var caption: Verify { return Verify(method: .p_caption_get) }
        public static var captionIcon: Verify { return Verify(method: .p_captionIcon_get) }
        public static var details1: Verify { return Verify(method: .p_details1_get) }
        public static var details2: Verify { return Verify(method: .p_details2_get) }
        public static var agreesWithFirstConsent: Verify { return Verify(method: .p_agreesWithFirstConsent_get) }
		public static func agreesWithFirstConsent(set newValue: Parameter<Bool>) -> Verify { return Verify(method: .p_agreesWithFirstConsent_set(newValue)) }
        public static var agreesWithSecondConsent: Verify { return Verify(method: .p_agreesWithSecondConsent_get) }
		public static func agreesWithSecondConsent(set newValue: Parameter<Bool>) -> Verify { return Verify(method: .p_agreesWithSecondConsent_set(newValue)) }
        public static var canConfirm: Verify { return Verify(method: .p_canConfirm_get) }
        public static var isConfirming: Verify { return Verify(method: .p_isConfirming_get) }
        public static var isLoadingConsents: Verify { return Verify(method: .p_isLoadingConsents_get) }
        public static var consents: Verify { return Verify(method: .p_consents_get) }
        public static var consentsLoadingError: Verify { return Verify(method: .p_consentsLoadingError_get) }
        public static var modal: Verify { return Verify(method: .p_modal_get) }
		public static func modal(set newValue: Parameter<AppointmentConfirmationModal?>) -> Verify { return Verify(method: .p_modal_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        @MainActor
		public static func userDidTapAppointmentDetails(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapAppointmentDetails, performs: perform)
        }
        @MainActor
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

// MARK: - AppointmentDetailsViewModel

open class AppointmentDetailsViewModelMock: AppointmentDetailsViewModel, Mock {
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

    @MainActor
		public var modal: AppointmentDetailsModal? {
		get {	invocations.append(.p_modal_get); return __p_modal ?? optionalGivenGetterValue(.p_modal_get, "AppointmentDetailsViewModelMock - stub value for modal was not defined") }
		set {	invocations.append(.p_modal_set(.value(newValue))); __p_modal = newValue }
	}
	private var __p_modal: (AppointmentDetailsModal)?

    @MainActor
		public var state: AppointmentsDetailsViewState {
		get {	invocations.append(.p_state_get); return __p_state ?? givenGetterValue(.p_state_get, "AppointmentDetailsViewModelMock - stub value for state was not defined") }
	}
	private var __p_state: (AppointmentsDetailsViewState)?





    @MainActor
	open func userDidTapAppointmentDetails() {
        addInvocation(.m_userDidTapAppointmentDetails)
		let perform = methodPerformValue(.m_userDidTapAppointmentDetails) as? () -> Void
		perform?()
    }

    @MainActor
	open func userDidTapCancelButton() {
        addInvocation(.m_userDidTapCancelButton)
		let perform = methodPerformValue(.m_userDidTapCancelButton) as? () -> Void
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
        case m_userDidTapAppointmentDetails
        case m_userDidTapCancelButton
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_modal_get
		case p_modal_set(Parameter<AppointmentDetailsModal?>)
        case p_state_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidTapAppointmentDetails, .m_userDidTapAppointmentDetails): return .match

            case (.m_userDidTapCancelButton, .m_userDidTapCancelButton): return .match

            case (.m_onChange, .m_onChange): return .match

            case (.m_onChange__throttle_throttle(let lhsThrottle), .m_onChange__throttle_throttle(let rhsThrottle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsThrottle, rhs: rhsThrottle, with: matcher), lhsThrottle, rhsThrottle, "throttle"))
				return Matcher.ComparisonResult(results)
            case (.p_modal_get,.p_modal_get): return Matcher.ComparisonResult.match
			case (.p_modal_set(let left),.p_modal_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AppointmentDetailsModal?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_state_get,.p_state_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidTapAppointmentDetails: return 0
            case .m_userDidTapCancelButton: return 0
            case .m_onChange: return 0
            case let .m_onChange__throttle_throttle(p0): return p0.intValue
            case .p_modal_get: return 0
			case .p_modal_set(let newValue): return newValue.intValue
            case .p_state_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidTapAppointmentDetails: return ".userDidTapAppointmentDetails()"
            case .m_userDidTapCancelButton: return ".userDidTapCancelButton()"
            case .m_onChange: return ".onChange()"
            case .m_onChange__throttle_throttle: return ".onChange(throttle:)"
            case .p_modal_get: return "[get] .modal"
			case .p_modal_set: return "[set] .modal"
            case .p_state_get: return "[get] .state"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        @MainActor
		public static func modal(getter defaultValue: AppointmentDetailsModal?...) -> PropertyStub {
            return Given(method: .p_modal_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func state(getter defaultValue: AppointmentsDetailsViewState...) -> PropertyStub {
            return Given(method: .p_state_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
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

        @MainActor
		public static func userDidTapAppointmentDetails() -> Verify { return Verify(method: .m_userDidTapAppointmentDetails)}
        @MainActor
		public static func userDidTapCancelButton() -> Verify { return Verify(method: .m_userDidTapCancelButton)}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var modal: Verify { return Verify(method: .p_modal_get) }
		public static func modal(set newValue: Parameter<AppointmentDetailsModal?>) -> Verify { return Verify(method: .p_modal_set(newValue)) }
        public static var state: Verify { return Verify(method: .p_state_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        @MainActor
		public static func userDidTapAppointmentDetails(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapAppointmentDetails, performs: perform)
        }
        @MainActor
		public static func userDidTapCancelButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapCancelButton, performs: perform)
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

    @MainActor
		public var selectedSelector: AppointmentsSelector {
		get {	invocations.append(.p_selectedSelector_get); return __p_selectedSelector ?? givenGetterValue(.p_selectedSelector_get, "AppointmentListViewModelMock - stub value for selectedSelector was not defined") }
		set {	invocations.append(.p_selectedSelector_set(.value(newValue))); __p_selectedSelector = newValue }
	}
	private var __p_selectedSelector: (AppointmentsSelector)?

    @MainActor
		public var appointments: [Appointment] {
		get {	invocations.append(.p_appointments_get); return __p_appointments ?? givenGetterValue(.p_appointments_get, "AppointmentListViewModelMock - stub value for appointments was not defined") }
	}
	private var __p_appointments: ([Appointment])?

    @MainActor
		public var isLoading: Bool {
		get {	invocations.append(.p_isLoading_get); return __p_isLoading ?? givenGetterValue(.p_isLoading_get, "AppointmentListViewModelMock - stub value for isLoading was not defined") }
	}
	private var __p_isLoading: (Bool)?

    @MainActor
		public var isRefreshing: Bool {
		get {	invocations.append(.p_isRefreshing_get); return __p_isRefreshing ?? givenGetterValue(.p_isRefreshing_get, "AppointmentListViewModelMock - stub value for isRefreshing was not defined") }
	}
	private var __p_isRefreshing: (Bool)?

    @MainActor
		public var alert: AlertViewModel? {
		get {	invocations.append(.p_alert_get); return __p_alert ?? optionalGivenGetterValue(.p_alert_get, "AppointmentListViewModelMock - stub value for alert was not defined") }
		set {	invocations.append(.p_alert_set(.value(newValue))); __p_alert = newValue }
	}
	private var __p_alert: (AlertViewModel)?

    @MainActor
		public var videoCallRoom: Location.RemoteLocation.VideoCallRoom? {
		get {	invocations.append(.p_videoCallRoom_get); return __p_videoCallRoom ?? optionalGivenGetterValue(.p_videoCallRoom_get, "AppointmentListViewModelMock - stub value for videoCallRoom was not defined") }
		set {	invocations.append(.p_videoCallRoom_set(.value(newValue))); __p_videoCallRoom = newValue }
	}
	private var __p_videoCallRoom: (Location.RemoteLocation.VideoCallRoom)?

    @MainActor
		public var externalCallURL: URL? {
		get {	invocations.append(.p_externalCallURL_get); return __p_externalCallURL ?? optionalGivenGetterValue(.p_externalCallURL_get, "AppointmentListViewModelMock - stub value for externalCallURL was not defined") }
		set {	invocations.append(.p_externalCallURL_set(.value(newValue))); __p_externalCallURL = newValue }
	}
	private var __p_externalCallURL: (URL)?





    @MainActor
	open func userDidReachEndOfList() {
        addInvocation(.m_userDidReachEndOfList)
		let perform = methodPerformValue(.m_userDidReachEndOfList) as? () -> Void
		perform?()
    }

    @MainActor
	open func userDidTapCreateAppointmentButton() {
        addInvocation(.m_userDidTapCreateAppointmentButton)
		let perform = methodPerformValue(.m_userDidTapCreateAppointmentButton) as? () -> Void
		perform?()
    }

    @MainActor
	open func userDidSelectAppointment(atIndex index: Int) {
        addInvocation(.m_userDidSelectAppointment__atIndex_index(Parameter<Int>.value(`index`)))
		let perform = methodPerformValue(.m_userDidSelectAppointment__atIndex_index(Parameter<Int>.value(`index`))) as? (Int) -> Void
		perform?(`index`)
    }

    open func appointmentCellViewModel(_ viewModel: AppointmentCellViewModel, didTapJoinVideoCall room: Location.RemoteLocation.VideoCallRoom) {
        addInvocation(.m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(Parameter<AppointmentCellViewModel>.value(`viewModel`), Parameter<Location.RemoteLocation.VideoCallRoom>.value(`room`)))
		let perform = methodPerformValue(.m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(Parameter<AppointmentCellViewModel>.value(`viewModel`), Parameter<Location.RemoteLocation.VideoCallRoom>.value(`room`))) as? (AppointmentCellViewModel, Location.RemoteLocation.VideoCallRoom) -> Void
		perform?(`viewModel`, `room`)
    }

    open func appointmentCellViewModel(_ viewModel: AppointmentCellViewModel, didTapJoinExternalCallURL url: URL) {
        addInvocation(.m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url(Parameter<AppointmentCellViewModel>.value(`viewModel`), Parameter<URL>.value(`url`)))
		let perform = methodPerformValue(.m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url(Parameter<AppointmentCellViewModel>.value(`viewModel`), Parameter<URL>.value(`url`))) as? (AppointmentCellViewModel, URL) -> Void
		perform?(`viewModel`, `url`)
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
        case m_userDidSelectAppointment__atIndex_index(Parameter<Int>)
        case m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(Parameter<AppointmentCellViewModel>, Parameter<Location.RemoteLocation.VideoCallRoom>)
        case m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url(Parameter<AppointmentCellViewModel>, Parameter<URL>)
        case m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(Parameter<AppointmentCellViewModel>, Parameter<Appointment>)
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_selectedSelector_get
		case p_selectedSelector_set(Parameter<AppointmentsSelector>)
        case p_appointments_get
        case p_isLoading_get
        case p_isRefreshing_get
        case p_alert_get
		case p_alert_set(Parameter<AlertViewModel?>)
        case p_videoCallRoom_get
		case p_videoCallRoom_set(Parameter<Location.RemoteLocation.VideoCallRoom?>)
        case p_externalCallURL_get
		case p_externalCallURL_set(Parameter<URL?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidReachEndOfList, .m_userDidReachEndOfList): return .match

            case (.m_userDidTapCreateAppointmentButton, .m_userDidTapCreateAppointmentButton): return .match

            case (.m_userDidSelectAppointment__atIndex_index(let lhsIndex), .m_userDidSelectAppointment__atIndex_index(let rhsIndex)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIndex, rhs: rhsIndex, with: matcher), lhsIndex, rhsIndex, "atIndex index"))
				return Matcher.ComparisonResult(results)

            case (.m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(let lhsViewmodel, let lhsRoom), .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(let rhsViewmodel, let rhsRoom)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsViewmodel, rhs: rhsViewmodel, with: matcher), lhsViewmodel, rhsViewmodel, "_ viewModel"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRoom, rhs: rhsRoom, with: matcher), lhsRoom, rhsRoom, "didTapJoinVideoCall room"))
				return Matcher.ComparisonResult(results)

            case (.m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url(let lhsViewmodel, let lhsUrl), .m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url(let rhsViewmodel, let rhsUrl)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsViewmodel, rhs: rhsViewmodel, with: matcher), lhsViewmodel, rhsViewmodel, "_ viewModel"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher), lhsUrl, rhsUrl, "didTapJoinExternalCallURL url"))
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
            case (.p_isRefreshing_get,.p_isRefreshing_get): return Matcher.ComparisonResult.match
            case (.p_alert_get,.p_alert_get): return Matcher.ComparisonResult.match
			case (.p_alert_set(let left),.p_alert_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<AlertViewModel?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_videoCallRoom_get,.p_videoCallRoom_get): return Matcher.ComparisonResult.match
			case (.p_videoCallRoom_set(let left),.p_videoCallRoom_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<Location.RemoteLocation.VideoCallRoom?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            case (.p_externalCallURL_get,.p_externalCallURL_get): return Matcher.ComparisonResult.match
			case (.p_externalCallURL_set(let left),.p_externalCallURL_set(let right)): return Matcher.ComparisonResult([Matcher.ParameterComparisonResult(Parameter<URL?>.compare(lhs: left, rhs: right, with: matcher), left, right, "newValue")])
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidReachEndOfList: return 0
            case .m_userDidTapCreateAppointmentButton: return 0
            case let .m_userDidSelectAppointment__atIndex_index(p0): return p0.intValue
            case let .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(p0, p1): return p0.intValue + p1.intValue
            case let .m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url(p0, p1): return p0.intValue + p1.intValue
            case let .m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(p0, p1): return p0.intValue + p1.intValue
            case .m_onChange: return 0
            case let .m_onChange__throttle_throttle(p0): return p0.intValue
            case .p_selectedSelector_get: return 0
			case .p_selectedSelector_set(let newValue): return newValue.intValue
            case .p_appointments_get: return 0
            case .p_isLoading_get: return 0
            case .p_isRefreshing_get: return 0
            case .p_alert_get: return 0
			case .p_alert_set(let newValue): return newValue.intValue
            case .p_videoCallRoom_get: return 0
			case .p_videoCallRoom_set(let newValue): return newValue.intValue
            case .p_externalCallURL_get: return 0
			case .p_externalCallURL_set(let newValue): return newValue.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidReachEndOfList: return ".userDidReachEndOfList()"
            case .m_userDidTapCreateAppointmentButton: return ".userDidTapCreateAppointmentButton()"
            case .m_userDidSelectAppointment__atIndex_index: return ".userDidSelectAppointment(atIndex:)"
            case .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room: return ".appointmentCellViewModel(_:didTapJoinVideoCall:)"
            case .m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url: return ".appointmentCellViewModel(_:didTapJoinExternalCallURL:)"
            case .m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment: return ".appointmentCellViewModel(_:didTapSecondaryActionsButtonFor:)"
            case .m_onChange: return ".onChange()"
            case .m_onChange__throttle_throttle: return ".onChange(throttle:)"
            case .p_selectedSelector_get: return "[get] .selectedSelector"
			case .p_selectedSelector_set: return "[set] .selectedSelector"
            case .p_appointments_get: return "[get] .appointments"
            case .p_isLoading_get: return "[get] .isLoading"
            case .p_isRefreshing_get: return "[get] .isRefreshing"
            case .p_alert_get: return "[get] .alert"
			case .p_alert_set: return "[set] .alert"
            case .p_videoCallRoom_get: return "[get] .videoCallRoom"
			case .p_videoCallRoom_set: return "[set] .videoCallRoom"
            case .p_externalCallURL_get: return "[get] .externalCallURL"
			case .p_externalCallURL_set: return "[set] .externalCallURL"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        @MainActor
		public static func selectedSelector(getter defaultValue: AppointmentsSelector...) -> PropertyStub {
            return Given(method: .p_selectedSelector_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func appointments(getter defaultValue: [Appointment]...) -> PropertyStub {
            return Given(method: .p_appointments_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func isLoading(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoading_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func isRefreshing(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isRefreshing_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func alert(getter defaultValue: AlertViewModel?...) -> PropertyStub {
            return Given(method: .p_alert_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func videoCallRoom(getter defaultValue: Location.RemoteLocation.VideoCallRoom?...) -> PropertyStub {
            return Given(method: .p_videoCallRoom_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func externalCallURL(getter defaultValue: URL?...) -> PropertyStub {
            return Given(method: .p_externalCallURL_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
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

        @MainActor
		public static func userDidReachEndOfList() -> Verify { return Verify(method: .m_userDidReachEndOfList)}
        @MainActor
		public static func userDidTapCreateAppointmentButton() -> Verify { return Verify(method: .m_userDidTapCreateAppointmentButton)}
        @MainActor
		public static func userDidSelectAppointment(atIndex index: Parameter<Int>) -> Verify { return Verify(method: .m_userDidSelectAppointment__atIndex_index(`index`))}
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapJoinVideoCall room: Parameter<Location.RemoteLocation.VideoCallRoom>) -> Verify { return Verify(method: .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(`viewModel`, `room`))}
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapJoinExternalCallURL url: Parameter<URL>) -> Verify { return Verify(method: .m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url(`viewModel`, `url`))}
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapSecondaryActionsButtonFor appointment: Parameter<Appointment>) -> Verify { return Verify(method: .m_appointmentCellViewModel__viewModeldidTapSecondaryActionsButtonFor_appointment(`viewModel`, `appointment`))}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var selectedSelector: Verify { return Verify(method: .p_selectedSelector_get) }
		public static func selectedSelector(set newValue: Parameter<AppointmentsSelector>) -> Verify { return Verify(method: .p_selectedSelector_set(newValue)) }
        public static var appointments: Verify { return Verify(method: .p_appointments_get) }
        public static var isLoading: Verify { return Verify(method: .p_isLoading_get) }
        public static var isRefreshing: Verify { return Verify(method: .p_isRefreshing_get) }
        public static var alert: Verify { return Verify(method: .p_alert_get) }
		public static func alert(set newValue: Parameter<AlertViewModel?>) -> Verify { return Verify(method: .p_alert_set(newValue)) }
        public static var videoCallRoom: Verify { return Verify(method: .p_videoCallRoom_get) }
		public static func videoCallRoom(set newValue: Parameter<Location.RemoteLocation.VideoCallRoom?>) -> Verify { return Verify(method: .p_videoCallRoom_set(newValue)) }
        public static var externalCallURL: Verify { return Verify(method: .p_externalCallURL_get) }
		public static func externalCallURL(set newValue: Parameter<URL?>) -> Verify { return Verify(method: .p_externalCallURL_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        @MainActor
		public static func userDidReachEndOfList(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidReachEndOfList, performs: perform)
        }
        @MainActor
		public static func userDidTapCreateAppointmentButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapCreateAppointmentButton, performs: perform)
        }
        @MainActor
		public static func userDidSelectAppointment(atIndex index: Parameter<Int>, perform: @escaping (Int) -> Void) -> Perform {
            return Perform(method: .m_userDidSelectAppointment__atIndex_index(`index`), performs: perform)
        }
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapJoinVideoCall room: Parameter<Location.RemoteLocation.VideoCallRoom>, perform: @escaping (AppointmentCellViewModel, Location.RemoteLocation.VideoCallRoom) -> Void) -> Perform {
            return Perform(method: .m_appointmentCellViewModel__viewModeldidTapJoinVideoCall_room(`viewModel`, `room`), performs: perform)
        }
        public static func appointmentCellViewModel(_ viewModel: Parameter<AppointmentCellViewModel>, didTapJoinExternalCallURL url: Parameter<URL>, perform: @escaping (AppointmentCellViewModel, URL) -> Void) -> Perform {
            return Perform(method: .m_appointmentCellViewModel__viewModeldidTapJoinExternalCallURL_url(`viewModel`, `url`), performs: perform)
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

    @MainActor
		public var isLoading: Bool {
		get {	invocations.append(.p_isLoading_get); return __p_isLoading ?? givenGetterValue(.p_isLoading_get, "CategoryPickerViewModelMock - stub value for isLoading was not defined") }
	}
	private var __p_isLoading: (Bool)?

    @MainActor
		public var disclaimer: String? {
		get {	invocations.append(.p_disclaimer_get); return __p_disclaimer ?? optionalGivenGetterValue(.p_disclaimer_get, "CategoryPickerViewModelMock - stub value for disclaimer was not defined") }
	}
	private var __p_disclaimer: (String)?

    @MainActor
		public var items: [CategoryViewItem] {
		get {	invocations.append(.p_items_get); return __p_items ?? givenGetterValue(.p_items_get, "CategoryPickerViewModelMock - stub value for items was not defined") }
	}
	private var __p_items: ([CategoryViewItem])?

    @MainActor
		public var error: AlertViewModel? {
		get {	invocations.append(.p_error_get); return __p_error ?? optionalGivenGetterValue(.p_error_get, "CategoryPickerViewModelMock - stub value for error was not defined") }
		set {	invocations.append(.p_error_set(.value(newValue))); __p_error = newValue }
	}
	private var __p_error: (AlertViewModel)?





    @MainActor
	open func userDidPullToRefresh() {
        addInvocation(.m_userDidPullToRefresh)
		let perform = methodPerformValue(.m_userDidPullToRefresh) as? () -> Void
		perform?()
    }

    @MainActor
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
        case p_disclaimer_get
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
            case (.p_disclaimer_get,.p_disclaimer_get): return Matcher.ComparisonResult.match
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
            case .p_disclaimer_get: return 0
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
            case .p_disclaimer_get: return "[get] .disclaimer"
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

        @MainActor
		public static func isLoading(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoading_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func disclaimer(getter defaultValue: String?...) -> PropertyStub {
            return Given(method: .p_disclaimer_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func items(getter defaultValue: [CategoryViewItem]...) -> PropertyStub {
            return Given(method: .p_items_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
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

        @MainActor
		public static func userDidPullToRefresh() -> Verify { return Verify(method: .m_userDidPullToRefresh)}
        @MainActor
		public static func userDidSelect(category: Parameter<CategoryViewItem>, at index: Parameter<Int>) -> Verify { return Verify(method: .m_userDidSelect__category_categoryat_index(`category`, `index`))}
        public static func onChange() -> Verify { return Verify(method: .m_onChange)}
        public static func onChange(throttle: Parameter<DispatchQueue.SchedulerTimeType.Stride>) -> Verify { return Verify(method: .m_onChange__throttle_throttle(`throttle`))}
        public static var isLoading: Verify { return Verify(method: .p_isLoading_get) }
        public static var disclaimer: Verify { return Verify(method: .p_disclaimer_get) }
        public static var items: Verify { return Verify(method: .p_items_get) }
        public static var error: Verify { return Verify(method: .p_error_get) }
		public static func error(set newValue: Parameter<AlertViewModel?>) -> Verify { return Verify(method: .p_error_set(newValue)) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        @MainActor
		public static func userDidPullToRefresh(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidPullToRefresh, performs: perform)
        }
        @MainActor
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

// MARK: - ConsentsRemoteDataSource

open class ConsentsRemoteDataSourceMock: ConsentsRemoteDataSource, Mock {
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





    open func watchConsents() -> AnyPublisher<RemoteConsents, GQLError> {
        addInvocation(.m_watchConsents)
		let perform = methodPerformValue(.m_watchConsents) as? () -> Void
		perform?()
		var __value: AnyPublisher<RemoteConsents, GQLError>
		do {
		    __value = try methodReturnValue(.m_watchConsents).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConsents(). Use given")
			Failure("Stub return value not specified for watchConsents(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_watchConsents

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_watchConsents, .m_watchConsents): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_watchConsents: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_watchConsents: return ".watchConsents()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func watchConsents(willReturn: AnyPublisher<RemoteConsents, GQLError>...) -> MethodStub {
            return Given(method: .m_watchConsents, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConsents(willProduce: (Stubber<AnyPublisher<RemoteConsents, GQLError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<RemoteConsents, GQLError>] = []
			let given: Given = { return Given(method: .m_watchConsents, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<RemoteConsents, GQLError>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func watchConsents() -> Verify { return Verify(method: .m_watchConsents)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func watchConsents(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_watchConsents, performs: perform)
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





    open func createLocationPickerViewController(delegate: LocationPickerViewModelDelegate) -> UIViewController {
        addInvocation(.m_createLocationPickerViewController__delegate_delegate(Parameter<LocationPickerViewModelDelegate>.value(`delegate`)))
		let perform = methodPerformValue(.m_createLocationPickerViewController__delegate_delegate(Parameter<LocationPickerViewModelDelegate>.value(`delegate`))) as? (LocationPickerViewModelDelegate) -> Void
		perform?(`delegate`)
		var __value: UIViewController
		do {
		    __value = try methodReturnValue(.m_createLocationPickerViewController__delegate_delegate(Parameter<LocationPickerViewModelDelegate>.value(`delegate`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createLocationPickerViewController(delegate: LocationPickerViewModelDelegate). Use given")
			Failure("Stub return value not specified for createLocationPickerViewController(delegate: LocationPickerViewModelDelegate). Use given")
		}
		return __value
    }

    open func createCategoryPickerViewController(preselectedLocation: LocationType?, delegate: CategoryPickerViewModelDelegate) -> UIViewController {
        addInvocation(.m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(Parameter<LocationType?>.value(`preselectedLocation`), Parameter<CategoryPickerViewModelDelegate>.value(`delegate`)))
		let perform = methodPerformValue(.m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(Parameter<LocationType?>.value(`preselectedLocation`), Parameter<CategoryPickerViewModelDelegate>.value(`delegate`))) as? (LocationType?, CategoryPickerViewModelDelegate) -> Void
		perform?(`preselectedLocation`, `delegate`)
		var __value: UIViewController
		do {
		    __value = try methodReturnValue(.m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(Parameter<LocationType?>.value(`preselectedLocation`), Parameter<CategoryPickerViewModelDelegate>.value(`delegate`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createCategoryPickerViewController(preselectedLocation: LocationType?, delegate: CategoryPickerViewModelDelegate). Use given")
			Failure("Stub return value not specified for createCategoryPickerViewController(preselectedLocation: LocationType?, delegate: CategoryPickerViewModelDelegate). Use given")
		}
		return __value
    }

    open func createTimeSlotPickerViewController(location: LocationType, category: Category, delegate: TimeSlotPickerViewModelDelegate) -> UIViewController {
        addInvocation(.m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(Parameter<LocationType>.value(`location`), Parameter<Category>.value(`category`), Parameter<TimeSlotPickerViewModelDelegate>.value(`delegate`)))
		let perform = methodPerformValue(.m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(Parameter<LocationType>.value(`location`), Parameter<Category>.value(`category`), Parameter<TimeSlotPickerViewModelDelegate>.value(`delegate`))) as? (LocationType, Category, TimeSlotPickerViewModelDelegate) -> Void
		perform?(`location`, `category`, `delegate`)
		var __value: UIViewController
		do {
		    __value = try methodReturnValue(.m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(Parameter<LocationType>.value(`location`), Parameter<Category>.value(`category`), Parameter<TimeSlotPickerViewModelDelegate>.value(`delegate`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createTimeSlotPickerViewController(location: LocationType, category: Category, delegate: TimeSlotPickerViewModelDelegate). Use given")
			Failure("Stub return value not specified for createTimeSlotPickerViewController(location: LocationType, category: Category, delegate: TimeSlotPickerViewModelDelegate). Use given")
		}
		return __value
    }

    open func createAppointmentConfirmationViewController(location: LocationType, category: Category, timeSlot: AvailabilitySlot, delegate: AppointmentConfirmationViewModelDelegate) -> UIViewController {
        addInvocation(.m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(Parameter<LocationType>.value(`location`), Parameter<Category>.value(`category`), Parameter<AvailabilitySlot>.value(`timeSlot`), Parameter<AppointmentConfirmationViewModelDelegate>.value(`delegate`)))
		let perform = methodPerformValue(.m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(Parameter<LocationType>.value(`location`), Parameter<Category>.value(`category`), Parameter<AvailabilitySlot>.value(`timeSlot`), Parameter<AppointmentConfirmationViewModelDelegate>.value(`delegate`))) as? (LocationType, Category, AvailabilitySlot, AppointmentConfirmationViewModelDelegate) -> Void
		perform?(`location`, `category`, `timeSlot`, `delegate`)
		var __value: UIViewController
		do {
		    __value = try methodReturnValue(.m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(Parameter<LocationType>.value(`location`), Parameter<Category>.value(`category`), Parameter<AvailabilitySlot>.value(`timeSlot`), Parameter<AppointmentConfirmationViewModelDelegate>.value(`delegate`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createAppointmentConfirmationViewController(location: LocationType, category: Category, timeSlot: AvailabilitySlot, delegate: AppointmentConfirmationViewModelDelegate). Use given")
			Failure("Stub return value not specified for createAppointmentConfirmationViewController(location: LocationType, category: Category, timeSlot: AvailabilitySlot, delegate: AppointmentConfirmationViewModelDelegate). Use given")
		}
		return __value
    }

    @MainActor
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
        case m_createLocationPickerViewController__delegate_delegate(Parameter<LocationPickerViewModelDelegate>)
        case m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(Parameter<LocationType?>, Parameter<CategoryPickerViewModelDelegate>)
        case m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(Parameter<LocationType>, Parameter<Category>, Parameter<TimeSlotPickerViewModelDelegate>)
        case m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(Parameter<LocationType>, Parameter<Category>, Parameter<AvailabilitySlot>, Parameter<AppointmentConfirmationViewModelDelegate>)
        case m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(Parameter<Appointment>, Parameter<AppointmentCellViewModelDelegate>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createLocationPickerViewController__delegate_delegate(let lhsDelegate), .m_createLocationPickerViewController__delegate_delegate(let rhsDelegate)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDelegate, rhs: rhsDelegate, with: matcher), lhsDelegate, rhsDelegate, "delegate"))
				return Matcher.ComparisonResult(results)

            case (.m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(let lhsPreselectedlocation, let lhsDelegate), .m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(let rhsPreselectedlocation, let rhsDelegate)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPreselectedlocation, rhs: rhsPreselectedlocation, with: matcher), lhsPreselectedlocation, rhsPreselectedlocation, "preselectedLocation"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDelegate, rhs: rhsDelegate, with: matcher), lhsDelegate, rhsDelegate, "delegate"))
				return Matcher.ComparisonResult(results)

            case (.m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(let lhsLocation, let lhsCategory, let lhsDelegate), .m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(let rhsLocation, let rhsCategory, let rhsDelegate)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocation, rhs: rhsLocation, with: matcher), lhsLocation, rhsLocation, "location"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCategory, rhs: rhsCategory, with: matcher), lhsCategory, rhsCategory, "category"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDelegate, rhs: rhsDelegate, with: matcher), lhsDelegate, rhsDelegate, "delegate"))
				return Matcher.ComparisonResult(results)

            case (.m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(let lhsLocation, let lhsCategory, let lhsTimeslot, let lhsDelegate), .m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(let rhsLocation, let rhsCategory, let rhsTimeslot, let rhsDelegate)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocation, rhs: rhsLocation, with: matcher), lhsLocation, rhsLocation, "location"))
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
            case let .m_createLocationPickerViewController__delegate_delegate(p0): return p0.intValue
            case let .m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(p0, p1): return p0.intValue + p1.intValue
            case let .m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createLocationPickerViewController__delegate_delegate: return ".createLocationPickerViewController(delegate:)"
            case .m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate: return ".createCategoryPickerViewController(preselectedLocation:delegate:)"
            case .m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate: return ".createTimeSlotPickerViewController(location:category:delegate:)"
            case .m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate: return ".createAppointmentConfirmationViewController(location:category:timeSlot:delegate:)"
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


        public static func createLocationPickerViewController(delegate: Parameter<LocationPickerViewModelDelegate>, willReturn: UIViewController...) -> MethodStub {
            return Given(method: .m_createLocationPickerViewController__delegate_delegate(`delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createCategoryPickerViewController(preselectedLocation: Parameter<LocationType?>, delegate: Parameter<CategoryPickerViewModelDelegate>, willReturn: UIViewController...) -> MethodStub {
            return Given(method: .m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(`preselectedLocation`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createTimeSlotPickerViewController(location: Parameter<LocationType>, category: Parameter<Category>, delegate: Parameter<TimeSlotPickerViewModelDelegate>, willReturn: UIViewController...) -> MethodStub {
            return Given(method: .m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(`location`, `category`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createAppointmentConfirmationViewController(location: Parameter<LocationType>, category: Parameter<Category>, timeSlot: Parameter<AvailabilitySlot>, delegate: Parameter<AppointmentConfirmationViewModelDelegate>, willReturn: UIViewController...) -> MethodStub {
            return Given(method: .m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(`location`, `category`, `timeSlot`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func createAppointmentCellViewModel(appointment: Parameter<Appointment>, delegate: Parameter<AppointmentCellViewModelDelegate>, willReturn: AppointmentCellViewModel...) -> MethodStub {
            return Given(method: .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(`appointment`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createLocationPickerViewController(delegate: Parameter<LocationPickerViewModelDelegate>, willProduce: (Stubber<UIViewController>) -> Void) -> MethodStub {
            let willReturn: [UIViewController] = []
			let given: Given = { return Given(method: .m_createLocationPickerViewController__delegate_delegate(`delegate`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UIViewController).self)
			willProduce(stubber)
			return given
        }
        public static func createCategoryPickerViewController(preselectedLocation: Parameter<LocationType?>, delegate: Parameter<CategoryPickerViewModelDelegate>, willProduce: (Stubber<UIViewController>) -> Void) -> MethodStub {
            let willReturn: [UIViewController] = []
			let given: Given = { return Given(method: .m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(`preselectedLocation`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UIViewController).self)
			willProduce(stubber)
			return given
        }
        public static func createTimeSlotPickerViewController(location: Parameter<LocationType>, category: Parameter<Category>, delegate: Parameter<TimeSlotPickerViewModelDelegate>, willProduce: (Stubber<UIViewController>) -> Void) -> MethodStub {
            let willReturn: [UIViewController] = []
			let given: Given = { return Given(method: .m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(`location`, `category`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UIViewController).self)
			willProduce(stubber)
			return given
        }
        public static func createAppointmentConfirmationViewController(location: Parameter<LocationType>, category: Parameter<Category>, timeSlot: Parameter<AvailabilitySlot>, delegate: Parameter<AppointmentConfirmationViewModelDelegate>, willProduce: (Stubber<UIViewController>) -> Void) -> MethodStub {
            let willReturn: [UIViewController] = []
			let given: Given = { return Given(method: .m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(`location`, `category`, `timeSlot`, `delegate`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UIViewController).self)
			willProduce(stubber)
			return given
        }
        @MainActor
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

        public static func createLocationPickerViewController(delegate: Parameter<LocationPickerViewModelDelegate>) -> Verify { return Verify(method: .m_createLocationPickerViewController__delegate_delegate(`delegate`))}
        public static func createCategoryPickerViewController(preselectedLocation: Parameter<LocationType?>, delegate: Parameter<CategoryPickerViewModelDelegate>) -> Verify { return Verify(method: .m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(`preselectedLocation`, `delegate`))}
        public static func createTimeSlotPickerViewController(location: Parameter<LocationType>, category: Parameter<Category>, delegate: Parameter<TimeSlotPickerViewModelDelegate>) -> Verify { return Verify(method: .m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(`location`, `category`, `delegate`))}
        public static func createAppointmentConfirmationViewController(location: Parameter<LocationType>, category: Parameter<Category>, timeSlot: Parameter<AvailabilitySlot>, delegate: Parameter<AppointmentConfirmationViewModelDelegate>) -> Verify { return Verify(method: .m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(`location`, `category`, `timeSlot`, `delegate`))}
        @MainActor
		public static func createAppointmentCellViewModel(appointment: Parameter<Appointment>, delegate: Parameter<AppointmentCellViewModelDelegate>) -> Verify { return Verify(method: .m_createAppointmentCellViewModel__appointment_appointmentdelegate_delegate(`appointment`, `delegate`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createLocationPickerViewController(delegate: Parameter<LocationPickerViewModelDelegate>, perform: @escaping (LocationPickerViewModelDelegate) -> Void) -> Perform {
            return Perform(method: .m_createLocationPickerViewController__delegate_delegate(`delegate`), performs: perform)
        }
        public static func createCategoryPickerViewController(preselectedLocation: Parameter<LocationType?>, delegate: Parameter<CategoryPickerViewModelDelegate>, perform: @escaping (LocationType?, CategoryPickerViewModelDelegate) -> Void) -> Perform {
            return Perform(method: .m_createCategoryPickerViewController__preselectedLocation_preselectedLocationdelegate_delegate(`preselectedLocation`, `delegate`), performs: perform)
        }
        public static func createTimeSlotPickerViewController(location: Parameter<LocationType>, category: Parameter<Category>, delegate: Parameter<TimeSlotPickerViewModelDelegate>, perform: @escaping (LocationType, Category, TimeSlotPickerViewModelDelegate) -> Void) -> Perform {
            return Perform(method: .m_createTimeSlotPickerViewController__location_locationcategory_categorydelegate_delegate(`location`, `category`, `delegate`), performs: perform)
        }
        public static func createAppointmentConfirmationViewController(location: Parameter<LocationType>, category: Parameter<Category>, timeSlot: Parameter<AvailabilitySlot>, delegate: Parameter<AppointmentConfirmationViewModelDelegate>, perform: @escaping (LocationType, Category, AvailabilitySlot, AppointmentConfirmationViewModelDelegate) -> Void) -> Perform {
            return Perform(method: .m_createAppointmentConfirmationViewController__location_locationcategory_categorytimeSlot_timeSlotdelegate_delegate(`location`, `category`, `timeSlot`, `delegate`), performs: perform)
        }
        @MainActor
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

// MARK: - LocationPickerViewModel

open class LocationPickerViewModelMock: LocationPickerViewModel, Mock {
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

    @MainActor
		public var isLoading: Bool {
		get {	invocations.append(.p_isLoading_get); return __p_isLoading ?? givenGetterValue(.p_isLoading_get, "LocationPickerViewModelMock - stub value for isLoading was not defined") }
	}
	private var __p_isLoading: (Bool)?

    @MainActor
		public var items: [LocationViewItem] {
		get {	invocations.append(.p_items_get); return __p_items ?? givenGetterValue(.p_items_get, "LocationPickerViewModelMock - stub value for items was not defined") }
	}
	private var __p_items: ([LocationViewItem])?

    @MainActor
		public var error: AlertViewModel? {
		get {	invocations.append(.p_error_get); return __p_error ?? optionalGivenGetterValue(.p_error_get, "LocationPickerViewModelMock - stub value for error was not defined") }
		set {	invocations.append(.p_error_set(.value(newValue))); __p_error = newValue }
	}
	private var __p_error: (AlertViewModel)?





    @MainActor
	open func start() {
        addInvocation(.m_start)
		let perform = methodPerformValue(.m_start) as? () -> Void
		perform?()
    }

    @MainActor
	open func userDidPullToRefresh() {
        addInvocation(.m_userDidPullToRefresh)
		let perform = methodPerformValue(.m_userDidPullToRefresh) as? () -> Void
		perform?()
    }

    @MainActor
	open func userDidSelect(location: LocationViewItem, at index: Int) {
        addInvocation(.m_userDidSelect__location_locationat_index(Parameter<LocationViewItem>.value(`location`), Parameter<Int>.value(`index`)))
		let perform = methodPerformValue(.m_userDidSelect__location_locationat_index(Parameter<LocationViewItem>.value(`location`), Parameter<Int>.value(`index`))) as? (LocationViewItem, Int) -> Void
		perform?(`location`, `index`)
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
        case m_start
        case m_userDidPullToRefresh
        case m_userDidSelect__location_locationat_index(Parameter<LocationViewItem>, Parameter<Int>)
        case m_onChange
        case m_onChange__throttle_throttle(Parameter<DispatchQueue.SchedulerTimeType.Stride>)
        case p_isLoading_get
        case p_items_get
        case p_error_get
		case p_error_set(Parameter<AlertViewModel?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_start, .m_start): return .match

            case (.m_userDidPullToRefresh, .m_userDidPullToRefresh): return .match

            case (.m_userDidSelect__location_locationat_index(let lhsLocation, let lhsIndex), .m_userDidSelect__location_locationat_index(let rhsLocation, let rhsIndex)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocation, rhs: rhsLocation, with: matcher), lhsLocation, rhsLocation, "location"))
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
            case .m_start: return 0
            case .m_userDidPullToRefresh: return 0
            case let .m_userDidSelect__location_locationat_index(p0, p1): return p0.intValue + p1.intValue
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
            case .m_start: return ".start()"
            case .m_userDidPullToRefresh: return ".userDidPullToRefresh()"
            case .m_userDidSelect__location_locationat_index: return ".userDidSelect(location:at:)"
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

        @MainActor
		public static func isLoading(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoading_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func items(getter defaultValue: [LocationViewItem]...) -> PropertyStub {
            return Given(method: .p_items_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
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

        @MainActor
		public static func start() -> Verify { return Verify(method: .m_start)}
        @MainActor
		public static func userDidPullToRefresh() -> Verify { return Verify(method: .m_userDidPullToRefresh)}
        @MainActor
		public static func userDidSelect(location: Parameter<LocationViewItem>, at index: Parameter<Int>) -> Verify { return Verify(method: .m_userDidSelect__location_locationat_index(`location`, `index`))}
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

        @MainActor
		public static func start(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_start, performs: perform)
        }
        @MainActor
		public static func userDidPullToRefresh(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidPullToRefresh, performs: perform)
        }
        @MainActor
		public static func userDidSelect(location: Parameter<LocationViewItem>, at index: Parameter<Int>, perform: @escaping (LocationViewItem, Int) -> Void) -> Perform {
            return Perform(method: .m_userDidSelect__location_locationat_index(`location`, `index`), performs: perform)
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

    @MainActor
		public var isLoading: Bool {
		get {	invocations.append(.p_isLoading_get); return __p_isLoading ?? givenGetterValue(.p_isLoading_get, "TimeSlotPickerViewModelMock - stub value for isLoading was not defined") }
	}
	private var __p_isLoading: (Bool)?

    @MainActor
		public var groups: [TimeSlotGroupViewItem] {
		get {	invocations.append(.p_groups_get); return __p_groups ?? givenGetterValue(.p_groups_get, "TimeSlotPickerViewModelMock - stub value for groups was not defined") }
	}
	private var __p_groups: ([TimeSlotGroupViewItem])?

    @MainActor
		public var canContinue: Bool {
		get {	invocations.append(.p_canContinue_get); return __p_canContinue ?? givenGetterValue(.p_canContinue_get, "TimeSlotPickerViewModelMock - stub value for canContinue was not defined") }
	}
	private var __p_canContinue: (Bool)?

    @MainActor
		public var error: AlertViewModel? {
		get {	invocations.append(.p_error_get); return __p_error ?? optionalGivenGetterValue(.p_error_get, "TimeSlotPickerViewModelMock - stub value for error was not defined") }
		set {	invocations.append(.p_error_set(.value(newValue))); __p_error = newValue }
	}
	private var __p_error: (AlertViewModel)?





    @MainActor
	open func userDidPullToRefresh() {
        addInvocation(.m_userDidPullToRefresh)
		let perform = methodPerformValue(.m_userDidPullToRefresh) as? () -> Void
		perform?()
    }

    @MainActor
	open func userDidReachEndOfList() {
        addInvocation(.m_userDidReachEndOfList)
		let perform = methodPerformValue(.m_userDidReachEndOfList) as? () -> Void
		perform?()
    }

    @MainActor
	open func userDidTapGroup(_ group: TimeSlotGroupViewItem, at index: Int) {
        addInvocation(.m_userDidTapGroup__groupat_index(Parameter<TimeSlotGroupViewItem>.value(`group`), Parameter<Int>.value(`index`)))
		let perform = methodPerformValue(.m_userDidTapGroup__groupat_index(Parameter<TimeSlotGroupViewItem>.value(`group`), Parameter<Int>.value(`index`))) as? (TimeSlotGroupViewItem, Int) -> Void
		perform?(`group`, `index`)
    }

    @MainActor
	open func userDidTapTimeSlot(_ timeSlot: TimeSlotViewItem, at timeSlotIndex: Int, in group: TimeSlotGroupViewItem, at groupIndex: Int) {
        addInvocation(.m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(Parameter<TimeSlotViewItem>.value(`timeSlot`), Parameter<Int>.value(`timeSlotIndex`), Parameter<TimeSlotGroupViewItem>.value(`group`), Parameter<Int>.value(`groupIndex`)))
		let perform = methodPerformValue(.m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(Parameter<TimeSlotViewItem>.value(`timeSlot`), Parameter<Int>.value(`timeSlotIndex`), Parameter<TimeSlotGroupViewItem>.value(`group`), Parameter<Int>.value(`groupIndex`))) as? (TimeSlotViewItem, Int, TimeSlotGroupViewItem, Int) -> Void
		perform?(`timeSlot`, `timeSlotIndex`, `group`, `groupIndex`)
    }

    @MainActor
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

        @MainActor
		public static func isLoading(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_isLoading_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func groups(getter defaultValue: [TimeSlotGroupViewItem]...) -> PropertyStub {
            return Given(method: .p_groups_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
		public static func canContinue(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_canContinue_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        @MainActor
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

        @MainActor
		public static func userDidPullToRefresh() -> Verify { return Verify(method: .m_userDidPullToRefresh)}
        @MainActor
		public static func userDidReachEndOfList() -> Verify { return Verify(method: .m_userDidReachEndOfList)}
        @MainActor
		public static func userDidTapGroup(_ group: Parameter<TimeSlotGroupViewItem>, at index: Parameter<Int>) -> Verify { return Verify(method: .m_userDidTapGroup__groupat_index(`group`, `index`))}
        @MainActor
		public static func userDidTapTimeSlot(_ timeSlot: Parameter<TimeSlotViewItem>, at timeSlotIndex: Parameter<Int>, in group: Parameter<TimeSlotGroupViewItem>, at groupIndex: Parameter<Int>) -> Verify { return Verify(method: .m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(`timeSlot`, `timeSlotIndex`, `group`, `groupIndex`))}
        @MainActor
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

        @MainActor
		public static func userDidPullToRefresh(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidPullToRefresh, performs: perform)
        }
        @MainActor
		public static func userDidReachEndOfList(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidReachEndOfList, performs: perform)
        }
        @MainActor
		public static func userDidTapGroup(_ group: Parameter<TimeSlotGroupViewItem>, at index: Parameter<Int>, perform: @escaping (TimeSlotGroupViewItem, Int) -> Void) -> Perform {
            return Perform(method: .m_userDidTapGroup__groupat_index(`group`, `index`), performs: perform)
        }
        @MainActor
		public static func userDidTapTimeSlot(_ timeSlot: Parameter<TimeSlotViewItem>, at timeSlotIndex: Parameter<Int>, in group: Parameter<TimeSlotGroupViewItem>, at groupIndex: Parameter<Int>, perform: @escaping (TimeSlotViewItem, Int, TimeSlotGroupViewItem, Int) -> Void) -> Perform {
            return Perform(method: .m_userDidTapTimeSlot__timeSlotat_timeSlotIndexin_groupat_groupIndex(`timeSlot`, `timeSlotIndex`, `group`, `groupIndex`), performs: perform)
        }
        @MainActor
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

