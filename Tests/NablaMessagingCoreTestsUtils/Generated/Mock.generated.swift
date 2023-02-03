// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import NablaCore
import Combine
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

    open func watchConversationItems(ofConversationWithId conversationId: UUID) -> AnyPublisher<[LocalConversationItem], Never> {
        addInvocation(.m_watchConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_watchConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		var __value: AnyPublisher<[LocalConversationItem], Never>
		do {
		    __value = try methodReturnValue(.m_watchConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversationItems(ofConversationWithId conversationId: UUID). Use given")
			Failure("Stub return value not specified for watchConversationItems(ofConversationWithId conversationId: UUID). Use given")
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
        case m_watchConversationItems__ofConversationWithId_conversationId(Parameter<UUID>)
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

            case (.m_watchConversationItems__ofConversationWithId_conversationId(let lhsConversationid), .m_watchConversationItems__ofConversationWithId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
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
            case let .m_watchConversationItems__ofConversationWithId_conversationId(p0): return p0.intValue
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
            case .m_watchConversationItems__ofConversationWithId_conversationId: return ".watchConversationItems(ofConversationWithId:)"
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
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, willReturn: AnyPublisher<[LocalConversationItem], Never>...) -> MethodStub {
            return Given(method: .m_watchConversationItems__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
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
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, willProduce: (Stubber<AnyPublisher<[LocalConversationItem], Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<[LocalConversationItem], Never>] = []
			let given: Given = { return Given(method: .m_watchConversationItems__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<[LocalConversationItem], Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getConversationItems(ofConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_getConversationItems__ofConversationWithId_conversationId(`conversationId`))}
        public static func getConversationItem(withClientId clientId: Parameter<UUID>) -> Verify { return Verify(method: .m_getConversationItem__withClientId_clientId(`clientId`))}
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_watchConversationItems__ofConversationWithId_conversationId(`conversationId`))}
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
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_watchConversationItems__ofConversationWithId_conversationId(`conversationId`), performs: perform)
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





    open func watchConversationItems(ofConversationWithId conversationId: UUID) -> AnyPublisher<PaginatedList<RemoteConversationItem>, GQLError> {
        addInvocation(.m_watchConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_watchConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		var __value: AnyPublisher<PaginatedList<RemoteConversationItem>, GQLError>
		do {
		    __value = try methodReturnValue(.m_watchConversationItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversationItems(ofConversationWithId conversationId: UUID). Use given")
			Failure("Stub return value not specified for watchConversationItems(ofConversationWithId conversationId: UUID). Use given")
		}
		return __value
    }

    open func subscribeToConversationItemsEvents(ofConversationWithId conversationId: UUID) -> AnyPublisher<RemoteConversationEvent, Never> {
        addInvocation(.m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		var __value: AnyPublisher<RemoteConversationEvent, Never>
		do {
		    __value = try methodReturnValue(.m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for subscribeToConversationItemsEvents(ofConversationWithId conversationId: UUID). Use given")
			Failure("Stub return value not specified for subscribeToConversationItemsEvents(ofConversationWithId conversationId: UUID). Use given")
		}
		return __value
    }

    open func send(remoteMessageInput: GQL.SendMessageInput, conversationId: UUID) throws {
        addInvocation(.m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(Parameter<GQL.SendMessageInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(Parameter<GQL.SendMessageInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`))) as? (GQL.SendMessageInput, UUID) -> Void
		perform?(`remoteMessageInput`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(Parameter<GQL.SendMessageInput>.value(`remoteMessageInput`), Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func delete(messageId: UUID) throws {
        addInvocation(.m_delete__messageId_messageId(Parameter<UUID>.value(`messageId`)))
		let perform = methodPerformValue(.m_delete__messageId_messageId(Parameter<UUID>.value(`messageId`))) as? (UUID) -> Void
		perform?(`messageId`)
		do {
		    _ = try methodReturnValue(.m_delete__messageId_messageId(Parameter<UUID>.value(`messageId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }


    fileprivate enum MethodType {
        case m_watchConversationItems__ofConversationWithId_conversationId(Parameter<UUID>)
        case m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(Parameter<UUID>)
        case m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(Parameter<GQL.SendMessageInput>, Parameter<UUID>)
        case m_delete__messageId_messageId(Parameter<UUID>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_watchConversationItems__ofConversationWithId_conversationId(let lhsConversationid), .m_watchConversationItems__ofConversationWithId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(let lhsConversationid), .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(let lhsRemotemessageinput, let lhsConversationid), .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(let rhsRemotemessageinput, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsRemotemessageinput, rhs: rhsRemotemessageinput, with: matcher), lhsRemotemessageinput, rhsRemotemessageinput, "remoteMessageInput"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_delete__messageId_messageId(let lhsMessageid), .m_delete__messageId_messageId(let rhsMessageid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessageid, rhs: rhsMessageid, with: matcher), lhsMessageid, rhsMessageid, "messageId"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_watchConversationItems__ofConversationWithId_conversationId(p0): return p0.intValue
            case let .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(p0): return p0.intValue
            case let .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_delete__messageId_messageId(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_watchConversationItems__ofConversationWithId_conversationId: return ".watchConversationItems(ofConversationWithId:)"
            case .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId: return ".subscribeToConversationItemsEvents(ofConversationWithId:)"
            case .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId: return ".send(remoteMessageInput:conversationId:)"
            case .m_delete__messageId_messageId: return ".delete(messageId:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, willReturn: AnyPublisher<PaginatedList<RemoteConversationItem>, GQLError>...) -> MethodStub {
            return Given(method: .m_watchConversationItems__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>, willReturn: AnyPublisher<RemoteConversationEvent, Never>...) -> MethodStub {
            return Given(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, willProduce: (Stubber<AnyPublisher<PaginatedList<RemoteConversationItem>, GQLError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<PaginatedList<RemoteConversationItem>, GQLError>] = []
			let given: Given = { return Given(method: .m_watchConversationItems__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<PaginatedList<RemoteConversationItem>, GQLError>).self)
			willProduce(stubber)
			return given
        }
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>, willProduce: (Stubber<AnyPublisher<RemoteConversationEvent, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<RemoteConversationEvent, Never>] = []
			let given: Given = { return Given(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<RemoteConversationEvent, Never>).self)
			willProduce(stubber)
			return given
        }
        public static func send(remoteMessageInput: Parameter<GQL.SendMessageInput>, conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(`remoteMessageInput`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func send(remoteMessageInput: Parameter<GQL.SendMessageInput>, conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(`remoteMessageInput`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func delete(messageId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_delete__messageId_messageId(`messageId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func delete(messageId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_delete__messageId_messageId(`messageId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_watchConversationItems__ofConversationWithId_conversationId(`conversationId`))}
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(`conversationId`))}
        public static func send(remoteMessageInput: Parameter<GQL.SendMessageInput>, conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(`remoteMessageInput`, `conversationId`))}
        public static func delete(messageId: Parameter<UUID>) -> Verify { return Verify(method: .m_delete__messageId_messageId(`messageId`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func watchConversationItems(ofConversationWithId conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_watchConversationItems__ofConversationWithId_conversationId(`conversationId`), performs: perform)
        }
        public static func subscribeToConversationItemsEvents(ofConversationWithId conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_subscribeToConversationItemsEvents__ofConversationWithId_conversationId(`conversationId`), performs: perform)
        }
        public static func send(remoteMessageInput: Parameter<GQL.SendMessageInput>, conversationId: Parameter<UUID>, perform: @escaping (GQL.SendMessageInput, UUID) -> Void) -> Perform {
            return Perform(method: .m_send__remoteMessageInput_remoteMessageInputconversationId_conversationId(`remoteMessageInput`, `conversationId`), performs: perform)
        }
        public static func delete(messageId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_delete__messageId_messageId(`messageId`), performs: perform)
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

// MARK: - ConversationItemRepository

open class ConversationItemRepositoryMock: ConversationItemRepository, Mock {
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





    open func watchConversationItems(ofConversationWithId: TransientUUID) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError> {
        addInvocation(.m_watchConversationItems__ofConversationWithId_ofConversationWithId(Parameter<TransientUUID>.value(`ofConversationWithId`)))
		let perform = methodPerformValue(.m_watchConversationItems__ofConversationWithId_ofConversationWithId(Parameter<TransientUUID>.value(`ofConversationWithId`))) as? (TransientUUID) -> Void
		perform?(`ofConversationWithId`)
		var __value: AnyPublisher<PaginatedList<ConversationItem>, NablaError>
		do {
		    __value = try methodReturnValue(.m_watchConversationItems__ofConversationWithId_ofConversationWithId(Parameter<TransientUUID>.value(`ofConversationWithId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversationItems(ofConversationWithId: TransientUUID). Use given")
			Failure("Stub return value not specified for watchConversationItems(ofConversationWithId: TransientUUID). Use given")
		}
		return __value
    }

    open func sendMessage(_ message: MessageInput, replyToMessageId: UUID?, inConversationWithId: TransientUUID) throws {
        addInvocation(.m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyToMessageId`), Parameter<TransientUUID>.value(`inConversationWithId`)))
		let perform = methodPerformValue(.m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyToMessageId`), Parameter<TransientUUID>.value(`inConversationWithId`))) as? (MessageInput, UUID?, TransientUUID) -> Void
		perform?(`message`, `replyToMessageId`, `inConversationWithId`)
		do {
		    _ = try methodReturnValue(.m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyToMessageId`), Parameter<TransientUUID>.value(`inConversationWithId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func retrySending(itemWithId itemId: UUID, inConversationWithId: TransientUUID) throws {
        addInvocation(.m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(Parameter<UUID>.value(`itemId`), Parameter<TransientUUID>.value(`inConversationWithId`)))
		let perform = methodPerformValue(.m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(Parameter<UUID>.value(`itemId`), Parameter<TransientUUID>.value(`inConversationWithId`))) as? (UUID, TransientUUID) -> Void
		perform?(`itemId`, `inConversationWithId`)
		do {
		    _ = try methodReturnValue(.m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(Parameter<UUID>.value(`itemId`), Parameter<TransientUUID>.value(`inConversationWithId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func deleteMessage(withId messageId: UUID, conversationId: TransientUUID) throws {
        addInvocation(.m_deleteMessage__withId_messageIdconversationId_conversationId(Parameter<UUID>.value(`messageId`), Parameter<TransientUUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_deleteMessage__withId_messageIdconversationId_conversationId(Parameter<UUID>.value(`messageId`), Parameter<TransientUUID>.value(`conversationId`))) as? (UUID, TransientUUID) -> Void
		perform?(`messageId`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_deleteMessage__withId_messageIdconversationId_conversationId(Parameter<UUID>.value(`messageId`), Parameter<TransientUUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }


    fileprivate enum MethodType {
        case m_watchConversationItems__ofConversationWithId_ofConversationWithId(Parameter<TransientUUID>)
        case m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(Parameter<MessageInput>, Parameter<UUID?>, Parameter<TransientUUID>)
        case m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(Parameter<UUID>, Parameter<TransientUUID>)
        case m_deleteMessage__withId_messageIdconversationId_conversationId(Parameter<UUID>, Parameter<TransientUUID>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_watchConversationItems__ofConversationWithId_ofConversationWithId(let lhsOfconversationwithid), .m_watchConversationItems__ofConversationWithId_ofConversationWithId(let rhsOfconversationwithid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOfconversationwithid, rhs: rhsOfconversationwithid, with: matcher), lhsOfconversationwithid, rhsOfconversationwithid, "ofConversationWithId"))
				return Matcher.ComparisonResult(results)

            case (.m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(let lhsMessage, let lhsReplytomessageid, let lhsInconversationwithid), .m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(let rhsMessage, let rhsReplytomessageid, let rhsInconversationwithid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "_ message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsReplytomessageid, rhs: rhsReplytomessageid, with: matcher), lhsReplytomessageid, rhsReplytomessageid, "replyToMessageId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsInconversationwithid, rhs: rhsInconversationwithid, with: matcher), lhsInconversationwithid, rhsInconversationwithid, "inConversationWithId"))
				return Matcher.ComparisonResult(results)

            case (.m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(let lhsItemid, let lhsInconversationwithid), .m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(let rhsItemid, let rhsInconversationwithid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsItemid, rhs: rhsItemid, with: matcher), lhsItemid, rhsItemid, "itemWithId itemId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsInconversationwithid, rhs: rhsInconversationwithid, with: matcher), lhsInconversationwithid, rhsInconversationwithid, "inConversationWithId"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteMessage__withId_messageIdconversationId_conversationId(let lhsMessageid, let lhsConversationid), .m_deleteMessage__withId_messageIdconversationId_conversationId(let rhsMessageid, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessageid, rhs: rhsMessageid, with: matcher), lhsMessageid, rhsMessageid, "withId messageId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_watchConversationItems__ofConversationWithId_ofConversationWithId(p0): return p0.intValue
            case let .m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(p0, p1): return p0.intValue + p1.intValue
            case let .m_deleteMessage__withId_messageIdconversationId_conversationId(p0, p1): return p0.intValue + p1.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_watchConversationItems__ofConversationWithId_ofConversationWithId: return ".watchConversationItems(ofConversationWithId:)"
            case .m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId: return ".sendMessage(_:replyToMessageId:inConversationWithId:)"
            case .m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId: return ".retrySending(itemWithId:inConversationWithId:)"
            case .m_deleteMessage__withId_messageIdconversationId_conversationId: return ".deleteMessage(withId:conversationId:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func watchConversationItems(ofConversationWithId: Parameter<TransientUUID>, willReturn: AnyPublisher<PaginatedList<ConversationItem>, NablaError>...) -> MethodStub {
            return Given(method: .m_watchConversationItems__ofConversationWithId_ofConversationWithId(`ofConversationWithId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversationItems(ofConversationWithId: Parameter<TransientUUID>, willProduce: (Stubber<AnyPublisher<PaginatedList<ConversationItem>, NablaError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<PaginatedList<ConversationItem>, NablaError>] = []
			let given: Given = { return Given(method: .m_watchConversationItems__ofConversationWithId_ofConversationWithId(`ofConversationWithId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<PaginatedList<ConversationItem>, NablaError>).self)
			willProduce(stubber)
			return given
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyToMessageId: Parameter<UUID?>, inConversationWithId: Parameter<TransientUUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(`message`, `replyToMessageId`, `inConversationWithId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyToMessageId: Parameter<UUID?>, inConversationWithId: Parameter<TransientUUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(`message`, `replyToMessageId`, `inConversationWithId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId: Parameter<TransientUUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(`itemId`, `inConversationWithId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId: Parameter<TransientUUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(`itemId`, `inConversationWithId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<TransientUUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_deleteMessage__withId_messageIdconversationId_conversationId(`messageId`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<TransientUUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_deleteMessage__withId_messageIdconversationId_conversationId(`messageId`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func watchConversationItems(ofConversationWithId: Parameter<TransientUUID>) -> Verify { return Verify(method: .m_watchConversationItems__ofConversationWithId_ofConversationWithId(`ofConversationWithId`))}
        public static func sendMessage(_ message: Parameter<MessageInput>, replyToMessageId: Parameter<UUID?>, inConversationWithId: Parameter<TransientUUID>) -> Verify { return Verify(method: .m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(`message`, `replyToMessageId`, `inConversationWithId`))}
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId: Parameter<TransientUUID>) -> Verify { return Verify(method: .m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(`itemId`, `inConversationWithId`))}
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<TransientUUID>) -> Verify { return Verify(method: .m_deleteMessage__withId_messageIdconversationId_conversationId(`messageId`, `conversationId`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func watchConversationItems(ofConversationWithId: Parameter<TransientUUID>, perform: @escaping (TransientUUID) -> Void) -> Perform {
            return Perform(method: .m_watchConversationItems__ofConversationWithId_ofConversationWithId(`ofConversationWithId`), performs: perform)
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyToMessageId: Parameter<UUID?>, inConversationWithId: Parameter<TransientUUID>, perform: @escaping (MessageInput, UUID?, TransientUUID) -> Void) -> Perform {
            return Perform(method: .m_sendMessage__messagereplyToMessageId_replyToMessageIdinConversationWithId_inConversationWithId(`message`, `replyToMessageId`, `inConversationWithId`), performs: perform)
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId: Parameter<TransientUUID>, perform: @escaping (UUID, TransientUUID) -> Void) -> Perform {
            return Perform(method: .m_retrySending__itemWithId_itemIdinConversationWithId_inConversationWithId(`itemId`, `inConversationWithId`), performs: perform)
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<TransientUUID>, perform: @escaping (UUID, TransientUUID) -> Void) -> Perform {
            return Perform(method: .m_deleteMessage__withId_messageIdconversationId_conversationId(`messageId`, `conversationId`), performs: perform)
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

// MARK: - ConversationLocalDataSource

open class ConversationLocalDataSourceMock: ConversationLocalDataSource, Mock {
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





    open func getConversation(withId id: UUID) -> LocalConversation? {
        addInvocation(.m_getConversation__withId_id(Parameter<UUID>.value(`id`)))
		let perform = methodPerformValue(.m_getConversation__withId_id(Parameter<UUID>.value(`id`))) as? (UUID) -> Void
		perform?(`id`)
		var __value: LocalConversation? = nil
		do {
		    __value = try methodReturnValue(.m_getConversation__withId_id(Parameter<UUID>.value(`id`))).casted()
		} catch {
			// do nothing
		}
		return __value
    }

    open func startConversation(title: String?, providerIds: [UUID]?) -> LocalConversation {
        addInvocation(.m_startConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`)))
		let perform = methodPerformValue(.m_startConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))) as? (String?, [UUID]?) -> Void
		perform?(`title`, `providerIds`)
		var __value: LocalConversation
		do {
		    __value = try methodReturnValue(.m_startConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for startConversation(title: String?, providerIds: [UUID]?). Use given")
			Failure("Stub return value not specified for startConversation(title: String?, providerIds: [UUID]?). Use given")
		}
		return __value
    }

    open func updateConversation(_ conversation: LocalConversation) {
        addInvocation(.m_updateConversation__conversation(Parameter<LocalConversation>.value(`conversation`)))
		let perform = methodPerformValue(.m_updateConversation__conversation(Parameter<LocalConversation>.value(`conversation`))) as? (LocalConversation) -> Void
		perform?(`conversation`)
    }

    open func watchConversation(_ conversationId: UUID) -> AnyPublisher<LocalConversation?, Never> {
        addInvocation(.m_watchConversation__conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_watchConversation__conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		var __value: AnyPublisher<LocalConversation?, Never>
		do {
		    __value = try methodReturnValue(.m_watchConversation__conversationId(Parameter<UUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversation(_ conversationId: UUID). Use given")
			Failure("Stub return value not specified for watchConversation(_ conversationId: UUID). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_getConversation__withId_id(Parameter<UUID>)
        case m_startConversation__title_titleproviderIds_providerIds(Parameter<String?>, Parameter<[UUID]?>)
        case m_updateConversation__conversation(Parameter<LocalConversation>)
        case m_watchConversation__conversationId(Parameter<UUID>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getConversation__withId_id(let lhsId), .m_getConversation__withId_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "withId id"))
				return Matcher.ComparisonResult(results)

            case (.m_startConversation__title_titleproviderIds_providerIds(let lhsTitle, let lhsProviderids), .m_startConversation__title_titleproviderIds_providerIds(let rhsTitle, let rhsProviderids)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "title"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsProviderids, rhs: rhsProviderids, with: matcher), lhsProviderids, rhsProviderids, "providerIds"))
				return Matcher.ComparisonResult(results)

            case (.m_updateConversation__conversation(let lhsConversation), .m_updateConversation__conversation(let rhsConversation)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversation, rhs: rhsConversation, with: matcher), lhsConversation, rhsConversation, "_ conversation"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversation__conversationId(let lhsConversationid), .m_watchConversation__conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "_ conversationId"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getConversation__withId_id(p0): return p0.intValue
            case let .m_startConversation__title_titleproviderIds_providerIds(p0, p1): return p0.intValue + p1.intValue
            case let .m_updateConversation__conversation(p0): return p0.intValue
            case let .m_watchConversation__conversationId(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getConversation__withId_id: return ".getConversation(withId:)"
            case .m_startConversation__title_titleproviderIds_providerIds: return ".startConversation(title:providerIds:)"
            case .m_updateConversation__conversation: return ".updateConversation(_:)"
            case .m_watchConversation__conversationId: return ".watchConversation(_:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getConversation(withId id: Parameter<UUID>, willReturn: LocalConversation?...) -> MethodStub {
            return Given(method: .m_getConversation__withId_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func startConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willReturn: LocalConversation...) -> MethodStub {
            return Given(method: .m_startConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, willReturn: AnyPublisher<LocalConversation?, Never>...) -> MethodStub {
            return Given(method: .m_watchConversation__conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getConversation(withId id: Parameter<UUID>, willProduce: (Stubber<LocalConversation?>) -> Void) -> MethodStub {
            let willReturn: [LocalConversation?] = []
			let given: Given = { return Given(method: .m_getConversation__withId_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (LocalConversation?).self)
			willProduce(stubber)
			return given
        }
        public static func startConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willProduce: (Stubber<LocalConversation>) -> Void) -> MethodStub {
            let willReturn: [LocalConversation] = []
			let given: Given = { return Given(method: .m_startConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (LocalConversation).self)
			willProduce(stubber)
			return given
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, willProduce: (Stubber<AnyPublisher<LocalConversation?, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<LocalConversation?, Never>] = []
			let given: Given = { return Given(method: .m_watchConversation__conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<LocalConversation?, Never>).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getConversation(withId id: Parameter<UUID>) -> Verify { return Verify(method: .m_getConversation__withId_id(`id`))}
        public static func startConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>) -> Verify { return Verify(method: .m_startConversation__title_titleproviderIds_providerIds(`title`, `providerIds`))}
        public static func updateConversation(_ conversation: Parameter<LocalConversation>) -> Verify { return Verify(method: .m_updateConversation__conversation(`conversation`))}
        public static func watchConversation(_ conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_watchConversation__conversationId(`conversationId`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getConversation(withId id: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_getConversation__withId_id(`id`), performs: perform)
        }
        public static func startConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, perform: @escaping (String?, [UUID]?) -> Void) -> Perform {
            return Perform(method: .m_startConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), performs: perform)
        }
        public static func updateConversation(_ conversation: Parameter<LocalConversation>, perform: @escaping (LocalConversation) -> Void) -> Perform {
            return Perform(method: .m_updateConversation__conversation(`conversation`), performs: perform)
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_watchConversation__conversationId(`conversationId`), performs: perform)
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

// MARK: - ConversationRemoteDataSource

open class ConversationRemoteDataSourceMock: ConversationRemoteDataSource, Mock {
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





    open func createConversation(message: GQL.SendMessageInput?, title: String?, providerIds: [UUID]?) throws -> RemoteConversation {
        addInvocation(.m_createConversation__message_messagetitle_titleproviderIds_providerIds(Parameter<GQL.SendMessageInput?>.value(`message`), Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`)))
		let perform = methodPerformValue(.m_createConversation__message_messagetitle_titleproviderIds_providerIds(Parameter<GQL.SendMessageInput?>.value(`message`), Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))) as? (GQL.SendMessageInput?, String?, [UUID]?) -> Void
		perform?(`message`, `title`, `providerIds`)
		var __value: RemoteConversation
		do {
		    __value = try methodReturnValue(.m_createConversation__message_messagetitle_titleproviderIds_providerIds(Parameter<GQL.SendMessageInput?>.value(`message`), Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for createConversation(message: GQL.SendMessageInput?, title: String?, providerIds: [UUID]?). Use given")
			Failure("Stub return value not specified for createConversation(message: GQL.SendMessageInput?, title: String?, providerIds: [UUID]?). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func setIsTyping(_ isTyping: Bool, conversationId: UUID) throws {
        addInvocation(.m_setIsTyping__isTypingconversationId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_setIsTyping__isTypingconversationId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`))) as? (Bool, UUID) -> Void
		perform?(`isTyping`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_setIsTyping__isTypingconversationId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func markConversationAsSeen(conversationId: UUID) throws {
        addInvocation(.m_markConversationAsSeen__conversationId_conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_markConversationAsSeen__conversationId_conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		do {
		    _ = try methodReturnValue(.m_markConversationAsSeen__conversationId_conversationId(Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func watchConversation(_ conversationId: UUID) -> AnyPublisher<RemoteConversation, GQLError> {
        addInvocation(.m_watchConversation__conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_watchConversation__conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		var __value: AnyPublisher<RemoteConversation, GQLError>
		do {
		    __value = try methodReturnValue(.m_watchConversation__conversationId(Parameter<UUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversation(_ conversationId: UUID). Use given")
			Failure("Stub return value not specified for watchConversation(_ conversationId: UUID). Use given")
		}
		return __value
    }

    open func watchConversations() -> AnyPublisher<PaginatedList<RemoteConversation>, GQLError> {
        addInvocation(.m_watchConversations)
		let perform = methodPerformValue(.m_watchConversations) as? () -> Void
		perform?()
		var __value: AnyPublisher<PaginatedList<RemoteConversation>, GQLError>
		do {
		    __value = try methodReturnValue(.m_watchConversations).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversations(). Use given")
			Failure("Stub return value not specified for watchConversations(). Use given")
		}
		return __value
    }

    open func subscribeToConversationsEvents() -> AnyPublisher<RemoteConversationsEvent, Never> {
        addInvocation(.m_subscribeToConversationsEvents)
		let perform = methodPerformValue(.m_subscribeToConversationsEvents) as? () -> Void
		perform?()
		var __value: AnyPublisher<RemoteConversationsEvent, Never>
		do {
		    __value = try methodReturnValue(.m_subscribeToConversationsEvents).casted()
		} catch {
			onFatalFailure("Stub return value not specified for subscribeToConversationsEvents(). Use given")
			Failure("Stub return value not specified for subscribeToConversationsEvents(). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_createConversation__message_messagetitle_titleproviderIds_providerIds(Parameter<GQL.SendMessageInput?>, Parameter<String?>, Parameter<[UUID]?>)
        case m_setIsTyping__isTypingconversationId_conversationId(Parameter<Bool>, Parameter<UUID>)
        case m_markConversationAsSeen__conversationId_conversationId(Parameter<UUID>)
        case m_watchConversation__conversationId(Parameter<UUID>)
        case m_watchConversations
        case m_subscribeToConversationsEvents

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createConversation__message_messagetitle_titleproviderIds_providerIds(let lhsMessage, let lhsTitle, let lhsProviderids), .m_createConversation__message_messagetitle_titleproviderIds_providerIds(let rhsMessage, let rhsTitle, let rhsProviderids)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "title"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsProviderids, rhs: rhsProviderids, with: matcher), lhsProviderids, rhsProviderids, "providerIds"))
				return Matcher.ComparisonResult(results)

            case (.m_setIsTyping__isTypingconversationId_conversationId(let lhsIstyping, let lhsConversationid), .m_setIsTyping__isTypingconversationId_conversationId(let rhsIstyping, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIstyping, rhs: rhsIstyping, with: matcher), lhsIstyping, rhsIstyping, "_ isTyping"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_markConversationAsSeen__conversationId_conversationId(let lhsConversationid), .m_markConversationAsSeen__conversationId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversation__conversationId(let lhsConversationid), .m_watchConversation__conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "_ conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversations, .m_watchConversations): return .match

            case (.m_subscribeToConversationsEvents, .m_subscribeToConversationsEvents): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_createConversation__message_messagetitle_titleproviderIds_providerIds(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_setIsTyping__isTypingconversationId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_markConversationAsSeen__conversationId_conversationId(p0): return p0.intValue
            case let .m_watchConversation__conversationId(p0): return p0.intValue
            case .m_watchConversations: return 0
            case .m_subscribeToConversationsEvents: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createConversation__message_messagetitle_titleproviderIds_providerIds: return ".createConversation(message:title:providerIds:)"
            case .m_setIsTyping__isTypingconversationId_conversationId: return ".setIsTyping(_:conversationId:)"
            case .m_markConversationAsSeen__conversationId_conversationId: return ".markConversationAsSeen(conversationId:)"
            case .m_watchConversation__conversationId: return ".watchConversation(_:)"
            case .m_watchConversations: return ".watchConversations()"
            case .m_subscribeToConversationsEvents: return ".subscribeToConversationsEvents()"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func createConversation(message: Parameter<GQL.SendMessageInput?>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willReturn: RemoteConversation...) -> MethodStub {
            return Given(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, willReturn: AnyPublisher<RemoteConversation, GQLError>...) -> MethodStub {
            return Given(method: .m_watchConversation__conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversations(willReturn: AnyPublisher<PaginatedList<RemoteConversation>, GQLError>...) -> MethodStub {
            return Given(method: .m_watchConversations, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func subscribeToConversationsEvents(willReturn: AnyPublisher<RemoteConversationsEvent, Never>...) -> MethodStub {
            return Given(method: .m_subscribeToConversationsEvents, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, willProduce: (Stubber<AnyPublisher<RemoteConversation, GQLError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<RemoteConversation, GQLError>] = []
			let given: Given = { return Given(method: .m_watchConversation__conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<RemoteConversation, GQLError>).self)
			willProduce(stubber)
			return given
        }
        public static func watchConversations(willProduce: (Stubber<AnyPublisher<PaginatedList<RemoteConversation>, GQLError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<PaginatedList<RemoteConversation>, GQLError>] = []
			let given: Given = { return Given(method: .m_watchConversations, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<PaginatedList<RemoteConversation>, GQLError>).self)
			willProduce(stubber)
			return given
        }
        public static func subscribeToConversationsEvents(willProduce: (Stubber<AnyPublisher<RemoteConversationsEvent, Never>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<RemoteConversationsEvent, Never>] = []
			let given: Given = { return Given(method: .m_subscribeToConversationsEvents, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<RemoteConversationsEvent, Never>).self)
			willProduce(stubber)
			return given
        }
        public static func createConversation(message: Parameter<GQL.SendMessageInput?>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func createConversation(message: Parameter<GQL.SendMessageInput?>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willProduce: (StubberThrows<RemoteConversation>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (RemoteConversation).self)
			willProduce(stubber)
			return given
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_setIsTyping__isTypingconversationId_conversationId(`isTyping`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_setIsTyping__isTypingconversationId_conversationId(`isTyping`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func markConversationAsSeen(conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_markConversationAsSeen__conversationId_conversationId(`conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func markConversationAsSeen(conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_markConversationAsSeen__conversationId_conversationId(`conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createConversation(message: Parameter<GQL.SendMessageInput?>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>) -> Verify { return Verify(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`))}
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_setIsTyping__isTypingconversationId_conversationId(`isTyping`, `conversationId`))}
        public static func markConversationAsSeen(conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_markConversationAsSeen__conversationId_conversationId(`conversationId`))}
        public static func watchConversation(_ conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_watchConversation__conversationId(`conversationId`))}
        public static func watchConversations() -> Verify { return Verify(method: .m_watchConversations)}
        public static func subscribeToConversationsEvents() -> Verify { return Verify(method: .m_subscribeToConversationsEvents)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createConversation(message: Parameter<GQL.SendMessageInput?>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>, perform: @escaping (GQL.SendMessageInput?, String?, [UUID]?) -> Void) -> Perform {
            return Perform(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`), performs: perform)
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<UUID>, perform: @escaping (Bool, UUID) -> Void) -> Perform {
            return Perform(method: .m_setIsTyping__isTypingconversationId_conversationId(`isTyping`, `conversationId`), performs: perform)
        }
        public static func markConversationAsSeen(conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_markConversationAsSeen__conversationId_conversationId(`conversationId`), performs: perform)
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_watchConversation__conversationId(`conversationId`), performs: perform)
        }
        public static func watchConversations(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_watchConversations, performs: perform)
        }
        public static func subscribeToConversationsEvents(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_subscribeToConversationsEvents, performs: perform)
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

// MARK: - ConversationRepository

open class ConversationRepositoryMock: ConversationRepository, Mock {
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





    open func getConversationTransientId(from id: UUID) -> TransientUUID {
        addInvocation(.m_getConversationTransientId__from_id(Parameter<UUID>.value(`id`)))
		let perform = methodPerformValue(.m_getConversationTransientId__from_id(Parameter<UUID>.value(`id`))) as? (UUID) -> Void
		perform?(`id`)
		var __value: TransientUUID
		do {
		    __value = try methodReturnValue(.m_getConversationTransientId__from_id(Parameter<UUID>.value(`id`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for getConversationTransientId(from id: UUID). Use given")
			Failure("Stub return value not specified for getConversationTransientId(from id: UUID). Use given")
		}
		return __value
    }

    open func watchConversation(withId conversationId: TransientUUID) -> AnyPublisher<Conversation, NablaError> {
        addInvocation(.m_watchConversation__withId_conversationId(Parameter<TransientUUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_watchConversation__withId_conversationId(Parameter<TransientUUID>.value(`conversationId`))) as? (TransientUUID) -> Void
		perform?(`conversationId`)
		var __value: AnyPublisher<Conversation, NablaError>
		do {
		    __value = try methodReturnValue(.m_watchConversation__withId_conversationId(Parameter<TransientUUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversation(withId conversationId: TransientUUID). Use given")
			Failure("Stub return value not specified for watchConversation(withId conversationId: TransientUUID). Use given")
		}
		return __value
    }

    open func watchConversations() -> AnyPublisher<PaginatedList<Conversation>, NablaError> {
        addInvocation(.m_watchConversations)
		let perform = methodPerformValue(.m_watchConversations) as? () -> Void
		perform?()
		var __value: AnyPublisher<PaginatedList<Conversation>, NablaError>
		do {
		    __value = try methodReturnValue(.m_watchConversations).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversations(). Use given")
			Failure("Stub return value not specified for watchConversations(). Use given")
		}
		return __value
    }

    open func createConversation(message: MessageInput, title: String?, providerIds: [UUID]?) throws -> Conversation {
        addInvocation(.m_createConversation__message_messagetitle_titleproviderIds_providerIds(Parameter<MessageInput>.value(`message`), Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`)))
		let perform = methodPerformValue(.m_createConversation__message_messagetitle_titleproviderIds_providerIds(Parameter<MessageInput>.value(`message`), Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))) as? (MessageInput, String?, [UUID]?) -> Void
		perform?(`message`, `title`, `providerIds`)
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_createConversation__message_messagetitle_titleproviderIds_providerIds(Parameter<MessageInput>.value(`message`), Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for createConversation(message: MessageInput, title: String?, providerIds: [UUID]?). Use given")
			Failure("Stub return value not specified for createConversation(message: MessageInput, title: String?, providerIds: [UUID]?). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func startConversation(title: String?, providerIds: [UUID]?) -> Conversation {
        addInvocation(.m_startConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`)))
		let perform = methodPerformValue(.m_startConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))) as? (String?, [UUID]?) -> Void
		perform?(`title`, `providerIds`)
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_startConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for startConversation(title: String?, providerIds: [UUID]?). Use given")
			Failure("Stub return value not specified for startConversation(title: String?, providerIds: [UUID]?). Use given")
		}
		return __value
    }

    open func setIsTyping(_ isTyping: Bool, conversationId: TransientUUID) throws {
        addInvocation(.m_setIsTyping__isTypingconversationId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<TransientUUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_setIsTyping__isTypingconversationId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<TransientUUID>.value(`conversationId`))) as? (Bool, TransientUUID) -> Void
		perform?(`isTyping`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_setIsTyping__isTypingconversationId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<TransientUUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func markConversationAsSeen(conversationId: TransientUUID) throws {
        addInvocation(.m_markConversationAsSeen__conversationId_conversationId(Parameter<TransientUUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_markConversationAsSeen__conversationId_conversationId(Parameter<TransientUUID>.value(`conversationId`))) as? (TransientUUID) -> Void
		perform?(`conversationId`)
		do {
		    _ = try methodReturnValue(.m_markConversationAsSeen__conversationId_conversationId(Parameter<TransientUUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }


    fileprivate enum MethodType {
        case m_getConversationTransientId__from_id(Parameter<UUID>)
        case m_watchConversation__withId_conversationId(Parameter<TransientUUID>)
        case m_watchConversations
        case m_createConversation__message_messagetitle_titleproviderIds_providerIds(Parameter<MessageInput>, Parameter<String?>, Parameter<[UUID]?>)
        case m_startConversation__title_titleproviderIds_providerIds(Parameter<String?>, Parameter<[UUID]?>)
        case m_setIsTyping__isTypingconversationId_conversationId(Parameter<Bool>, Parameter<TransientUUID>)
        case m_markConversationAsSeen__conversationId_conversationId(Parameter<TransientUUID>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_getConversationTransientId__from_id(let lhsId), .m_getConversationTransientId__from_id(let rhsId)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsId, rhs: rhsId, with: matcher), lhsId, rhsId, "from id"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversation__withId_conversationId(let lhsConversationid), .m_watchConversation__withId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "withId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversations, .m_watchConversations): return .match

            case (.m_createConversation__message_messagetitle_titleproviderIds_providerIds(let lhsMessage, let lhsTitle, let lhsProviderids), .m_createConversation__message_messagetitle_titleproviderIds_providerIds(let rhsMessage, let rhsTitle, let rhsProviderids)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "title"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsProviderids, rhs: rhsProviderids, with: matcher), lhsProviderids, rhsProviderids, "providerIds"))
				return Matcher.ComparisonResult(results)

            case (.m_startConversation__title_titleproviderIds_providerIds(let lhsTitle, let lhsProviderids), .m_startConversation__title_titleproviderIds_providerIds(let rhsTitle, let rhsProviderids)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "title"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsProviderids, rhs: rhsProviderids, with: matcher), lhsProviderids, rhsProviderids, "providerIds"))
				return Matcher.ComparisonResult(results)

            case (.m_setIsTyping__isTypingconversationId_conversationId(let lhsIstyping, let lhsConversationid), .m_setIsTyping__isTypingconversationId_conversationId(let rhsIstyping, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIstyping, rhs: rhsIstyping, with: matcher), lhsIstyping, rhsIstyping, "_ isTyping"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_markConversationAsSeen__conversationId_conversationId(let lhsConversationid), .m_markConversationAsSeen__conversationId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_getConversationTransientId__from_id(p0): return p0.intValue
            case let .m_watchConversation__withId_conversationId(p0): return p0.intValue
            case .m_watchConversations: return 0
            case let .m_createConversation__message_messagetitle_titleproviderIds_providerIds(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_startConversation__title_titleproviderIds_providerIds(p0, p1): return p0.intValue + p1.intValue
            case let .m_setIsTyping__isTypingconversationId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_markConversationAsSeen__conversationId_conversationId(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_getConversationTransientId__from_id: return ".getConversationTransientId(from:)"
            case .m_watchConversation__withId_conversationId: return ".watchConversation(withId:)"
            case .m_watchConversations: return ".watchConversations()"
            case .m_createConversation__message_messagetitle_titleproviderIds_providerIds: return ".createConversation(message:title:providerIds:)"
            case .m_startConversation__title_titleproviderIds_providerIds: return ".startConversation(title:providerIds:)"
            case .m_setIsTyping__isTypingconversationId_conversationId: return ".setIsTyping(_:conversationId:)"
            case .m_markConversationAsSeen__conversationId_conversationId: return ".markConversationAsSeen(conversationId:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func getConversationTransientId(from id: Parameter<UUID>, willReturn: TransientUUID...) -> MethodStub {
            return Given(method: .m_getConversationTransientId__from_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversation(withId conversationId: Parameter<TransientUUID>, willReturn: AnyPublisher<Conversation, NablaError>...) -> MethodStub {
            return Given(method: .m_watchConversation__withId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversations(willReturn: AnyPublisher<PaginatedList<Conversation>, NablaError>...) -> MethodStub {
            return Given(method: .m_watchConversations, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createConversation(message: Parameter<MessageInput>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func startConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_startConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func getConversationTransientId(from id: Parameter<UUID>, willProduce: (Stubber<TransientUUID>) -> Void) -> MethodStub {
            let willReturn: [TransientUUID] = []
			let given: Given = { return Given(method: .m_getConversationTransientId__from_id(`id`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (TransientUUID).self)
			willProduce(stubber)
			return given
        }
        public static func watchConversation(withId conversationId: Parameter<TransientUUID>, willProduce: (Stubber<AnyPublisher<Conversation, NablaError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Conversation, NablaError>] = []
			let given: Given = { return Given(method: .m_watchConversation__withId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Conversation, NablaError>).self)
			willProduce(stubber)
			return given
        }
        public static func watchConversations(willProduce: (Stubber<AnyPublisher<PaginatedList<Conversation>, NablaError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<PaginatedList<Conversation>, NablaError>] = []
			let given: Given = { return Given(method: .m_watchConversations, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<PaginatedList<Conversation>, NablaError>).self)
			willProduce(stubber)
			return given
        }
        public static func startConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willProduce: (Stubber<Conversation>) -> Void) -> MethodStub {
            let willReturn: [Conversation] = []
			let given: Given = { return Given(method: .m_startConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
        public static func createConversation(message: Parameter<MessageInput>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func createConversation(message: Parameter<MessageInput>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willProduce: (StubberThrows<Conversation>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<TransientUUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_setIsTyping__isTypingconversationId_conversationId(`isTyping`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<TransientUUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_setIsTyping__isTypingconversationId_conversationId(`isTyping`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func markConversationAsSeen(conversationId: Parameter<TransientUUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_markConversationAsSeen__conversationId_conversationId(`conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func markConversationAsSeen(conversationId: Parameter<TransientUUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_markConversationAsSeen__conversationId_conversationId(`conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func getConversationTransientId(from id: Parameter<UUID>) -> Verify { return Verify(method: .m_getConversationTransientId__from_id(`id`))}
        public static func watchConversation(withId conversationId: Parameter<TransientUUID>) -> Verify { return Verify(method: .m_watchConversation__withId_conversationId(`conversationId`))}
        public static func watchConversations() -> Verify { return Verify(method: .m_watchConversations)}
        public static func createConversation(message: Parameter<MessageInput>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>) -> Verify { return Verify(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`))}
        public static func startConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>) -> Verify { return Verify(method: .m_startConversation__title_titleproviderIds_providerIds(`title`, `providerIds`))}
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<TransientUUID>) -> Verify { return Verify(method: .m_setIsTyping__isTypingconversationId_conversationId(`isTyping`, `conversationId`))}
        public static func markConversationAsSeen(conversationId: Parameter<TransientUUID>) -> Verify { return Verify(method: .m_markConversationAsSeen__conversationId_conversationId(`conversationId`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func getConversationTransientId(from id: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_getConversationTransientId__from_id(`id`), performs: perform)
        }
        public static func watchConversation(withId conversationId: Parameter<TransientUUID>, perform: @escaping (TransientUUID) -> Void) -> Perform {
            return Perform(method: .m_watchConversation__withId_conversationId(`conversationId`), performs: perform)
        }
        public static func watchConversations(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_watchConversations, performs: perform)
        }
        public static func createConversation(message: Parameter<MessageInput>, title: Parameter<String?>, providerIds: Parameter<[UUID]?>, perform: @escaping (MessageInput, String?, [UUID]?) -> Void) -> Perform {
            return Perform(method: .m_createConversation__message_messagetitle_titleproviderIds_providerIds(`message`, `title`, `providerIds`), performs: perform)
        }
        public static func startConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, perform: @escaping (String?, [UUID]?) -> Void) -> Perform {
            return Perform(method: .m_startConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), performs: perform)
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, conversationId: Parameter<TransientUUID>, perform: @escaping (Bool, TransientUUID) -> Void) -> Perform {
            return Perform(method: .m_setIsTyping__isTypingconversationId_conversationId(`isTyping`, `conversationId`), performs: perform)
        }
        public static func markConversationAsSeen(conversationId: Parameter<TransientUUID>, perform: @escaping (TransientUUID) -> Void) -> Perform {
            return Perform(method: .m_markConversationAsSeen__conversationId_conversationId(`conversationId`), performs: perform)
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

// MARK: - FileUploadRemoteDataSource

open class FileUploadRemoteDataSourceMock: FileUploadRemoteDataSource, Mock {
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





    open func upload(file: RemoteFileUpload) throws -> UUID {
        addInvocation(.m_upload__file_file(Parameter<RemoteFileUpload>.value(`file`)))
		let perform = methodPerformValue(.m_upload__file_file(Parameter<RemoteFileUpload>.value(`file`))) as? (RemoteFileUpload) -> Void
		perform?(`file`)
		var __value: UUID
		do {
		    __value = try methodReturnValue(.m_upload__file_file(Parameter<RemoteFileUpload>.value(`file`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for upload(file: RemoteFileUpload). Use given")
			Failure("Stub return value not specified for upload(file: RemoteFileUpload). Use given")
		} catch {
		    throw error
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_upload__file_file(Parameter<RemoteFileUpload>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_upload__file_file(let lhsFile), .m_upload__file_file(let rhsFile)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFile, rhs: rhsFile, with: matcher), lhsFile, rhsFile, "file"))
				return Matcher.ComparisonResult(results)
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_upload__file_file(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_upload__file_file: return ".upload(file:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func upload(file: Parameter<RemoteFileUpload>, willReturn: UUID...) -> MethodStub {
            return Given(method: .m_upload__file_file(`file`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func upload(file: Parameter<RemoteFileUpload>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_upload__file_file(`file`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func upload(file: Parameter<RemoteFileUpload>, willProduce: (StubberThrows<UUID>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_upload__file_file(`file`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (UUID).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func upload(file: Parameter<RemoteFileUpload>) -> Verify { return Verify(method: .m_upload__file_file(`file`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func upload(file: Parameter<RemoteFileUpload>, perform: @escaping (RemoteFileUpload) -> Void) -> Perform {
            return Perform(method: .m_upload__file_file(`file`), performs: perform)
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

// MARK: - GateKeepers

open class GateKeepersMock: GateKeepers, Mock {
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

    public var supportVideoCallActionRequests: Bool {
		get {	invocations.append(.p_supportVideoCallActionRequests_get); return __p_supportVideoCallActionRequests ?? givenGetterValue(.p_supportVideoCallActionRequests_get, "GateKeepersMock - stub value for supportVideoCallActionRequests was not defined") }
	}
	private var __p_supportVideoCallActionRequests: (Bool)?






    fileprivate enum MethodType {
        case p_supportVideoCallActionRequests_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {            case (.p_supportVideoCallActionRequests_get,.p_supportVideoCallActionRequests_get): return Matcher.ComparisonResult.match
            }
        }

        func intValue() -> Int {
            switch self {
            case .p_supportVideoCallActionRequests_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .p_supportVideoCallActionRequests_get: return "[get] .supportVideoCallActionRequests"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func supportVideoCallActionRequests(getter defaultValue: Bool...) -> PropertyStub {
            return Given(method: .p_supportVideoCallActionRequests_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

    }

    public struct Verify {
        fileprivate var method: MethodType

        public static var supportVideoCallActionRequests: Verify { return Verify(method: .p_supportVideoCallActionRequests_get) }
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

