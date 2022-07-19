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

    open func getConversationItem(withClientId clientId: UUID, inConversationWithId conversationId: UUID) -> LocalConversationItem? {
        addInvocation(.m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(Parameter<UUID>.value(`clientId`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(Parameter<UUID>.value(`clientId`), Parameter<UUID>.value(`conversationId`))) as? (UUID, UUID) -> Void
		perform?(`clientId`, `conversationId`)
		var __value: LocalConversationItem? = nil
		do {
		    __value = try methodReturnValue(.m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(Parameter<UUID>.value(`clientId`), Parameter<UUID>.value(`conversationId`))).casted()
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

    open func addConversationItem(_ conversationItem: LocalConversationItem, toConversationWithId conversationId: UUID) {
        addInvocation(.m_addConversationItem__conversationItemtoConversationWithId_conversationId(Parameter<LocalConversationItem>.value(`conversationItem`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_addConversationItem__conversationItemtoConversationWithId_conversationId(Parameter<LocalConversationItem>.value(`conversationItem`), Parameter<UUID>.value(`conversationId`))) as? (LocalConversationItem, UUID) -> Void
		perform?(`conversationItem`, `conversationId`)
    }

    open func updateConversationItem(_ conversationItem: LocalConversationItem, inConversationWithId conversationId: UUID) {
        addInvocation(.m_updateConversationItem__conversationIteminConversationWithId_conversationId(Parameter<LocalConversationItem>.value(`conversationItem`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_updateConversationItem__conversationIteminConversationWithId_conversationId(Parameter<LocalConversationItem>.value(`conversationItem`), Parameter<UUID>.value(`conversationId`))) as? (LocalConversationItem, UUID) -> Void
		perform?(`conversationItem`, `conversationId`)
    }


    fileprivate enum MethodType {
        case m_getConversationItems__ofConversationWithId_conversationId(Parameter<UUID>)
        case m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(Parameter<UUID>, Parameter<UUID>)
        case m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(Parameter<UUID>, Parameter<([LocalConversationItem]) -> Void>)
        case m_addConversationItem__conversationItemtoConversationWithId_conversationId(Parameter<LocalConversationItem>, Parameter<UUID>)
        case m_updateConversationItem__conversationIteminConversationWithId_conversationId(Parameter<LocalConversationItem>, Parameter<UUID>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getConversationItems__ofConversationWithId_conversationId(let lhsConversationid), .m_getConversationItems__ofConversationWithId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(let lhsClientid, let lhsConversationid), .m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(let rhsClientid, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsClientid, rhs: rhsClientid, with: matcher), lhsClientid, rhsClientid, "withClientId clientId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(let lhsConversationid, let lhsCallback), .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(let rhsConversationid, let rhsCallback)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCallback, rhs: rhsCallback, with: matcher), lhsCallback, rhsCallback, "callback"))
				return Matcher.ComparisonResult(results)

            case (.m_addConversationItem__conversationItemtoConversationWithId_conversationId(let lhsConversationitem, let lhsConversationid), .m_addConversationItem__conversationItemtoConversationWithId_conversationId(let rhsConversationitem, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationitem, rhs: rhsConversationitem, with: matcher), lhsConversationitem, rhsConversationitem, "_ conversationItem"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "toConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_updateConversationItem__conversationIteminConversationWithId_conversationId(let lhsConversationitem, let lhsConversationid), .m_updateConversationItem__conversationIteminConversationWithId_conversationId(let rhsConversationitem, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationitem, rhs: rhsConversationitem, with: matcher), lhsConversationitem, rhsConversationitem, "_ conversationItem"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getConversationItems__ofConversationWithId_conversationId(p0): return p0.intValue
            case let .m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(p0, p1): return p0.intValue + p1.intValue
            case let .m_addConversationItem__conversationItemtoConversationWithId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_updateConversationItem__conversationIteminConversationWithId_conversationId(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getConversationItems__ofConversationWithId_conversationId: return ".getConversationItems(ofConversationWithId:)"
            case .m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId: return ".getConversationItem(withClientId:inConversationWithId:)"
            case .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback: return ".watchConversationItems(ofConversationWithId:callback:)"
            case .m_addConversationItem__conversationItemtoConversationWithId_conversationId: return ".addConversationItem(_:toConversationWithId:)"
            case .m_updateConversationItem__conversationIteminConversationWithId_conversationId: return ".updateConversationItem(_:inConversationWithId:)"
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
        public static func getConversationItem(withClientId clientId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, willReturn: LocalConversationItem?...) -> MethodStub {
            return Given(method: .m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(`clientId`, `conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
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
        public static func getConversationItem(withClientId clientId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, willProduce: (Stubber<LocalConversationItem?>) -> Void) -> MethodStub {
            let willReturn: [LocalConversationItem?] = []
			let given: Given = { return Given(method: .m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(`clientId`, `conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
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
        public static func getConversationItem(withClientId clientId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(`clientId`, `conversationId`))}
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, callback: Parameter<([LocalConversationItem]) -> Void>) -> Verify { return Verify(method: .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(`conversationId`, `callback`))}
        public static func addConversationItem(_ conversationItem: Parameter<LocalConversationItem>, toConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_addConversationItem__conversationItemtoConversationWithId_conversationId(`conversationItem`, `conversationId`))}
        public static func updateConversationItem(_ conversationItem: Parameter<LocalConversationItem>, inConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_updateConversationItem__conversationIteminConversationWithId_conversationId(`conversationItem`, `conversationId`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getConversationItems(ofConversationWithId conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_getConversationItems__ofConversationWithId_conversationId(`conversationId`), performs: perform)
        }
        public static func getConversationItem(withClientId clientId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, perform: @escaping (UUID, UUID) -> Void) -> Perform {
            return Perform(method: .m_getConversationItem__withClientId_clientIdinConversationWithId_conversationId(`clientId`, `conversationId`), performs: perform)
        }
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, callback: Parameter<([LocalConversationItem]) -> Void>, perform: @escaping (UUID, @escaping ([LocalConversationItem]) -> Void) -> Void) -> Perform {
            return Perform(method: .m_watchConversationItems__ofConversationWithId_conversationIdcallback_callback(`conversationId`, `callback`), performs: perform)
        }
        public static func addConversationItem(_ conversationItem: Parameter<LocalConversationItem>, toConversationWithId conversationId: Parameter<UUID>, perform: @escaping (LocalConversationItem, UUID) -> Void) -> Perform {
            return Perform(method: .m_addConversationItem__conversationItemtoConversationWithId_conversationId(`conversationItem`, `conversationId`), performs: perform)
        }
        public static func updateConversationItem(_ conversationItem: Parameter<LocalConversationItem>, inConversationWithId conversationId: Parameter<UUID>, perform: @escaping (LocalConversationItem, UUID) -> Void) -> Perform {
            return Perform(method: .m_updateConversationItem__conversationIteminConversationWithId_conversationId(`conversationItem`, `conversationId`), performs: perform)
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

    open func send(localMessageClientId: UUID, remoteMessageInput: GQL.SendMessageContentInput, conversationId: UUID, replyToMessageId: UUID?, handler: ResultHandler<Void, GQLError>) -> Cancellable {
        addInvocation(.m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(Parameter<UUID>.value(`localMessageClientId`), Parameter<GQL.SendMessageContentInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`), Parameter<UUID?>.value(`replyToMessageId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`)))
		let perform = methodPerformValue(.m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(Parameter<UUID>.value(`localMessageClientId`), Parameter<GQL.SendMessageContentInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`), Parameter<UUID?>.value(`replyToMessageId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))) as? (UUID, GQL.SendMessageContentInput, UUID, UUID?, ResultHandler<Void, GQLError>) -> Void
		perform?(`localMessageClientId`, `remoteMessageInput`, `conversationId`, `replyToMessageId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(Parameter<UUID>.value(`localMessageClientId`), Parameter<GQL.SendMessageContentInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`), Parameter<UUID?>.value(`replyToMessageId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for send(localMessageClientId: UUID, remoteMessageInput: GQL.SendMessageContentInput, conversationId: UUID, replyToMessageId: UUID?, handler: ResultHandler<Void, GQLError>). Use given")
			Failure("Stub return value not specified for send(localMessageClientId: UUID, remoteMessageInput: GQL.SendMessageContentInput, conversationId: UUID, replyToMessageId: UUID?, handler: ResultHandler<Void, GQLError>). Use given")
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

    open func setIsTyping(_ isTyping: Bool, conversationId: UUID, handler: ResultHandler<Void, GQLError>) -> Cancellable {
        addInvocation(.m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`)))
		let perform = methodPerformValue(.m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))) as? (Bool, UUID, ResultHandler<Void, GQLError>) -> Void
		perform?(`isTyping`, `conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for setIsTyping(_ isTyping: Bool, conversationId: UUID, handler: ResultHandler<Void, GQLError>). Use given")
			Failure("Stub return value not specified for setIsTyping(_ isTyping: Bool, conversationId: UUID, handler: ResultHandler<Void, GQLError>). Use given")
		}
		return __value
    }

    open func markConversationAsSeen(conversationId: UUID, handler: ResultHandler<Void, GQLError>) -> Cancellable {
        addInvocation(.m_markConversationAsSeen__conversationId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`)))
		let perform = methodPerformValue(.m_markConversationAsSeen__conversationId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))) as? (UUID, ResultHandler<Void, GQLError>) -> Void
		perform?(`conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_markConversationAsSeen__conversationId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<ResultHandler<Void, GQLError>>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for markConversationAsSeen(conversationId: UUID, handler: ResultHandler<Void, GQLError>). Use given")
			Failure("Stub return value not specified for markConversationAsSeen(conversationId: UUID, handler: ResultHandler<Void, GQLError>). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>, Parameter<ResultHandler<RemoteConversationItems, GQLError>>)
        case m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>, Parameter<ResultHandler<RemoteConversationEvent, GQLError>>)
        case m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(Parameter<UUID>, Parameter<GQL.SendMessageContentInput>, Parameter<UUID>, Parameter<UUID?>, Parameter<ResultHandler<Void, GQLError>>)
        case m_delete__messageId_messageIdhandler_handler(Parameter<UUID>, Parameter<ResultHandler<Void, GQLError>>)
        case m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(Parameter<Bool>, Parameter<UUID>, Parameter<ResultHandler<Void, GQLError>>)
        case m_markConversationAsSeen__conversationId_conversationIdhandler_handler(Parameter<UUID>, Parameter<ResultHandler<Void, GQLError>>)

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

            case (.m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(let lhsLocalmessageclientid, let lhsRemotemessageinput, let lhsConversationid, let lhsReplytomessageid, let lhsHandler), .m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(let rhsLocalmessageclientid, let rhsRemotemessageinput, let rhsConversationid, let rhsReplytomessageid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsLocalmessageclientid, rhs: rhsLocalmessageclientid, with: matcher), lhsLocalmessageclientid, rhsLocalmessageclientid, "localMessageClientId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRemotemessageinput, rhs: rhsRemotemessageinput, with: matcher), lhsRemotemessageinput, rhsRemotemessageinput, "remoteMessageInput"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsReplytomessageid, rhs: rhsReplytomessageid, with: matcher), lhsReplytomessageid, rhsReplytomessageid, "replyToMessageId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_delete__messageId_messageIdhandler_handler(let lhsMessageid, let lhsHandler), .m_delete__messageId_messageIdhandler_handler(let rhsMessageid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessageid, rhs: rhsMessageid, with: matcher), lhsMessageid, rhsMessageid, "messageId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(let lhsIstyping, let lhsConversationid, let lhsHandler), .m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(let rhsIstyping, let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIstyping, rhs: rhsIstyping, with: matcher), lhsIstyping, rhsIstyping, "_ isTyping"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_markConversationAsSeen__conversationId_conversationIdhandler_handler(let lhsConversationid, let lhsHandler), .m_markConversationAsSeen__conversationId_conversationIdhandler_handler(let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(p0, p1, p2, p3, p4): return p0.intValue + p1.intValue + p2.intValue + p3.intValue + p4.intValue
            case let .m_delete__messageId_messageIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_markConversationAsSeen__conversationId_conversationIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler: return ".watchConversationItems(ofConversationWithId:handler:)"
            case .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler: return ".subscribeToConversationItemsEvents(ofConversationWithId:handler:)"
            case .m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler: return ".send(localMessageClientId:remoteMessageInput:conversationId:replyToMessageId:handler:)"
            case .m_delete__messageId_messageIdhandler_handler: return ".delete(messageId:handler:)"
            case .m_setIsTyping__isTypingconversationId_conversationIdhandler_handler: return ".setIsTyping(_:conversationId:handler:)"
            case .m_markConversationAsSeen__conversationId_conversationIdhandler_handler: return ".markConversationAsSeen(conversationId:handler:)"
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
        public static func send(localMessageClientId: Parameter<UUID>, remoteMessageInput: Parameter<GQL.SendMessageContentInput>, conversationId: Parameter<UUID>, replyToMessageId: Parameter<UUID?>, handler: Parameter<ResultHandler<Void, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(`localMessageClientId`, `remoteMessageInput`, `conversationId`, `replyToMessageId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func delete(messageId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_delete__messageId_messageIdhandler_handler(`messageId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(`isTyping`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func markConversationAsSeen(conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_markConversationAsSeen__conversationId_conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
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
        public static func send(localMessageClientId: Parameter<UUID>, remoteMessageInput: Parameter<GQL.SendMessageContentInput>, conversationId: Parameter<UUID>, replyToMessageId: Parameter<UUID?>, handler: Parameter<ResultHandler<Void, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(`localMessageClientId`, `remoteMessageInput`, `conversationId`, `replyToMessageId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
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
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(`isTyping`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func markConversationAsSeen(conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_markConversationAsSeen__conversationId_conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationItems, GQLError>>) -> Verify { return Verify(method: .m_watchConversationItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`))}
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<RemoteConversationEvent, GQLError>>) -> Verify { return Verify(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`))}
        public static func send(localMessageClientId: Parameter<UUID>, remoteMessageInput: Parameter<GQL.SendMessageContentInput>, conversationId: Parameter<UUID>, replyToMessageId: Parameter<UUID?>, handler: Parameter<ResultHandler<Void, GQLError>>) -> Verify { return Verify(method: .m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(`localMessageClientId`, `remoteMessageInput`, `conversationId`, `replyToMessageId`, `handler`))}
        public static func delete(messageId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>) -> Verify { return Verify(method: .m_delete__messageId_messageIdhandler_handler(`messageId`, `handler`))}
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>) -> Verify { return Verify(method: .m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(`isTyping`, `conversationId`, `handler`))}
        public static func markConversationAsSeen(conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>) -> Verify { return Verify(method: .m_markConversationAsSeen__conversationId_conversationIdhandler_handler(`conversationId`, `handler`))}
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
        public static func send(localMessageClientId: Parameter<UUID>, remoteMessageInput: Parameter<GQL.SendMessageContentInput>, conversationId: Parameter<UUID>, replyToMessageId: Parameter<UUID?>, handler: Parameter<ResultHandler<Void, GQLError>>, perform: @escaping (UUID, GQL.SendMessageContentInput, UUID, UUID?, ResultHandler<Void, GQLError>) -> Void) -> Perform {
            return Perform(method: .m_send__localMessageClientId_localMessageClientIdremoteMessageInput_remoteMessageInputconversationId_conversationIdreplyToMessageId_replyToMessageIdhandler_handler(`localMessageClientId`, `remoteMessageInput`, `conversationId`, `replyToMessageId`, `handler`), performs: perform)
        }
        public static func delete(messageId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, perform: @escaping (UUID, ResultHandler<Void, GQLError>) -> Void) -> Perform {
            return Perform(method: .m_delete__messageId_messageIdhandler_handler(`messageId`, `handler`), performs: perform)
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, perform: @escaping (Bool, UUID, ResultHandler<Void, GQLError>) -> Void) -> Perform {
            return Perform(method: .m_setIsTyping__isTypingconversationId_conversationIdhandler_handler(`isTyping`, `conversationId`, `handler`), performs: perform)
        }
        public static func markConversationAsSeen(conversationId: Parameter<UUID>, handler: Parameter<ResultHandler<Void, GQLError>>, perform: @escaping (UUID, ResultHandler<Void, GQLError>) -> Void) -> Perform {
            return Perform(method: .m_markConversationAsSeen__conversationId_conversationIdhandler_handler(`conversationId`, `handler`), performs: perform)
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

