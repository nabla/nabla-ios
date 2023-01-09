// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import Combine
@testable import NablaCore


// MARK: - Authenticator

open class AuthenticatorMock: Authenticator, Mock {
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





    open func authenticate(userId: String, provider: SessionTokenProvider) {
        addInvocation(.m_authenticate__userId_userIdprovider_provider(Parameter<String>.value(`userId`), Parameter<SessionTokenProvider>.value(`provider`)))
		let perform = methodPerformValue(.m_authenticate__userId_userIdprovider_provider(Parameter<String>.value(`userId`), Parameter<SessionTokenProvider>.value(`provider`))) as? (String, SessionTokenProvider) -> Void
		perform?(`userId`, `provider`)
    }

    open func logOut() {
        addInvocation(.m_logOut)
		let perform = methodPerformValue(.m_logOut) as? () -> Void
		perform?()
    }

    open func getAccessToken() throws -> AuthenticationState {
        addInvocation(.m_getAccessToken)
		let perform = methodPerformValue(.m_getAccessToken) as? () -> Void
		perform?()
		var __value: AuthenticationState
		do {
		    __value = try methodReturnValue(.m_getAccessToken).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for getAccessToken(). Use given")
			Failure("Stub return value not specified for getAccessToken(). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func addObserver(_ observer: Any, selector: Selector) {
        addInvocation(.m_addObserver__observerselector_selector(Parameter<Any>.value(`observer`), Parameter<Selector>.value(`selector`)))
		let perform = methodPerformValue(.m_addObserver__observerselector_selector(Parameter<Any>.value(`observer`), Parameter<Selector>.value(`selector`))) as? (Any, Selector) -> Void
		perform?(`observer`, `selector`)
    }

    open func removeObserver(_ observer: Any) {
        addInvocation(.m_removeObserver__observer(Parameter<Any>.value(`observer`)))
		let perform = methodPerformValue(.m_removeObserver__observer(Parameter<Any>.value(`observer`))) as? (Any) -> Void
		perform?(`observer`)
    }

    open func isSessionInitialized() -> Bool {
        addInvocation(.m_isSessionInitialized)
		let perform = methodPerformValue(.m_isSessionInitialized) as? () -> Void
		perform?()
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_isSessionInitialized).casted()
		} catch {
			onFatalFailure("Stub return value not specified for isSessionInitialized(). Use given")
			Failure("Stub return value not specified for isSessionInitialized(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_authenticate__userId_userIdprovider_provider(Parameter<String>, Parameter<SessionTokenProvider>)
        case m_logOut
        case m_getAccessToken
        case m_addObserver__observerselector_selector(Parameter<Any>, Parameter<Selector>)
        case m_removeObserver__observer(Parameter<Any>)
        case m_isSessionInitialized

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_authenticate__userId_userIdprovider_provider(let lhsUserid, let lhsProvider), .m_authenticate__userId_userIdprovider_provider(let rhsUserid, let rhsProvider)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "userId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsProvider, rhs: rhsProvider, with: matcher), lhsProvider, rhsProvider, "provider"))
				return Matcher.ComparisonResult(results)

            case (.m_logOut, .m_logOut): return .match

            case (.m_getAccessToken, .m_getAccessToken): return .match

            case (.m_addObserver__observerselector_selector(let lhsObserver, let lhsSelector), .m_addObserver__observerselector_selector(let rhsObserver, let rhsSelector)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsObserver, rhs: rhsObserver, with: matcher), lhsObserver, rhsObserver, "_ observer"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSelector, rhs: rhsSelector, with: matcher), lhsSelector, rhsSelector, "selector"))
				return Matcher.ComparisonResult(results)

            case (.m_removeObserver__observer(let lhsObserver), .m_removeObserver__observer(let rhsObserver)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsObserver, rhs: rhsObserver, with: matcher), lhsObserver, rhsObserver, "_ observer"))
				return Matcher.ComparisonResult(results)

            case (.m_isSessionInitialized, .m_isSessionInitialized): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_authenticate__userId_userIdprovider_provider(p0, p1): return p0.intValue + p1.intValue
            case .m_logOut: return 0
            case .m_getAccessToken: return 0
            case let .m_addObserver__observerselector_selector(p0, p1): return p0.intValue + p1.intValue
            case let .m_removeObserver__observer(p0): return p0.intValue
            case .m_isSessionInitialized: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_authenticate__userId_userIdprovider_provider: return ".authenticate(userId:provider:)"
            case .m_logOut: return ".logOut()"
            case .m_getAccessToken: return ".getAccessToken()"
            case .m_addObserver__observerselector_selector: return ".addObserver(_:selector:)"
            case .m_removeObserver__observer: return ".removeObserver(_:)"
            case .m_isSessionInitialized: return ".isSessionInitialized()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getAccessToken(willReturn: AuthenticationState...) -> MethodStub {
            return Given(method: .m_getAccessToken, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func isSessionInitialized(willReturn: Bool...) -> MethodStub {
            return Given(method: .m_isSessionInitialized, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func isSessionInitialized(willProduce: (Stubber<Bool>) -> Void) -> MethodStub {
            let willReturn: [Bool] = []
			let given: Given = { return Given(method: .m_isSessionInitialized, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func getAccessToken(willThrow: Error...) -> MethodStub {
            return Given(method: .m_getAccessToken, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func getAccessToken(willProduce: (StubberThrows<AuthenticationState>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_getAccessToken, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (AuthenticationState).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func authenticate(userId: Parameter<String>, provider: Parameter<SessionTokenProvider>) -> Verify { return Verify(method: .m_authenticate__userId_userIdprovider_provider(`userId`, `provider`))}
        public static func logOut() -> Verify { return Verify(method: .m_logOut)}
        public static func getAccessToken() -> Verify { return Verify(method: .m_getAccessToken)}
        public static func addObserver(_ observer: Parameter<Any>, selector: Parameter<Selector>) -> Verify { return Verify(method: .m_addObserver__observerselector_selector(`observer`, `selector`))}
        public static func removeObserver(_ observer: Parameter<Any>) -> Verify { return Verify(method: .m_removeObserver__observer(`observer`))}
        public static func isSessionInitialized() -> Verify { return Verify(method: .m_isSessionInitialized)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func authenticate(userId: Parameter<String>, provider: Parameter<SessionTokenProvider>, perform: @escaping (String, SessionTokenProvider) -> Void) -> Perform {
            return Perform(method: .m_authenticate__userId_userIdprovider_provider(`userId`, `provider`), performs: perform)
        }
        public static func logOut(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_logOut, performs: perform)
        }
        public static func getAccessToken(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_getAccessToken, performs: perform)
        }
        public static func addObserver(_ observer: Parameter<Any>, selector: Parameter<Selector>, perform: @escaping (Any, Selector) -> Void) -> Perform {
            return Perform(method: .m_addObserver__observerselector_selector(`observer`, `selector`), performs: perform)
        }
        public static func removeObserver(_ observer: Parameter<Any>, perform: @escaping (Any) -> Void) -> Perform {
            return Perform(method: .m_removeObserver__observer(`observer`), performs: perform)
        }
        public static func isSessionInitialized(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_isSessionInitialized, performs: perform)
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

// MARK: - DeviceLocalDataSource

open class DeviceLocalDataSourceMock: DeviceLocalDataSource, Mock {
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

    public var deviceModel: String {
		get {	invocations.append(.p_deviceModel_get); return __p_deviceModel ?? givenGetterValue(.p_deviceModel_get, "DeviceLocalDataSourceMock - stub value for deviceModel was not defined") }
	}
	private var __p_deviceModel: (String)?

    public var deviceOSVersion: String {
		get {	invocations.append(.p_deviceOSVersion_get); return __p_deviceOSVersion ?? givenGetterValue(.p_deviceOSVersion_get, "DeviceLocalDataSourceMock - stub value for deviceOSVersion was not defined") }
	}
	private var __p_deviceOSVersion: (String)?

    public var codeVersion: Int {
		get {	invocations.append(.p_codeVersion_get); return __p_codeVersion ?? givenGetterValue(.p_codeVersion_get, "DeviceLocalDataSourceMock - stub value for codeVersion was not defined") }
	}
	private var __p_codeVersion: (Int)?





    open func getDeviceId(forUserId userId: String) -> UUID? {
        addInvocation(.m_getDeviceId__forUserId_userId(Parameter<String>.value(`userId`)))
		let perform = methodPerformValue(.m_getDeviceId__forUserId_userId(Parameter<String>.value(`userId`))) as? (String) -> Void
		perform?(`userId`)
		var __value: UUID? = nil
		do {
		    __value = try methodReturnValue(.m_getDeviceId__forUserId_userId(Parameter<String>.value(`userId`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func setDeviceId(_ deviceId: UUID, forUserId userId: String) {
        addInvocation(.m_setDeviceId__deviceIdforUserId_userId(Parameter<UUID>.value(`deviceId`), Parameter<String>.value(`userId`)))
		let perform = methodPerformValue(.m_setDeviceId__deviceIdforUserId_userId(Parameter<UUID>.value(`deviceId`), Parameter<String>.value(`userId`))) as? (UUID, String) -> Void
		perform?(`deviceId`, `userId`)
    }


    fileprivate enum MethodType {
        case m_getDeviceId__forUserId_userId(Parameter<String>)
        case m_setDeviceId__deviceIdforUserId_userId(Parameter<UUID>, Parameter<String>)
        case p_deviceModel_get
        case p_deviceOSVersion_get
        case p_codeVersion_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getDeviceId__forUserId_userId(let lhsUserid), .m_getDeviceId__forUserId_userId(let rhsUserid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "forUserId userId"))
				return Matcher.ComparisonResult(results)

            case (.m_setDeviceId__deviceIdforUserId_userId(let lhsDeviceid, let lhsUserid), .m_setDeviceId__deviceIdforUserId_userId(let rhsDeviceid, let rhsUserid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDeviceid, rhs: rhsDeviceid, with: matcher), lhsDeviceid, rhsDeviceid, "_ deviceId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUserid, rhs: rhsUserid, with: matcher), lhsUserid, rhsUserid, "forUserId userId"))
				return Matcher.ComparisonResult(results)
            case (.p_deviceModel_get,.p_deviceModel_get): return Matcher.ComparisonResult.match
            case (.p_deviceOSVersion_get,.p_deviceOSVersion_get): return Matcher.ComparisonResult.match
            case (.p_codeVersion_get,.p_codeVersion_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getDeviceId__forUserId_userId(p0): return p0.intValue
            case let .m_setDeviceId__deviceIdforUserId_userId(p0, p1): return p0.intValue + p1.intValue
            case .p_deviceModel_get: return 0
            case .p_deviceOSVersion_get: return 0
            case .p_codeVersion_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getDeviceId__forUserId_userId: return ".getDeviceId(forUserId:)"
            case .m_setDeviceId__deviceIdforUserId_userId: return ".setDeviceId(_:forUserId:)"
            case .p_deviceModel_get: return "[get] .deviceModel"
            case .p_deviceOSVersion_get: return "[get] .deviceOSVersion"
            case .p_codeVersion_get: return "[get] .codeVersion"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func deviceModel(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_deviceModel_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func deviceOSVersion(getter defaultValue: String...) -> PropertyStub {
            return Given(method: .p_deviceOSVersion_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func codeVersion(getter defaultValue: Int...) -> PropertyStub {
            return Given(method: .p_codeVersion_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func getDeviceId(forUserId userId: Parameter<String>, willReturn: UUID?...) -> MethodStub {
            return Given(method: .m_getDeviceId__forUserId_userId(`userId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getDeviceId(forUserId userId: Parameter<String>, willProduce: (Stubber<UUID?>) -> Void) -> MethodStub {
            let willReturn: [UUID?] = []
			let given: Given = { return Given(method: .m_getDeviceId__forUserId_userId(`userId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (UUID?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getDeviceId(forUserId userId: Parameter<String>) -> Verify { return Verify(method: .m_getDeviceId__forUserId_userId(`userId`))}
        public static func setDeviceId(_ deviceId: Parameter<UUID>, forUserId userId: Parameter<String>) -> Verify { return Verify(method: .m_setDeviceId__deviceIdforUserId_userId(`deviceId`, `userId`))}
        public static var deviceModel: Verify { return Verify(method: .p_deviceModel_get) }
        public static var deviceOSVersion: Verify { return Verify(method: .p_deviceOSVersion_get) }
        public static var codeVersion: Verify { return Verify(method: .p_codeVersion_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getDeviceId(forUserId userId: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_getDeviceId__forUserId_userId(`userId`), performs: perform)
        }
        public static func setDeviceId(_ deviceId: Parameter<UUID>, forUserId userId: Parameter<String>, perform: @escaping (UUID, String) -> Void) -> Perform {
            return Perform(method: .m_setDeviceId__deviceIdforUserId_userId(`deviceId`, `userId`), performs: perform)
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

// MARK: - GQLClient

open class GQLClientMock: GQLClient, Mock {
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





    open func fetch<Query: GQLQuery>(query: Query, policy: GQLFetchPolicy) throws -> Query.Data {
        addInvocation(.m_fetch__query_querypolicy_policy(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<GQLFetchPolicy>.value(`policy`)))
		let perform = methodPerformValue(.m_fetch__query_querypolicy_policy(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<GQLFetchPolicy>.value(`policy`))) as? (Query, GQLFetchPolicy) -> Void
		perform?(`query`, `policy`)
		var __value: Query.Data
		do {
		    __value = try methodReturnValue(.m_fetch__query_querypolicy_policy(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<GQLFetchPolicy>.value(`policy`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for fetch<Query: GQLQuery>(query: Query, policy: GQLFetchPolicy). Use given")
			Failure("Stub return value not specified for fetch<Query: GQLQuery>(query: Query, policy: GQLFetchPolicy). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func perform<Mutation: GQLMutation>(mutation: Mutation) throws -> Mutation.Data {
        addInvocation(.m_perform__mutation_mutation(Parameter<Mutation>.value(`mutation`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_perform__mutation_mutation(Parameter<Mutation>.value(`mutation`).wrapAsGeneric())) as? (Mutation) -> Void
		perform?(`mutation`)
		var __value: Mutation.Data
		do {
		    __value = try methodReturnValue(.m_perform__mutation_mutation(Parameter<Mutation>.value(`mutation`).wrapAsGeneric())).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for perform<Mutation: GQLMutation>(mutation: Mutation). Use given")
			Failure("Stub return value not specified for perform<Mutation: GQLMutation>(mutation: Mutation). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func watch<Query: GQLQuery>(query: Query, policy: GQLWatchPolicy) -> AnyPublisher<Query.Data, GQLError> {
        addInvocation(.m_watch__query_querypolicy_policy(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<GQLWatchPolicy>.value(`policy`)))
		let perform = methodPerformValue(.m_watch__query_querypolicy_policy(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<GQLWatchPolicy>.value(`policy`))) as? (Query, GQLWatchPolicy) -> Void
		perform?(`query`, `policy`)
		var __value: AnyPublisher<Query.Data, GQLError>
		do {
		    __value = try methodReturnValue(.m_watch__query_querypolicy_policy(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<GQLWatchPolicy>.value(`policy`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watch<Query: GQLQuery>(query: Query, policy: GQLWatchPolicy). Use given")
			Failure("Stub return value not specified for watch<Query: GQLQuery>(query: Query, policy: GQLWatchPolicy). Use given")
		}
		return __value
    }

    open func subscribe<Subscription: GQLSubscription>(subscription: Subscription) -> AnyPublisher<Subscription.Data, Never> {
        addInvocation(.m_subscribe__subscription_subscription(Parameter<Subscription>.value(`subscription`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_subscribe__subscription_subscription(Parameter<Subscription>.value(`subscription`).wrapAsGeneric())) as? (Subscription) -> Void
		perform?(`subscription`)
		var __value: AnyPublisher<Subscription.Data, Never>
		do {
		    __value = try methodReturnValue(.m_subscribe__subscription_subscription(Parameter<Subscription>.value(`subscription`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for subscribe<Subscription: GQLSubscription>(subscription: Subscription). Use given")
			Failure("Stub return value not specified for subscribe<Subscription: GQLSubscription>(subscription: Subscription). Use given")
		}
		return __value
    }

    open func addRefetchTriggers(_ triggers: [RefetchTrigger]) {
        addInvocation(.m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>.value(`triggers`)))
		let perform = methodPerformValue(.m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>.value(`triggers`))) as? ([RefetchTrigger]) -> Void
		perform?(`triggers`)
    }


    fileprivate enum MethodType {
        case m_fetch__query_querypolicy_policy(Parameter<GenericAttribute>, Parameter<GQLFetchPolicy>)
        case m_perform__mutation_mutation(Parameter<GenericAttribute>)
        case m_watch__query_querypolicy_policy(Parameter<GenericAttribute>, Parameter<GQLWatchPolicy>)
        case m_subscribe__subscription_subscription(Parameter<GenericAttribute>)
        case m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetch__query_querypolicy_policy(let lhsQuery, let lhsPolicy), .m_fetch__query_querypolicy_policy(let rhsQuery, let rhsPolicy)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPolicy, rhs: rhsPolicy, with: matcher), lhsPolicy, rhsPolicy, "policy"))
				return Matcher.ComparisonResult(results)

            case (.m_perform__mutation_mutation(let lhsMutation), .m_perform__mutation_mutation(let rhsMutation)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMutation, rhs: rhsMutation, with: matcher), lhsMutation, rhsMutation, "mutation"))
				return Matcher.ComparisonResult(results)

            case (.m_watch__query_querypolicy_policy(let lhsQuery, let lhsPolicy), .m_watch__query_querypolicy_policy(let rhsQuery, let rhsPolicy)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsPolicy, rhs: rhsPolicy, with: matcher), lhsPolicy, rhsPolicy, "policy"))
				return Matcher.ComparisonResult(results)

            case (.m_subscribe__subscription_subscription(let lhsSubscription), .m_subscribe__subscription_subscription(let rhsSubscription)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSubscription, rhs: rhsSubscription, with: matcher), lhsSubscription, rhsSubscription, "subscription"))
				return Matcher.ComparisonResult(results)

            case (.m_addRefetchTriggers__triggers(let lhsTriggers), .m_addRefetchTriggers__triggers(let rhsTriggers)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTriggers, rhs: rhsTriggers, with: matcher), lhsTriggers, rhsTriggers, "_ triggers"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_fetch__query_querypolicy_policy(p0, p1): return p0.intValue + p1.intValue
            case let .m_perform__mutation_mutation(p0): return p0.intValue
            case let .m_watch__query_querypolicy_policy(p0, p1): return p0.intValue + p1.intValue
            case let .m_subscribe__subscription_subscription(p0): return p0.intValue
            case let .m_addRefetchTriggers__triggers(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetch__query_querypolicy_policy: return ".fetch(query:policy:)"
            case .m_perform__mutation_mutation: return ".perform(mutation:)"
            case .m_watch__query_querypolicy_policy: return ".watch(query:policy:)"
            case .m_subscribe__subscription_subscription: return ".subscribe(subscription:)"
            case .m_addRefetchTriggers__triggers: return ".addRefetchTriggers(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func fetch<Query: GQLQuery>(query: Parameter<Query>, policy: Parameter<GQLFetchPolicy>, willReturn: Query.Data...) -> MethodStub {
            return Given(method: .m_fetch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func perform<Mutation: GQLMutation>(mutation: Parameter<Mutation>, willReturn: Mutation.Data...) -> MethodStub {
            return Given(method: .m_perform__mutation_mutation(`mutation`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watch<Query: GQLQuery>(query: Parameter<Query>, policy: Parameter<GQLWatchPolicy>, willReturn: AnyPublisher<Query.Data, GQLError>...) -> MethodStub {
            return Given(method: .m_watch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func subscribe<Subscription: GQLSubscription>(subscription: Parameter<Subscription>, willReturn: AnyPublisher<Subscription.Data, Never>...) -> MethodStub {
            return Given(method: .m_subscribe__subscription_subscription(`subscription`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watch<Query: GQLQuery>(query: Parameter<Query>, policy: Parameter<GQLWatchPolicy>, willProduce: (Stubber<AnyPublisher<Query.Data, GQLError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Query.Data, GQLError>] = []
			let given: Given = { return Given(method: .m_watch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Query.Data, GQLError>).self)
			willProduce(stubber)
			return given
        }
        public static func subscribe<Subscription: GQLSubscription>(subscription: Parameter<Subscription>, willProduce: (Stubber<AnyPublisher<Subscription.Data, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Subscription.Data, Never>] = []
			let given: Given = { return Given(method: .m_subscribe__subscription_subscription(`subscription`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Subscription.Data, Never>).self)
			willProduce(stubber)
			return given
        }
        public static func fetch<Query:GQLQuery>(query: Parameter<Query>, policy: Parameter<GQLFetchPolicy>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_fetch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func fetch<Query: GQLQuery>(query: Parameter<Query>, policy: Parameter<GQLFetchPolicy>, willProduce: (StubberThrows<Query.Data>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_fetch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Query.Data).self)
			willProduce(stubber)
			return given
        }
        public static func perform<Mutation:GQLMutation>(mutation: Parameter<Mutation>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_perform__mutation_mutation(`mutation`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func perform<Mutation: GQLMutation>(mutation: Parameter<Mutation>, willProduce: (StubberThrows<Mutation.Data>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_perform__mutation_mutation(`mutation`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Mutation.Data).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetch<Query>(query: Parameter<Query>, policy: Parameter<GQLFetchPolicy>) -> Verify where Query:GQLQuery { return Verify(method: .m_fetch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`))}
        public static func perform<Mutation>(mutation: Parameter<Mutation>) -> Verify where Mutation:GQLMutation { return Verify(method: .m_perform__mutation_mutation(`mutation`.wrapAsGeneric()))}
        public static func watch<Query>(query: Parameter<Query>, policy: Parameter<GQLWatchPolicy>) -> Verify where Query:GQLQuery { return Verify(method: .m_watch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`))}
        public static func subscribe<Subscription>(subscription: Parameter<Subscription>) -> Verify where Subscription:GQLSubscription { return Verify(method: .m_subscribe__subscription_subscription(`subscription`.wrapAsGeneric()))}
        public static func addRefetchTriggers(_ triggers: Parameter<[RefetchTrigger]>) -> Verify { return Verify(method: .m_addRefetchTriggers__triggers(`triggers`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetch<Query>(query: Parameter<Query>, policy: Parameter<GQLFetchPolicy>, perform: @escaping (Query, GQLFetchPolicy) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_fetch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`), performs: perform)
        }
        public static func perform<Mutation>(mutation: Parameter<Mutation>, perform: @escaping (Mutation) -> Void) -> Perform where Mutation:GQLMutation {
            return Perform(method: .m_perform__mutation_mutation(`mutation`.wrapAsGeneric()), performs: perform)
        }
        public static func watch<Query>(query: Parameter<Query>, policy: Parameter<GQLWatchPolicy>, perform: @escaping (Query, GQLWatchPolicy) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_watch__query_querypolicy_policy(`query`.wrapAsGeneric(), `policy`), performs: perform)
        }
        public static func subscribe<Subscription>(subscription: Parameter<Subscription>, perform: @escaping (Subscription) -> Void) -> Perform where Subscription:GQLSubscription {
            return Perform(method: .m_subscribe__subscription_subscription(`subscription`.wrapAsGeneric()), performs: perform)
        }
        public static func addRefetchTriggers(_ triggers: Parameter<[RefetchTrigger]>, perform: @escaping ([RefetchTrigger]) -> Void) -> Perform {
            return Perform(method: .m_addRefetchTriggers__triggers(`triggers`), performs: perform)
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

// MARK: - GQLStore

open class GQLStoreMock: GQLStore, Mock {
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





    open func createCache<Query: GQLQuery>(for query: Query, data: Query.Data) throws {
        addInvocation(.m_createCache__for_querydata_data(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Query.Data>.value(`data`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_createCache__for_querydata_data(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Query.Data>.value(`data`).wrapAsGeneric())) as? (Query, Query.Data) -> Void
		perform?(`query`, `data`)
		do {
		    _ = try methodReturnValue(.m_createCache__for_querydata_data(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Query.Data>.value(`data`).wrapAsGeneric())).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func updateCache<Query: GQLQuery>(for query: Query, onlyIfExists: Bool, body: @escaping (inout Query.Data) throws -> Void) throws {
        addInvocation(.m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Query.Data) throws -> Void>.value(`body`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Query.Data) throws -> Void>.value(`body`).wrapAsGeneric())) as? (Query, Bool, @escaping (inout Query.Data) throws -> Void) -> Void
		perform?(`query`, `onlyIfExists`, `body`)
		do {
		    _ = try methodReturnValue(.m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Query.Data) throws -> Void>.value(`body`).wrapAsGeneric())).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func updateCache<Fragment: GQLFragment>(of fragment: Fragment, onlyIfExists: Bool, body: @escaping (inout Fragment) throws -> Void) throws {
        addInvocation(.m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(Parameter<Fragment>.value(`fragment`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Fragment) throws -> Void>.value(`body`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(Parameter<Fragment>.value(`fragment`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Fragment) throws -> Void>.value(`body`).wrapAsGeneric())) as? (Fragment, Bool, @escaping (inout Fragment) throws -> Void) -> Void
		perform?(`fragment`, `onlyIfExists`, `body`)
		do {
		    _ = try methodReturnValue(.m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(Parameter<Fragment>.value(`fragment`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Fragment) throws -> Void>.value(`body`).wrapAsGeneric())).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func cacheExists<Query: GQLQuery>(for query: Query) throws -> Bool {
        addInvocation(.m_cacheExists__for_query(Parameter<Query>.value(`query`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_cacheExists__for_query(Parameter<Query>.value(`query`).wrapAsGeneric())) as? (Query) -> Void
		perform?(`query`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_cacheExists__for_query(Parameter<Query>.value(`query`).wrapAsGeneric())).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for cacheExists<Query: GQLQuery>(for query: Query). Use given")
			Failure("Stub return value not specified for cacheExists<Query: GQLQuery>(for query: Query). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func cacheExists<Fragment: GQLFragment>(of fragment: Fragment) throws -> Bool {
        addInvocation(.m_cacheExists__of_fragment(Parameter<Fragment>.value(`fragment`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_cacheExists__of_fragment(Parameter<Fragment>.value(`fragment`).wrapAsGeneric())) as? (Fragment) -> Void
		perform?(`fragment`)
		var __value: Bool
		do {
		    __value = try methodReturnValue(.m_cacheExists__of_fragment(Parameter<Fragment>.value(`fragment`).wrapAsGeneric())).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for cacheExists<Fragment: GQLFragment>(of fragment: Fragment). Use given")
			Failure("Stub return value not specified for cacheExists<Fragment: GQLFragment>(of fragment: Fragment). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func clearCache() throws {
        addInvocation(.m_clearCache)
		let perform = methodPerformValue(.m_clearCache) as? () -> Void
		perform?()
		do {
		    _ = try methodReturnValue(.m_clearCache).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }


    fileprivate enum MethodType {
        case m_createCache__for_querydata_data(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(Parameter<GenericAttribute>, Parameter<Bool>, Parameter<GenericAttribute>)
        case m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(Parameter<GenericAttribute>, Parameter<Bool>, Parameter<GenericAttribute>)
        case m_cacheExists__for_query(Parameter<GenericAttribute>)
        case m_cacheExists__of_fragment(Parameter<GenericAttribute>)
        case m_clearCache

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createCache__for_querydata_data(let lhsQuery, let lhsData), .m_createCache__for_querydata_data(let rhsQuery, let rhsData)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "for query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "data"))
				return Matcher.ComparisonResult(results)

            case (.m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(let lhsQuery, let lhsOnlyifexists, let lhsBody), .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(let rhsQuery, let rhsOnlyifexists, let rhsBody)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "for query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOnlyifexists, rhs: rhsOnlyifexists, with: matcher), lhsOnlyifexists, rhsOnlyifexists, "onlyIfExists"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsBody, rhs: rhsBody, with: matcher), lhsBody, rhsBody, "body"))
				return Matcher.ComparisonResult(results)

            case (.m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(let lhsFragment, let lhsOnlyifexists, let lhsBody), .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(let rhsFragment, let rhsOnlyifexists, let rhsBody)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFragment, rhs: rhsFragment, with: matcher), lhsFragment, rhsFragment, "of fragment"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOnlyifexists, rhs: rhsOnlyifexists, with: matcher), lhsOnlyifexists, rhsOnlyifexists, "onlyIfExists"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsBody, rhs: rhsBody, with: matcher), lhsBody, rhsBody, "body"))
				return Matcher.ComparisonResult(results)

            case (.m_cacheExists__for_query(let lhsQuery), .m_cacheExists__for_query(let rhsQuery)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "for query"))
				return Matcher.ComparisonResult(results)

            case (.m_cacheExists__of_fragment(let lhsFragment), .m_cacheExists__of_fragment(let rhsFragment)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFragment, rhs: rhsFragment, with: matcher), lhsFragment, rhsFragment, "of fragment"))
				return Matcher.ComparisonResult(results)

            case (.m_clearCache, .m_clearCache): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_createCache__for_querydata_data(p0, p1): return p0.intValue + p1.intValue
            case let .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_cacheExists__for_query(p0): return p0.intValue
            case let .m_cacheExists__of_fragment(p0): return p0.intValue
            case .m_clearCache: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createCache__for_querydata_data: return ".createCache(for:data:)"
            case .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body: return ".updateCache(for:onlyIfExists:body:)"
            case .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body: return ".updateCache(of:onlyIfExists:body:)"
            case .m_cacheExists__for_query: return ".cacheExists(for:)"
            case .m_cacheExists__of_fragment: return ".cacheExists(of:)"
            case .m_clearCache: return ".clearCache()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func cacheExists<Query: GQLQuery>(for query: Parameter<Query>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_cacheExists__for_query(`query`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func cacheExists<Fragment: GQLFragment>(of fragment: Parameter<Fragment>, willReturn: Bool...) -> MethodStub {
            return Given(method: .m_cacheExists__of_fragment(`fragment`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createCache<Query:GQLQuery>(for query: Parameter<Query>, data: Parameter<Query.Data>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_createCache__for_querydata_data(`query`.wrapAsGeneric(), `data`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func createCache<Query: GQLQuery>(for query: Parameter<Query>, data: Parameter<Query.Data>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_createCache__for_querydata_data(`query`.wrapAsGeneric(), `data`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func updateCache<Query:GQLQuery>(for query: Parameter<Query>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Query.Data) throws -> Void>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(`query`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func updateCache<Query: GQLQuery>(for query: Parameter<Query>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Query.Data) throws -> Void>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(`query`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func updateCache<Fragment:GQLFragment>(of fragment: Parameter<Fragment>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Fragment) throws -> Void>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(`fragment`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func updateCache<Fragment: GQLFragment>(of fragment: Parameter<Fragment>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Fragment) throws -> Void>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(`fragment`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func cacheExists<Query:GQLQuery>(for query: Parameter<Query>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_cacheExists__for_query(`query`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func cacheExists<Query: GQLQuery>(for query: Parameter<Query>, willProduce: (StubberThrows<Bool>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_cacheExists__for_query(`query`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func cacheExists<Fragment:GQLFragment>(of fragment: Parameter<Fragment>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_cacheExists__of_fragment(`fragment`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func cacheExists<Fragment: GQLFragment>(of fragment: Parameter<Fragment>, willProduce: (StubberThrows<Bool>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_cacheExists__of_fragment(`fragment`.wrapAsGeneric()), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Bool).self)
			willProduce(stubber)
			return given
        }
        public static func clearCache(willThrow: Error...) -> MethodStub {
            return Given(method: .m_clearCache, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func clearCache(willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_clearCache, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createCache<Query>(for query: Parameter<Query>, data: Parameter<Query.Data>) -> Verify where Query:GQLQuery { return Verify(method: .m_createCache__for_querydata_data(`query`.wrapAsGeneric(), `data`.wrapAsGeneric()))}
        public static func updateCache<Query>(for query: Parameter<Query>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Query.Data) throws -> Void>) -> Verify where Query:GQLQuery { return Verify(method: .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(`query`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric()))}
        public static func updateCache<Fragment>(of fragment: Parameter<Fragment>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Fragment) throws -> Void>) -> Verify where Fragment:GQLFragment { return Verify(method: .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(`fragment`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric()))}
        public static func cacheExists<Query>(for query: Parameter<Query>) -> Verify where Query:GQLQuery { return Verify(method: .m_cacheExists__for_query(`query`.wrapAsGeneric()))}
        public static func cacheExists<Fragment>(of fragment: Parameter<Fragment>) -> Verify where Fragment:GQLFragment { return Verify(method: .m_cacheExists__of_fragment(`fragment`.wrapAsGeneric()))}
        public static func clearCache() -> Verify { return Verify(method: .m_clearCache)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createCache<Query>(for query: Parameter<Query>, data: Parameter<Query.Data>, perform: @escaping (Query, Query.Data) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_createCache__for_querydata_data(`query`.wrapAsGeneric(), `data`.wrapAsGeneric()), performs: perform)
        }
        public static func updateCache<Query>(for query: Parameter<Query>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Query.Data) throws -> Void>, perform: @escaping (Query, Bool, @escaping (inout Query.Data) throws -> Void) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_body(`query`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric()), performs: perform)
        }
        public static func updateCache<Fragment>(of fragment: Parameter<Fragment>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Fragment) throws -> Void>, perform: @escaping (Fragment, Bool, @escaping (inout Fragment) throws -> Void) -> Void) -> Perform where Fragment:GQLFragment {
            return Perform(method: .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_body(`fragment`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric()), performs: perform)
        }
        public static func cacheExists<Query>(for query: Parameter<Query>, perform: @escaping (Query) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_cacheExists__for_query(`query`.wrapAsGeneric()), performs: perform)
        }
        public static func cacheExists<Fragment>(of fragment: Parameter<Fragment>, perform: @escaping (Fragment) -> Void) -> Perform where Fragment:GQLFragment {
            return Perform(method: .m_cacheExists__of_fragment(`fragment`.wrapAsGeneric()), performs: perform)
        }
        public static func clearCache(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_clearCache, performs: perform)
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

// MARK: - KeyValueStore

open class KeyValueStoreMock: KeyValueStore, Mock {
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





    open func set<T: Codable>(_ object: T?, forKey key: String) throws {
        addInvocation(.m_set__objectforKey_key(Parameter<T?>.value(`object`).wrapAsGeneric(), Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_set__objectforKey_key(Parameter<T?>.value(`object`).wrapAsGeneric(), Parameter<String>.value(`key`))) as? (T?, String) -> Void
		perform?(`object`, `key`)
		do {
		    _ = try methodReturnValue(.m_set__objectforKey_key(Parameter<T?>.value(`object`).wrapAsGeneric(), Parameter<String>.value(`key`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func get<T: Codable>(forKey key: String) throws -> T? {
        addInvocation(.m_get__forKey_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_get__forKey_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
		var __value: T? = nil
		do {
		    __value = try methodReturnValue(.m_get__forKey_key(Parameter<String>.value(`key`))).casted()
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
		return __value
    }

    open func remove(key: String) {
        addInvocation(.m_remove__key_key(Parameter<String>.value(`key`)))
		let perform = methodPerformValue(.m_remove__key_key(Parameter<String>.value(`key`))) as? (String) -> Void
		perform?(`key`)
    }

    open func clear() {
        addInvocation(.m_clear)
		let perform = methodPerformValue(.m_clear) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_set__objectforKey_key(Parameter<GenericAttribute>, Parameter<String>)
        case m_get__forKey_key(Parameter<String>)
        case m_remove__key_key(Parameter<String>)
        case m_clear

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_set__objectforKey_key(let lhsObject, let lhsKey), .m_set__objectforKey_key(let rhsObject, let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsObject, rhs: rhsObject, with: matcher), lhsObject, rhsObject, "_ object"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_get__forKey_key(let lhsKey), .m_get__forKey_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "forKey key"))
				return Matcher.ComparisonResult(results)

            case (.m_remove__key_key(let lhsKey), .m_remove__key_key(let rhsKey)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsKey, rhs: rhsKey, with: matcher), lhsKey, rhsKey, "key"))
				return Matcher.ComparisonResult(results)

            case (.m_clear, .m_clear): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_set__objectforKey_key(p0, p1): return p0.intValue + p1.intValue
            case let .m_get__forKey_key(p0): return p0.intValue
            case let .m_remove__key_key(p0): return p0.intValue
            case .m_clear: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_set__objectforKey_key: return ".set(_:forKey:)"
            case .m_get__forKey_key: return ".get(forKey:)"
            case .m_remove__key_key: return ".remove(key:)"
            case .m_clear: return ".clear()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func get<T: Codable>(forKey key: Parameter<String>, willReturn: T?...) -> MethodStub {
            return Given(method: .m_get__forKey_key(`key`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func set<T:Codable>(_ object: Parameter<T?>, forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_set__objectforKey_key(`object`.wrapAsGeneric(), `key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func set<T: Codable>(_ object: Parameter<T?>, forKey key: Parameter<String>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_set__objectforKey_key(`object`.wrapAsGeneric(), `key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func get(forKey key: Parameter<String>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_get__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func get<T: Codable>(forKey key: Parameter<String>, willProduce: (StubberThrows<T?>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_get__forKey_key(`key`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (T?).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func set<T>(_ object: Parameter<T?>, forKey key: Parameter<String>) -> Verify where T:Codable { return Verify(method: .m_set__objectforKey_key(`object`.wrapAsGeneric(), `key`))}
        public static func get(forKey key: Parameter<String>) -> Verify { return Verify(method: .m_get__forKey_key(`key`))}
        public static func remove(key: Parameter<String>) -> Verify { return Verify(method: .m_remove__key_key(`key`))}
        public static func clear() -> Verify { return Verify(method: .m_clear)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func set<T>(_ object: Parameter<T?>, forKey key: Parameter<String>, perform: @escaping (T?, String) -> Void) -> Perform where T:Codable {
            return Perform(method: .m_set__objectforKey_key(`object`.wrapAsGeneric(), `key`), performs: perform)
        }
        public static func get(forKey key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_get__forKey_key(`key`), performs: perform)
        }
        public static func remove(key: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_remove__key_key(`key`), performs: perform)
        }
        public static func clear(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_clear, performs: perform)
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

// MARK: - Logger

open class LoggerMock: Logger, Mock {
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





    open func debug(message: @autoclosure () -> String, extra: [String: Any]) {
        addInvocation(.m_debug__message_messageextra_extra(Parameter<() -> String>.any, Parameter<[String: Any]>.value(`extra`)))
		let perform = methodPerformValue(.m_debug__message_messageextra_extra(Parameter<() -> String>.any, Parameter<[String: Any]>.value(`extra`))) as? (@autoclosure () -> String, [String: Any]) -> Void
		perform?(`message`(), `extra`)
    }

    open func info(message: @autoclosure () -> String, extra: [String: Any]) {
        addInvocation(.m_info__message_messageextra_extra(Parameter<() -> String>.any, Parameter<[String: Any]>.value(`extra`)))
		let perform = methodPerformValue(.m_info__message_messageextra_extra(Parameter<() -> String>.any, Parameter<[String: Any]>.value(`extra`))) as? (@autoclosure () -> String, [String: Any]) -> Void
		perform?(`message`(), `extra`)
    }

    open func warning(message: @autoclosure () -> String, extra: [String: Any]) {
        addInvocation(.m_warning__message_messageextra_extra(Parameter<() -> String>.any, Parameter<[String: Any]>.value(`extra`)))
		let perform = methodPerformValue(.m_warning__message_messageextra_extra(Parameter<() -> String>.any, Parameter<[String: Any]>.value(`extra`))) as? (@autoclosure () -> String, [String: Any]) -> Void
		perform?(`message`(), `extra`)
    }

    open func error(message: @autoclosure () -> String, extra: [String: Any]) {
        addInvocation(.m_error__message_messageextra_extra(Parameter<() -> String>.any, Parameter<[String: Any]>.value(`extra`)))
		let perform = methodPerformValue(.m_error__message_messageextra_extra(Parameter<() -> String>.any, Parameter<[String: Any]>.value(`extra`))) as? (@autoclosure () -> String, [String: Any]) -> Void
		perform?(`message`(), `extra`)
    }

    open func debug(message: @autoclosure () -> String) {
        addInvocation(.m_debug__message_message(Parameter<() -> String>.any))
		let perform = methodPerformValue(.m_debug__message_message(Parameter<() -> String>.any)) as? (@autoclosure () -> String) -> Void
		perform?(`message`())
    }

    open func info(message: @autoclosure () -> String) {
        addInvocation(.m_info__message_message(Parameter<() -> String>.any))
		let perform = methodPerformValue(.m_info__message_message(Parameter<() -> String>.any)) as? (@autoclosure () -> String) -> Void
		perform?(`message`())
    }

    open func warning(message: @autoclosure () -> String) {
        addInvocation(.m_warning__message_message(Parameter<() -> String>.any))
		let perform = methodPerformValue(.m_warning__message_message(Parameter<() -> String>.any)) as? (@autoclosure () -> String) -> Void
		perform?(`message`())
    }

    open func error(message: @autoclosure () -> String) {
        addInvocation(.m_error__message_message(Parameter<() -> String>.any))
		let perform = methodPerformValue(.m_error__message_message(Parameter<() -> String>.any)) as? (@autoclosure () -> String) -> Void
		perform?(`message`())
    }


    fileprivate enum MethodType {
        case m_debug__message_messageextra_extra(Parameter<() -> String>, Parameter<[String: Any]>)
        case m_info__message_messageextra_extra(Parameter<() -> String>, Parameter<[String: Any]>)
        case m_warning__message_messageextra_extra(Parameter<() -> String>, Parameter<[String: Any]>)
        case m_error__message_messageextra_extra(Parameter<() -> String>, Parameter<[String: Any]>)
        case m_debug__message_message(Parameter<() -> String>)
        case m_info__message_message(Parameter<() -> String>)
        case m_warning__message_message(Parameter<() -> String>)
        case m_error__message_message(Parameter<() -> String>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_debug__message_messageextra_extra(let lhsMessage, let lhsExtra), .m_debug__message_messageextra_extra(let rhsMessage, let rhsExtra)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsExtra, rhs: rhsExtra, with: matcher), lhsExtra, rhsExtra, "extra"))
				return Matcher.ComparisonResult(results)

            case (.m_info__message_messageextra_extra(let lhsMessage, let lhsExtra), .m_info__message_messageextra_extra(let rhsMessage, let rhsExtra)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsExtra, rhs: rhsExtra, with: matcher), lhsExtra, rhsExtra, "extra"))
				return Matcher.ComparisonResult(results)

            case (.m_warning__message_messageextra_extra(let lhsMessage, let lhsExtra), .m_warning__message_messageextra_extra(let rhsMessage, let rhsExtra)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsExtra, rhs: rhsExtra, with: matcher), lhsExtra, rhsExtra, "extra"))
				return Matcher.ComparisonResult(results)

            case (.m_error__message_messageextra_extra(let lhsMessage, let lhsExtra), .m_error__message_messageextra_extra(let rhsMessage, let rhsExtra)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsExtra, rhs: rhsExtra, with: matcher), lhsExtra, rhsExtra, "extra"))
				return Matcher.ComparisonResult(results)

            case (.m_debug__message_message(let lhsMessage), .m_debug__message_message(let rhsMessage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				return Matcher.ComparisonResult(results)

            case (.m_info__message_message(let lhsMessage), .m_info__message_message(let rhsMessage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				return Matcher.ComparisonResult(results)

            case (.m_warning__message_message(let lhsMessage), .m_warning__message_message(let rhsMessage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				return Matcher.ComparisonResult(results)

            case (.m_error__message_message(let lhsMessage), .m_error__message_message(let rhsMessage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_debug__message_messageextra_extra(p0, p1): return p0.intValue + p1.intValue
            case let .m_info__message_messageextra_extra(p0, p1): return p0.intValue + p1.intValue
            case let .m_warning__message_messageextra_extra(p0, p1): return p0.intValue + p1.intValue
            case let .m_error__message_messageextra_extra(p0, p1): return p0.intValue + p1.intValue
            case let .m_debug__message_message(p0): return p0.intValue
            case let .m_info__message_message(p0): return p0.intValue
            case let .m_warning__message_message(p0): return p0.intValue
            case let .m_error__message_message(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_debug__message_messageextra_extra: return ".debug(message:extra:)"
            case .m_info__message_messageextra_extra: return ".info(message:extra:)"
            case .m_warning__message_messageextra_extra: return ".warning(message:extra:)"
            case .m_error__message_messageextra_extra: return ".error(message:extra:)"
            case .m_debug__message_message: return ".debug(message:)"
            case .m_info__message_message: return ".info(message:)"
            case .m_warning__message_message: return ".warning(message:)"
            case .m_error__message_message: return ".error(message:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func debug(message: Parameter<() -> String>, extra: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_debug__message_messageextra_extra(`message`, `extra`))}
        public static func info(message: Parameter<() -> String>, extra: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_info__message_messageextra_extra(`message`, `extra`))}
        public static func warning(message: Parameter<() -> String>, extra: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_warning__message_messageextra_extra(`message`, `extra`))}
        public static func error(message: Parameter<() -> String>, extra: Parameter<[String: Any]>) -> Verify { return Verify(method: .m_error__message_messageextra_extra(`message`, `extra`))}
        public static func debug(message: Parameter<() -> String>) -> Verify { return Verify(method: .m_debug__message_message(`message`))}
        public static func info(message: Parameter<() -> String>) -> Verify { return Verify(method: .m_info__message_message(`message`))}
        public static func warning(message: Parameter<() -> String>) -> Verify { return Verify(method: .m_warning__message_message(`message`))}
        public static func error(message: Parameter<() -> String>) -> Verify { return Verify(method: .m_error__message_message(`message`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func debug(message: Parameter<() -> String>, extra: Parameter<[String: Any]>, perform: @escaping (@autoclosure () -> String, [String: Any]) -> Void) -> Perform {
            return Perform(method: .m_debug__message_messageextra_extra(`message`, `extra`), performs: perform)
        }
        public static func info(message: Parameter<() -> String>, extra: Parameter<[String: Any]>, perform: @escaping (@autoclosure () -> String, [String: Any]) -> Void) -> Perform {
            return Perform(method: .m_info__message_messageextra_extra(`message`, `extra`), performs: perform)
        }
        public static func warning(message: Parameter<() -> String>, extra: Parameter<[String: Any]>, perform: @escaping (@autoclosure () -> String, [String: Any]) -> Void) -> Perform {
            return Perform(method: .m_warning__message_messageextra_extra(`message`, `extra`), performs: perform)
        }
        public static func error(message: Parameter<() -> String>, extra: Parameter<[String: Any]>, perform: @escaping (@autoclosure () -> String, [String: Any]) -> Void) -> Perform {
            return Perform(method: .m_error__message_messageextra_extra(`message`, `extra`), performs: perform)
        }
        public static func debug(message: Parameter<() -> String>, perform: @escaping (@autoclosure () -> String) -> Void) -> Perform {
            return Perform(method: .m_debug__message_message(`message`), performs: perform)
        }
        public static func info(message: Parameter<() -> String>, perform: @escaping (@autoclosure () -> String) -> Void) -> Perform {
            return Perform(method: .m_info__message_message(`message`), performs: perform)
        }
        public static func warning(message: Parameter<() -> String>, perform: @escaping (@autoclosure () -> String) -> Void) -> Perform {
            return Perform(method: .m_warning__message_message(`message`), performs: perform)
        }
        public static func error(message: Parameter<() -> String>, perform: @escaping (@autoclosure () -> String) -> Void) -> Perform {
            return Perform(method: .m_error__message_message(`message`), performs: perform)
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

// MARK: - VideoCallClient

open class VideoCallClientMock: VideoCallClient, Mock {
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

    public var crossModuleViews: VideoCallViewFactory {
		get {	invocations.append(.p_crossModuleViews_get); return __p_crossModuleViews ?? givenGetterValue(.p_crossModuleViews_get, "VideoCallClientMock - stub value for crossModuleViews was not defined") }
	}
	private var __p_crossModuleViews: (VideoCallViewFactory)?

    public var currentVideoCallToken: String? {
		get {	invocations.append(.p_currentVideoCallToken_get); return __p_currentVideoCallToken ?? optionalGivenGetterValue(.p_currentVideoCallToken_get, "VideoCallClientMock - stub value for currentVideoCallToken was not defined") }
	}
	private var __p_currentVideoCallToken: (String)?





    open func watchCurrentVideoCall() -> AnyPublisher<String?, Never> {
        addInvocation(.m_watchCurrentVideoCall)
		let perform = methodPerformValue(.m_watchCurrentVideoCall) as? () -> Void
		perform?()
		var __value: AnyPublisher<String?, Never>
		do {
		    __value = try methodReturnValue(.m_watchCurrentVideoCall).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchCurrentVideoCall(). Use given")
			Failure("Stub return value not specified for watchCurrentVideoCall(). Use given")
		}
		return __value
    }

    open func openVideoCallRoom(url: String, token: String, from viewController: UIViewController) {
        addInvocation(.m_openVideoCallRoom__url_urltoken_tokenfrom_viewController(Parameter<String>.value(`url`), Parameter<String>.value(`token`), Parameter<UIViewController>.value(`viewController`)))
		let perform = methodPerformValue(.m_openVideoCallRoom__url_urltoken_tokenfrom_viewController(Parameter<String>.value(`url`), Parameter<String>.value(`token`), Parameter<UIViewController>.value(`viewController`))) as? (String, String, UIViewController) -> Void
		perform?(`url`, `token`, `viewController`)
    }


    fileprivate enum MethodType {
        case m_watchCurrentVideoCall
        case m_openVideoCallRoom__url_urltoken_tokenfrom_viewController(Parameter<String>, Parameter<String>, Parameter<UIViewController>)
        case p_crossModuleViews_get
        case p_currentVideoCallToken_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_watchCurrentVideoCall, .m_watchCurrentVideoCall): return .match

            case (.m_openVideoCallRoom__url_urltoken_tokenfrom_viewController(let lhsUrl, let lhsToken, let lhsViewcontroller), .m_openVideoCallRoom__url_urltoken_tokenfrom_viewController(let rhsUrl, let rhsToken, let rhsViewcontroller)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher), lhsUrl, rhsUrl, "url"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsToken, rhs: rhsToken, with: matcher), lhsToken, rhsToken, "token"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsViewcontroller, rhs: rhsViewcontroller, with: matcher), lhsViewcontroller, rhsViewcontroller, "from viewController"))
				return Matcher.ComparisonResult(results)
            case (.p_crossModuleViews_get,.p_crossModuleViews_get): return Matcher.ComparisonResult.match
            case (.p_currentVideoCallToken_get,.p_currentVideoCallToken_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_watchCurrentVideoCall: return 0
            case let .m_openVideoCallRoom__url_urltoken_tokenfrom_viewController(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case .p_crossModuleViews_get: return 0
            case .p_currentVideoCallToken_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_watchCurrentVideoCall: return ".watchCurrentVideoCall()"
            case .m_openVideoCallRoom__url_urltoken_tokenfrom_viewController: return ".openVideoCallRoom(url:token:from:)"
            case .p_crossModuleViews_get: return "[get] .crossModuleViews"
            case .p_currentVideoCallToken_get: return "[get] .currentVideoCallToken"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func crossModuleViews(getter defaultValue: VideoCallViewFactory...) -> PropertyStub {
            return Given(method: .p_crossModuleViews_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }
        public static func currentVideoCallToken(getter defaultValue: String?...) -> PropertyStub {
            return Given(method: .p_currentVideoCallToken_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func watchCurrentVideoCall(willReturn: AnyPublisher<String?, Never>...) -> MethodStub {
            return Given(method: .m_watchCurrentVideoCall, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchCurrentVideoCall(willProduce: (Stubber<AnyPublisher<String?, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<String?, Never>] = []
			let given: Given = { return Given(method: .m_watchCurrentVideoCall, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<String?, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func watchCurrentVideoCall() -> Verify { return Verify(method: .m_watchCurrentVideoCall)}
        public static func openVideoCallRoom(url: Parameter<String>, token: Parameter<String>, from viewController: Parameter<UIViewController>) -> Verify { return Verify(method: .m_openVideoCallRoom__url_urltoken_tokenfrom_viewController(`url`, `token`, `viewController`))}
        public static var crossModuleViews: Verify { return Verify(method: .p_crossModuleViews_get) }
        public static var currentVideoCallToken: Verify { return Verify(method: .p_currentVideoCallToken_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func watchCurrentVideoCall(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_watchCurrentVideoCall, performs: perform)
        }
        public static func openVideoCallRoom(url: Parameter<String>, token: Parameter<String>, from viewController: Parameter<UIViewController>, perform: @escaping (String, String, UIViewController) -> Void) -> Perform {
            return Perform(method: .m_openVideoCallRoom__url_urltoken_tokenfrom_viewController(`url`, `token`, `viewController`), performs: perform)
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

// MARK: - VideoCallViewFactory

open class VideoCallViewFactoryMock: VideoCallViewFactory, Mock {
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






    fileprivate struct MethodType {
        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult { return .match }
        func intValue() -> Int { return 0 }
        func assertionName() -> String { return "" }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


    }

    public struct Verify {
        fileprivate var method: MethodType

    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

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

