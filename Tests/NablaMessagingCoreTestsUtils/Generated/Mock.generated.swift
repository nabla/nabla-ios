// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import NablaCore
@testable import NablaMessagingCore


// MARK: - ConversationItemLocalDataSource

open class ConversationItemLocalDataSourceMock: ConversationItemLocalDataSource, Mock {
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





    open func getConversationItems(ofConversationWithId conversationId: UUID) -> [LocalConversationItem] {
        addInvocation(.m_getConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_getConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		var __value: [LocalConversationItem]
		do {
		    __value = try methodReturnValue(.m_getConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getConversationItems(ofConversationWithId conversationId: UUID). Use given")
			Failure("Stub return value not specified for getConversationItems(ofConversationWithId conversationId: UUID). Use given")
		}
		return __value
    }

    open func getConversationItem(withClientId clientId: UUID) -> LocalConversationItem? {
        addInvocation(.m_getConversationItem__withClientId_clientId(Parameter<UUID>.value(`clientId`)))
		let perform = methodPerformValue(.m_getConversationItem__withClientId_clientId(Parameter<UUID>.value(`clientId`))) as? (UUID) -> Void
		perform?(`clientId`)
		var __value: LocalConversationItem? = nil
		do {
		    __value = try methodReturnValue(.m_getConversationItem__withClientId_clientId(Parameter<UUID>.value(`clientId`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func watchConversationItems(ofConversationWithId conversationId: UUID, callback: @escaping ([LocalConversationItem]) -> Void) -> Cancellable {
        addInvocation(.m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(Parameter<UUID>.value(`conversationId`), Parameter<([LocalConversationItem]) -> Void>.value(`callback`)))
		let perform = methodPerformValue(.m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(Parameter<UUID>.value(`conversationId`), Parameter<([LocalConversationItem]) -> Void>.value(`callback`))) as? (UUID, @escaping ([LocalConversationItem]) -> Void) -> Void
		perform?(`conversationId`, `callback`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(Parameter<UUID>.value(`conversationId`), Parameter<([LocalConversationItem]) -> Void>.value(`callback`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversationItems(ofConversationWithId conversationId: UUID, callback: @escaping ([LocalConversationItem]) -> Void). Use given")
			Failure("Stub return value not specified for watchConversationItems(ofConversationWithId conversationId: UUID, callback: @escaping ([LocalConversationItem]) -> Void). Use given")
		}
		return __value
    }

    open func addConversationItem(_ conversationItem: LocalConversationItem) {
        addInvocation(.m_addConversationItem__conversationItem(Parameter<LocalConversationItem>.value(`conversationItem`)))
		let perform = methodPerformValue(.m_addConversationItem__conversationItem(Parameter<LocalConversationItem>.value(`conversationItem`))) as? (LocalConversationItem) -> Void
		perform?(`conversationItem`)
    }

    open func updateConversationItem(_ conversationItem: LocalConversationItem) {
        addInvocation(.m_updateConversationItem__conversationItem(Parameter<LocalConversationItem>.value(`conversationItem`)))
		let perform = methodPerformValue(.m_updateConversationItem__conversationItem(Parameter<LocalConversationItem>.value(`conversationItem`))) as? (LocalConversationItem) -> Void
		perform?(`conversationItem`)
    }

    open func updateConversationItems(_ conversationItems: [LocalConversationItem]) {
        addInvocation(.m_updateConversationItems__conversationItems(Parameter<[LocalConversationItem]>.value(`conversationItems`)))
		let perform = methodPerformValue(.m_updateConversationItems__conversationItems(Parameter<[LocalConversationItem]>.value(`conversationItems`))) as? ([LocalConversationItem]) -> Void
		perform?(`conversationItems`)
    }

    open func removeConversationItem(withClientId clientId: UUID) {
        addInvocation(.m_removeConversationItem__withClientId_clientId(Parameter<UUID>.value(`clientId`)))
		let perform = methodPerformValue(.m_removeConversationItem__withClientId_clientId(Parameter<UUID>.value(`clientId`))) as? (UUID) -> Void
		perform?(`clientId`)
    }


    fileprivate enum MethodType {
        case m_getConversationItems__ofConversationWithId_conversationId(Parameter<UUID>)
        case m_getConversationItem__withClientId_clientId(Parameter<UUID>)
        case m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(Parameter<UUID>, Parameter<([LocalConversationItem]) -> Void>)
        case m_addConversationItem__conversationItem(Parameter<LocalConversationItem>)
        case m_updateConversationItem__conversationItem(Parameter<LocalConversationItem>)
        case m_updateConversationItems__conversationItems(Parameter<[LocalConversationItem]>)
        case m_removeConversationItem__withClientId_clientId(Parameter<UUID>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getConversationItems__ofConversationWithId_conversationId(let lhsConversationid), .m_getConversationItems__ofConversationWithId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_getConversationItem__withClientId_clientId(let lhsClientid), .m_getConversationItem__withClientId_clientId(let rhsClientid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClientid, rhs: rhsClientid, with: matcher), lhsClientid, rhsClientid, "withClientId clientId"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(let lhsConversationid, let lhsCallback), .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(let rhsConversationid, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)

            case (.m_addConversationItem__conversationItem(let lhsConversationitem), .m_addConversationItem__conversationItem(let rhsConversationitem)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationitem, rhs: rhsConversationitem, with: matcher), lhsConversationitem, rhsConversationitem, "_ conversationItem"))
				return Matcher.ComparisonResult(results)

            case (.m_updateConversationItem__conversationItem(let lhsConversationitem), .m_updateConversationItem__conversationItem(let rhsConversationitem)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationitem, rhs: rhsConversationitem, with: matcher), lhsConversationitem, rhsConversationitem, "_ conversationItem"))
				return Matcher.ComparisonResult(results)

            case (.m_updateConversationItems__conversationItems(let lhsConversationitems), .m_updateConversationItems__conversationItems(let rhsConversationitems)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationitems, rhs: rhsConversationitems, with: matcher), lhsConversationitems, rhsConversationitems, "_ conversationItems"))
				return Matcher.ComparisonResult(results)

            case (.m_removeConversationItem__withClientId_clientId(let lhsClientid), .m_removeConversationItem__withClientId_clientId(let rhsClientid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClientid, rhs: rhsClientid, with: matcher), lhsClientid, rhsClientid, "withClientId clientId"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getConversationItems__ofConversationWithId_conversationId(p0): return p0.intValue
            case let .m_getConversationItem__withClientId_clientId(p0): return p0.intValue
            case let .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(p0, p1): return p0.intValue + p1.intValue
            case let .m_addConversationItem__conversationItem(p0): return p0.intValue
            case let .m_updateConversationItem__conversationItem(p0): return p0.intValue
            case let .m_updateConversationItems__conversationItems(p0): return p0.intValue
            case let .m_removeConversationItem__withClientId_clientId(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getConversationItems__ofConversationWithId_conversationId: return ".getConversationItems(ofConversationWithId:)"
            case .m_getConversationItem__withClientId_clientId: return ".getConversationItem(withClientId:)"
            case .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback: return ".watchConversationItems(ofConversationWithId:callback:)"
            case .m_addConversationItem__conversationItem: return ".addConversationItem(_:)"
            case .m_updateConversationItem__conversationItem: return ".updateConversationItem(_:)"
            case .m_updateConversationItems__conversationItems: return ".updateConversationItems(_:)"
            case .m_removeConversationItem__withClientId_clientId: return ".removeConversationItem(withClientId:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getConversationItems(ofConversationWithId conversationId: Parameter<UUID>, willReturn: [LocalConversationItem]...) -> MethodStub {
            return Given(method: .m_getConversationItems__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getConversationItem(withClientId clientId: Parameter<UUID>, willReturn: LocalConversationItem?...) -> MethodStub {
            return Given(method: .m_getConversationItem__withClientId_clientId(`clientId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, callback: Parameter<([LocalConversationItem]) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(`conversationId`, `callback`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getConversationItems(ofConversationWithId conversationId: Parameter<UUID>, willProduce: (Stubber<[LocalConversationItem]>) -> Void) -> MethodStub {
            let willReturn: [[LocalConversationItem]] = []
			let given: Given = { return Given(method: .m_getConversationItems__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: ([LocalConversationItem]).self)
			willProduce(stubber)
			return given
        }
        public static func getConversationItem(withClientId clientId: Parameter<UUID>, willProduce: (Stubber<LocalConversationItem?>) -> Void) -> MethodStub {
            let willReturn: [LocalConversationItem?] = []
			let given: Given = { return Given(method: .m_getConversationItem__withClientId_clientId(`clientId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (LocalConversationItem?).self)
			willProduce(stubber)
			return given
        }
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, callback: Parameter<([LocalConversationItem]) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(`conversationId`, `callback`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getConversationItems(ofConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_getConversationItems__ofConversationWithId_conversationId(`conversationId`))}
        public static func getConversationItem(withClientId clientId: Parameter<UUID>) -> Verify { return Verify(method: .m_getConversationItem__withClientId_clientId(`clientId`))}
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, callback: Parameter<([LocalConversationItem]) -> Void>) -> Verify { return Verify(method: .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(`conversationId`, `callback`))}
        public static func addConversationItem(_ conversationItem: Parameter<LocalConversationItem>) -> Verify { return Verify(method: .m_addConversationItem__conversationItem(`conversationItem`))}
        public static func updateConversationItem(_ conversationItem: Parameter<LocalConversationItem>) -> Verify { return Verify(method: .m_updateConversationItem__conversationItem(`conversationItem`))}
        public static func updateConversationItems(_ conversationItems: Parameter<[LocalConversationItem]>) -> Verify { return Verify(method: .m_updateConversationItems__conversationItems(`conversationItems`))}
        public static func removeConversationItem(withClientId clientId: Parameter<UUID>) -> Verify { return Verify(method: .m_removeConversationItem__withClientId_clientId(`clientId`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getConversationItems(ofConversationWithId conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_getConversationItems__ofConversationWithId_conversationId(`conversationId`), performs: perform)
        }
        public static func getConversationItem(withClientId clientId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_getConversationItem__withClientId_clientId(`clientId`), performs: perform)
        }
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, callback: Parameter<([LocalConversationItem]) -> Void>, perform: @escaping (UUID, @escaping ([LocalConversationItem]) -> Void) -> Void) -> Perform {
            return Perform(method: .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(`conversationId`, `callback`), performs: perform)
        }
        public static func addConversationItem(_ conversationItem: Parameter<LocalConversationItem>, perform: @escaping (LocalConversationItem) -> Void) -> Perform {
            return Perform(method: .m_addConversationItem__conversationItem(`conversationItem`), performs: perform)
        }
        public static func updateConversationItem(_ conversationItem: Parameter<LocalConversationItem>, perform: @escaping (LocalConversationItem) -> Void) -> Perform {
            return Perform(method: .m_updateConversationItem__conversationItem(`conversationItem`), performs: perform)
        }
        public static func updateConversationItems(_ conversationItems: Parameter<[LocalConversationItem]>, perform: @escaping ([LocalConversationItem]) -> Void) -> Perform {
            return Perform(method: .m_updateConversationItems__conversationItems(`conversationItems`), performs: perform)
        }
        public static func removeConversationItem(withClientId clientId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_removeConversationItem__withClientId_clientId(`clientId`), performs: perform)
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

// MARK: - ConversationItemRemoteDataSource

open class ConversationItemRemoteDataSourceMock: ConversationItemRemoteDataSource, Mock {
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





    open func watchConversationItems(ofConversationWithId conversationId: UUID, handler: ResultHandler<RemoteConversationItems, GQLError>) -> PaginatedWatcher {
        addInvocation(.m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<RemoteConversationItems, GQLError>>.value(`handler`)))
		let perform = methodPerformValue(.m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<RemoteConversationItems, GQLError>>.value(`handler`))) as? (UUID, ResultHandler<RemoteConversationItems, GQLError>) -> Void
		perform?(`conversationId`, `handler`)
		var __value: PaginatedWatcher
		do {
		    __value = try methodReturnValue(.m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<RemoteConversationItems, GQLError>>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversationItems(ofConversationWithId conversationId: UUID, handler: ResultHandler<RemoteConversationItems, GQLError>). Use given")
			Failure("Stub return value not specified for watchConversationItems(ofConversationWithId conversationId: UUID, handler: ResultHandler<RemoteConversationItems, GQLError>). Use given")
		}
		return __value
    }

    open func subscribeToConversationItemsEvents(ofConversationWithId conversationId: UUID, handler: ResultHandler<RemoteConversationEvent, GQLError>) -> Cancellable {
        addInvocation(.m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<RemoteConversationEvent, GQLError>>.value(`handler`)))
		let perform = methodPerformValue(.m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<RemoteConversationEvent, GQLError>>.value(`handler`))) as? (UUID, ResultHandler<RemoteConversationEvent, GQLError>) -> Void
		perform?(`conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<RemoteConversationEvent, GQLError>>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for subscribeToConversationItemsEvents(ofConversationWithId conversationId: UUID, handler: ResultHandler<RemoteConversationEvent, GQLError>). Use given")
			Failure("Stub return value not specified for subscribeToConversationItemsEvents(ofConversationWithId conversationId: UUID, handler: ResultHandler<RemoteConversationEvent, GQLError>). Use given")
		}
		return __value
    }

    open func send(remoteMessageInput: GQL.SendMessageInput, conversationId: UUID, handler: ResultHandler<Void, GQLError>) -> Cancellable {
        addInvocation(.m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(Parameter<GQL.SendMessageInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`)))
		let perform = methodPerformValue(.m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(Parameter<GQL.SendMessageInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))) as? (GQL.SendMessageInput, UUID, ResultHandler<Void, GQLError>) -> Void
		perform?(`remoteMessageInput`, `conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(Parameter<GQL.SendMessageInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for send(remoteMessageInput: GQL.SendMessageInput, conversationId: UUID, handler: ResultHandler<Void, GQLError>). Use given")
			Failure("Stub return value not specified for send(remoteMessageInput: GQL.SendMessageInput, conversationId: UUID, handler: ResultHandler<Void, GQLError>). Use given")
		}
		return __value
    }

    open func delete(messageId: UUID, handler: ResultHandler<Void, GQLError>) -> Cancellable {
        addInvocation(.m_delete__messageId_messageIdhandler_handler(Parameter<UUID>.value(`messageId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`)))
		let perform = methodPerformValue(.m_delete__messageId_messageIdhandler_handler(Parameter<UUID>.value(`messageId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))) as? (UUID, ResultHandler<Void, GQLError>) -> Void
		perform?(`messageId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_delete__messageId_messageIdhandler_handler(Parameter<UUID>.value(`messageId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for delete(messageId: UUID, handler: ResultHandler<Void, GQLError>). Use given")
			Failure("Stub return value not specified for delete(messageId: UUID, handler: ResultHandler<Void, GQLError>). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>, Parameter<ResultHandler<RemoteConversationItems, GQLError>>)
        case m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>, Parameter<ResultHandler<RemoteConversationEvent, GQLError>>)
        case m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(Parameter<GQL.SendMessageInput>, Parameter<UUID>, Parameter<ResultHandler<Void, GQLError>>)
        case m_delete__messageId_messageIdhandler_handler(Parameter<UUID>, Parameter<ResultHandler<Void, GQLError>>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(let lhsConversationid, let lhsHandler), .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(let lhsConversationid, let lhsHandler), .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(let lhsRemotemessageinput, let lhsConversationid, let lhsHandler), .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(let rhsRemotemessageinput, let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRemotemessageinput, rhs: rhsRemotemessageinput, with: matcher), lhsRemotemessageinput, rhsRemotemessageinput, "remoteMessageInput"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_delete__messageId_messageIdhandler_handler(let lhsMessageid, let lhsHandler), .m_delete__messageId_messageIdhandler_handler(let rhsMessageid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessageid, rhs: rhsMessageid, with: matcher), lhsMessageid, rhsMessageid, "messageId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_delete__messageId_messageIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler: return ".watchConversationItems(ofConversationWithId:handler:)"
            case .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler: return ".subscribeToConversationItemsEvents(ofConversationWithId:handler:)"
            case .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler: return ".send(remoteMessageInput:conversationId:handler:)"
            case .m_delete__messageId_messageIdhandler_handler: return ".delete(messageId:handler:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationItems, GQLError>>, willReturn: PaginatedWatcher...) -> MethodStub {
            return Given(method: .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationEvent, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func send(remoteMessageInput: Parameter<GQL.SendMessageInput>, conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(`remoteMessageInput`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func delete(messageId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_delete__messageId_messageIdhandler_handler(`messageId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationItems, GQLError>>, willProduce: (Stubber<PaginatedWatcher>) -> Void) -> MethodStub {
            let willReturn: [PaginatedWatcher] = []
			let given: Given = { return Given(method: .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (PaginatedWatcher).self)
			willProduce(stubber)
			return given
        }
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationEvent, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func send(remoteMessageInput: Parameter<GQL.SendMessageInput>, conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(`remoteMessageInput`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func delete(messageId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_delete__messageId_messageIdhandler_handler(`messageId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationItems, GQLError>>) -> Verify { return Verify(method: .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`))}
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationEvent, GQLError>>) -> Verify { return Verify(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`))}
        public static func send(remoteMessageInput: Parameter<GQL.SendMessageInput>, conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>) -> Verify { return Verify(method: .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(`remoteMessageInput`, `conversationId`, `handler`))}
        public static func delete(messageId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>) -> Verify { return Verify(method: .m_delete__messageId_messageIdhandler_handler(`messageId`, `handler`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationItems, GQLError>>, perform: @escaping (UUID, ResultHandler<RemoteConversationItems, GQLError>) -> Void) -> Perform {
            return Perform(method: .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), performs: perform)
        }
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationEvent, GQLError>>, perform: @escaping (UUID, ResultHandler<RemoteConversationEvent, GQLError>) -> Void) -> Perform {
            return Perform(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), performs: perform)
        }
        public static func send(remoteMessageInput: Parameter<GQL.SendMessageInput>, conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, perform: @escaping (GQL.SendMessageInput, UUID, ResultHandler<Void, GQLError>) -> Void) -> Perform {
            return Perform(method: .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationIdhandler_handler(`remoteMessageInput`, `conversationId`, `handler`), performs: perform)
        }
        public static func delete(messageId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, perform: @escaping (UUID, ResultHandler<Void, GQLError>) -> Void) -> Perform {
            return Perform(method: .m_delete__messageId_messageIdhandler_handler(`messageId`, `handler`), performs: perform)
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

