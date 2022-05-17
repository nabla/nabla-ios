// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
@testable import NablaMessagingCore


// MARK: - Cancellable

open class CancellableMock: Cancellable, Mock {
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
    public typealias Cancellable = NablaMessagingCore.Cancellable

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





    open func cancel() {
        addInvocation(.m_cancel)
		let perform = methodPerformValue(.m_cancel) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_cancel

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_cancel, .m_cancel): return .match
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_cancel: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_cancel: return ".cancel()"
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

        public static func cancel() -> Verify { return Verify(method: .m_cancel)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func cancel(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_cancel, performs: perform)
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
    public typealias Cancellable = NablaMessagingCore.Cancellable

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





    open func fetch<Query: GQLQuery>(query: Query, cachePolicy: CachePolicy, handler: ResultHandler<Query.Data, GQLError>) -> Cancellable {
        addInvocation(.m_fetch__query_querycachePolicy_cachePolicyhandler_handler(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<CachePolicy>.value(`cachePolicy`), Parameter<ResultHandler<Query.Data, GQLError>>.value(`handler`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_fetch__query_querycachePolicy_cachePolicyhandler_handler(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<CachePolicy>.value(`cachePolicy`), Parameter<ResultHandler<Query.Data, GQLError>>.value(`handler`).wrapAsGeneric())) as? (Query, CachePolicy, ResultHandler<Query.Data, GQLError>) -> Void
		perform?(`query`, `cachePolicy`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_fetch__query_querycachePolicy_cachePolicyhandler_handler(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<CachePolicy>.value(`cachePolicy`), Parameter<ResultHandler<Query.Data, GQLError>>.value(`handler`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for fetch<Query: GQLQuery>(query: Query, cachePolicy: CachePolicy, handler: ResultHandler<Query.Data, GQLError>). Use given")
			Failure("Stub return value not specified for fetch<Query: GQLQuery>(query: Query, cachePolicy: CachePolicy, handler: ResultHandler<Query.Data, GQLError>). Use given")
		}
		return __value
    }

    open func perform<Mutation: GQLMutation>(mutation: Mutation, handler: ResultHandler<Mutation.Data, GQLError>) -> Cancellable {
        addInvocation(.m_perform__mutation_mutationhandler_handler(Parameter<Mutation>.value(`mutation`).wrapAsGeneric(), Parameter<ResultHandler<Mutation.Data, GQLError>>.value(`handler`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_perform__mutation_mutationhandler_handler(Parameter<Mutation>.value(`mutation`).wrapAsGeneric(), Parameter<ResultHandler<Mutation.Data, GQLError>>.value(`handler`).wrapAsGeneric())) as? (Mutation, ResultHandler<Mutation.Data, GQLError>) -> Void
		perform?(`mutation`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_perform__mutation_mutationhandler_handler(Parameter<Mutation>.value(`mutation`).wrapAsGeneric(), Parameter<ResultHandler<Mutation.Data, GQLError>>.value(`handler`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for perform<Mutation: GQLMutation>(mutation: Mutation, handler: ResultHandler<Mutation.Data, GQLError>). Use given")
			Failure("Stub return value not specified for perform<Mutation: GQLMutation>(mutation: Mutation, handler: ResultHandler<Mutation.Data, GQLError>). Use given")
		}
		return __value
    }

    open func watch<Query: GQLQuery>(query: Query, cachePolicy: CachePolicy, handler: ResultHandler<Query.Data, GQLError>) -> GQLWatcher<Query> {
        addInvocation(.m_watch__query_querycachePolicy_cachePolicyhandler_handler(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<CachePolicy>.value(`cachePolicy`), Parameter<ResultHandler<Query.Data, GQLError>>.value(`handler`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_watch__query_querycachePolicy_cachePolicyhandler_handler(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<CachePolicy>.value(`cachePolicy`), Parameter<ResultHandler<Query.Data, GQLError>>.value(`handler`).wrapAsGeneric())) as? (Query, CachePolicy, ResultHandler<Query.Data, GQLError>) -> Void
		perform?(`query`, `cachePolicy`, `handler`)
		var __value: GQLWatcher<Query>
		do {
		    __value = try methodReturnValue(.m_watch__query_querycachePolicy_cachePolicyhandler_handler(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<CachePolicy>.value(`cachePolicy`), Parameter<ResultHandler<Query.Data, GQLError>>.value(`handler`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watch<Query: GQLQuery>(query: Query, cachePolicy: CachePolicy, handler: ResultHandler<Query.Data, GQLError>). Use given")
			Failure("Stub return value not specified for watch<Query: GQLQuery>(query: Query, cachePolicy: CachePolicy, handler: ResultHandler<Query.Data, GQLError>). Use given")
		}
		return __value
    }

    open func subscribe<Subscription: GQLSubscription>(subscription: Subscription, handler: ResultHandler<Subscription.Data, GQLError>) -> Cancellable {
        addInvocation(.m_subscribe__subscription_subscriptionhandler_handler(Parameter<Subscription>.value(`subscription`).wrapAsGeneric(), Parameter<ResultHandler<Subscription.Data, GQLError>>.value(`handler`).wrapAsGeneric()))
		let perform = methodPerformValue(.m_subscribe__subscription_subscriptionhandler_handler(Parameter<Subscription>.value(`subscription`).wrapAsGeneric(), Parameter<ResultHandler<Subscription.Data, GQLError>>.value(`handler`).wrapAsGeneric())) as? (Subscription, ResultHandler<Subscription.Data, GQLError>) -> Void
		perform?(`subscription`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_subscribe__subscription_subscriptionhandler_handler(Parameter<Subscription>.value(`subscription`).wrapAsGeneric(), Parameter<ResultHandler<Subscription.Data, GQLError>>.value(`handler`).wrapAsGeneric())).casted()
		} catch {
			onFatalFailure("Stub return value not specified for subscribe<Subscription: GQLSubscription>(subscription: Subscription, handler: ResultHandler<Subscription.Data, GQLError>). Use given")
			Failure("Stub return value not specified for subscribe<Subscription: GQLSubscription>(subscription: Subscription, handler: ResultHandler<Subscription.Data, GQLError>). Use given")
		}
		return __value
    }

    open func addRefetchTriggers(_ triggers: [RefetchTrigger]) {
        addInvocation(.m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>.value(`triggers`)))
		let perform = methodPerformValue(.m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>.value(`triggers`))) as? ([RefetchTrigger]) -> Void
		perform?(`triggers`)
    }


    fileprivate enum MethodType {
        case m_fetch__query_querycachePolicy_cachePolicyhandler_handler(Parameter<GenericAttribute>, Parameter<CachePolicy>, Parameter<GenericAttribute>)
        case m_perform__mutation_mutationhandler_handler(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case m_watch__query_querycachePolicy_cachePolicyhandler_handler(Parameter<GenericAttribute>, Parameter<CachePolicy>, Parameter<GenericAttribute>)
        case m_subscribe__subscription_subscriptionhandler_handler(Parameter<GenericAttribute>, Parameter<GenericAttribute>)
        case m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_fetch__query_querycachePolicy_cachePolicyhandler_handler(let lhsQuery, let lhsCachepolicy, let lhsHandler), .m_fetch__query_querycachePolicy_cachePolicyhandler_handler(let rhsQuery, let rhsCachepolicy, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCachepolicy, rhs: rhsCachepolicy, with: matcher), lhsCachepolicy, rhsCachepolicy, "cachePolicy"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_perform__mutation_mutationhandler_handler(let lhsMutation, let lhsHandler), .m_perform__mutation_mutationhandler_handler(let rhsMutation, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMutation, rhs: rhsMutation, with: matcher), lhsMutation, rhsMutation, "mutation"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_watch__query_querycachePolicy_cachePolicyhandler_handler(let lhsQuery, let lhsCachepolicy, let lhsHandler), .m_watch__query_querycachePolicy_cachePolicyhandler_handler(let rhsQuery, let rhsCachepolicy, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCachepolicy, rhs: rhsCachepolicy, with: matcher), lhsCachepolicy, rhsCachepolicy, "cachePolicy"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_subscribe__subscription_subscriptionhandler_handler(let lhsSubscription, let lhsHandler), .m_subscribe__subscription_subscriptionhandler_handler(let rhsSubscription, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsSubscription, rhs: rhsSubscription, with: matcher), lhsSubscription, rhsSubscription, "subscription"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
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
            case let .m_fetch__query_querycachePolicy_cachePolicyhandler_handler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_perform__mutation_mutationhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_watch__query_querycachePolicy_cachePolicyhandler_handler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_subscribe__subscription_subscriptionhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_addRefetchTriggers__triggers(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_fetch__query_querycachePolicy_cachePolicyhandler_handler: return ".fetch(query:cachePolicy:handler:)"
            case .m_perform__mutation_mutationhandler_handler: return ".perform(mutation:handler:)"
            case .m_watch__query_querycachePolicy_cachePolicyhandler_handler: return ".watch(query:cachePolicy:handler:)"
            case .m_subscribe__subscription_subscriptionhandler_handler: return ".subscribe(subscription:handler:)"
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


        public static func fetch<Query: GQLQuery>(query: Parameter<Query>, cachePolicy: Parameter<CachePolicy>, handler: Parameter<ResultHandler<Query.Data, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_fetch__query_querycachePolicy_cachePolicyhandler_handler(`query`.wrapAsGeneric(), `cachePolicy`, `handler`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func perform<Mutation: GQLMutation>(mutation: Parameter<Mutation>, handler: Parameter<ResultHandler<Mutation.Data, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_perform__mutation_mutationhandler_handler(`mutation`.wrapAsGeneric(), `handler`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watch<Query: GQLQuery>(query: Parameter<Query>, cachePolicy: Parameter<CachePolicy>, handler: Parameter<ResultHandler<Query.Data, GQLError>>, willReturn: GQLWatcher<Query>...) -> MethodStub {
            return Given(method: .m_watch__query_querycachePolicy_cachePolicyhandler_handler(`query`.wrapAsGeneric(), `cachePolicy`, `handler`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func subscribe<Subscription: GQLSubscription>(subscription: Parameter<Subscription>, handler: Parameter<ResultHandler<Subscription.Data, GQLError>>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_subscribe__subscription_subscriptionhandler_handler(`subscription`.wrapAsGeneric(), `handler`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func fetch<Query: GQLQuery>(query: Parameter<Query>, cachePolicy: Parameter<CachePolicy>, handler: Parameter<ResultHandler<Query.Data, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_fetch__query_querycachePolicy_cachePolicyhandler_handler(`query`.wrapAsGeneric(), `cachePolicy`, `handler`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func perform<Mutation: GQLMutation>(mutation: Parameter<Mutation>, handler: Parameter<ResultHandler<Mutation.Data, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_perform__mutation_mutationhandler_handler(`mutation`.wrapAsGeneric(), `handler`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func watch<Query: GQLQuery>(query: Parameter<Query>, cachePolicy: Parameter<CachePolicy>, handler: Parameter<ResultHandler<Query.Data, GQLError>>, willProduce: (Stubber<GQLWatcher<Query>>) -> Void) -> MethodStub {
            let willReturn: [GQLWatcher<Query>] = []
			let given: Given = { return Given(method: .m_watch__query_querycachePolicy_cachePolicyhandler_handler(`query`.wrapAsGeneric(), `cachePolicy`, `handler`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (GQLWatcher<Query>).self)
			willProduce(stubber)
			return given
        }
        public static func subscribe<Subscription: GQLSubscription>(subscription: Parameter<Subscription>, handler: Parameter<ResultHandler<Subscription.Data, GQLError>>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_subscribe__subscription_subscriptionhandler_handler(`subscription`.wrapAsGeneric(), `handler`.wrapAsGeneric()), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func fetch<Query>(query: Parameter<Query>, cachePolicy: Parameter<CachePolicy>, handler: Parameter<ResultHandler<Query.Data, GQLError>>) -> Verify where Query:GQLQuery { return Verify(method: .m_fetch__query_querycachePolicy_cachePolicyhandler_handler(`query`.wrapAsGeneric(), `cachePolicy`, `handler`.wrapAsGeneric()))}
        public static func perform<Mutation>(mutation: Parameter<Mutation>, handler: Parameter<ResultHandler<Mutation.Data, GQLError>>) -> Verify where Mutation:GQLMutation { return Verify(method: .m_perform__mutation_mutationhandler_handler(`mutation`.wrapAsGeneric(), `handler`.wrapAsGeneric()))}
        public static func watch<Query>(query: Parameter<Query>, cachePolicy: Parameter<CachePolicy>, handler: Parameter<ResultHandler<Query.Data, GQLError>>) -> Verify where Query:GQLQuery { return Verify(method: .m_watch__query_querycachePolicy_cachePolicyhandler_handler(`query`.wrapAsGeneric(), `cachePolicy`, `handler`.wrapAsGeneric()))}
        public static func subscribe<Subscription>(subscription: Parameter<Subscription>, handler: Parameter<ResultHandler<Subscription.Data, GQLError>>) -> Verify where Subscription:GQLSubscription { return Verify(method: .m_subscribe__subscription_subscriptionhandler_handler(`subscription`.wrapAsGeneric(), `handler`.wrapAsGeneric()))}
        public static func addRefetchTriggers(_ triggers: Parameter<[RefetchTrigger]>) -> Verify { return Verify(method: .m_addRefetchTriggers__triggers(`triggers`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func fetch<Query>(query: Parameter<Query>, cachePolicy: Parameter<CachePolicy>, handler: Parameter<ResultHandler<Query.Data, GQLError>>, perform: @escaping (Query, CachePolicy, ResultHandler<Query.Data, GQLError>) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_fetch__query_querycachePolicy_cachePolicyhandler_handler(`query`.wrapAsGeneric(), `cachePolicy`, `handler`.wrapAsGeneric()), performs: perform)
        }
        public static func perform<Mutation>(mutation: Parameter<Mutation>, handler: Parameter<ResultHandler<Mutation.Data, GQLError>>, perform: @escaping (Mutation, ResultHandler<Mutation.Data, GQLError>) -> Void) -> Perform where Mutation:GQLMutation {
            return Perform(method: .m_perform__mutation_mutationhandler_handler(`mutation`.wrapAsGeneric(), `handler`.wrapAsGeneric()), performs: perform)
        }
        public static func watch<Query>(query: Parameter<Query>, cachePolicy: Parameter<CachePolicy>, handler: Parameter<ResultHandler<Query.Data, GQLError>>, perform: @escaping (Query, CachePolicy, ResultHandler<Query.Data, GQLError>) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_watch__query_querycachePolicy_cachePolicyhandler_handler(`query`.wrapAsGeneric(), `cachePolicy`, `handler`.wrapAsGeneric()), performs: perform)
        }
        public static func subscribe<Subscription>(subscription: Parameter<Subscription>, handler: Parameter<ResultHandler<Subscription.Data, GQLError>>, perform: @escaping (Subscription, ResultHandler<Subscription.Data, GQLError>) -> Void) -> Perform where Subscription:GQLSubscription {
            return Perform(method: .m_subscribe__subscription_subscriptionhandler_handler(`subscription`.wrapAsGeneric(), `handler`.wrapAsGeneric()), performs: perform)
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
    public typealias Cancellable = NablaMessagingCore.Cancellable

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





    open func createCache<Query: GQLQuery>(for query: Query, data: Query.Data, completion: @escaping (Result<Void, GQLError.CacheError>) -> Void) {
        addInvocation(.m_createCache__for_querydata_datacompletion_completion(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Query.Data>.value(`data`).wrapAsGeneric(), Parameter<(Result<Void, GQLError.CacheError>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_createCache__for_querydata_datacompletion_completion(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Query.Data>.value(`data`).wrapAsGeneric(), Parameter<(Result<Void, GQLError.CacheError>) -> Void>.value(`completion`))) as? (Query, Query.Data, @escaping (Result<Void, GQLError.CacheError>) -> Void) -> Void
		perform?(`query`, `data`, `completion`)
    }

    open func updateCache<Query: GQLQuery>(for query: Query, onlyIfExists: Bool, body: @escaping (inout Query.Data) throws -> Void, completion: @escaping (Result<Void, GQLError.CacheError>) -> Void) {
        addInvocation(.m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Query.Data) throws -> Void>.value(`body`).wrapAsGeneric(), Parameter<(Result<Void, GQLError.CacheError>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Query.Data) throws -> Void>.value(`body`).wrapAsGeneric(), Parameter<(Result<Void, GQLError.CacheError>) -> Void>.value(`completion`))) as? (Query, Bool, @escaping (inout Query.Data) throws -> Void, @escaping (Result<Void, GQLError.CacheError>) -> Void) -> Void
		perform?(`query`, `onlyIfExists`, `body`, `completion`)
    }

    open func updateCache<Fragment: GQLFragment>(of fragment: Fragment, onlyIfExists: Bool, body: @escaping (inout Fragment) throws -> Void, completion: @escaping (Result<Void, GQLError.CacheError>) -> Void) {
        addInvocation(.m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion(Parameter<Fragment>.value(`fragment`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Fragment) throws -> Void>.value(`body`).wrapAsGeneric(), Parameter<(Result<Void, GQLError.CacheError>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion(Parameter<Fragment>.value(`fragment`).wrapAsGeneric(), Parameter<Bool>.value(`onlyIfExists`), Parameter<(inout Fragment) throws -> Void>.value(`body`).wrapAsGeneric(), Parameter<(Result<Void, GQLError.CacheError>) -> Void>.value(`completion`))) as? (Fragment, Bool, @escaping (inout Fragment) throws -> Void, @escaping (Result<Void, GQLError.CacheError>) -> Void) -> Void
		perform?(`fragment`, `onlyIfExists`, `body`, `completion`)
    }

    open func cacheExists<Query: GQLQuery>(for query: Query, completion: @escaping (Result<Bool, GQLError.CacheError>) -> Void) {
        addInvocation(.m_cacheExists__for_querycompletion_completion(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<(Result<Bool, GQLError.CacheError>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_cacheExists__for_querycompletion_completion(Parameter<Query>.value(`query`).wrapAsGeneric(), Parameter<(Result<Bool, GQLError.CacheError>) -> Void>.value(`completion`))) as? (Query, @escaping (Result<Bool, GQLError.CacheError>) -> Void) -> Void
		perform?(`query`, `completion`)
    }

    open func cacheExists<Fragment: GQLFragment>(of fragment: Fragment, completion: @escaping (Result<Bool, GQLError.CacheError>) -> Void) {
        addInvocation(.m_cacheExists__of_fragmentcompletion_completion(Parameter<Fragment>.value(`fragment`).wrapAsGeneric(), Parameter<(Result<Bool, GQLError.CacheError>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_cacheExists__of_fragmentcompletion_completion(Parameter<Fragment>.value(`fragment`).wrapAsGeneric(), Parameter<(Result<Bool, GQLError.CacheError>) -> Void>.value(`completion`))) as? (Fragment, @escaping (Result<Bool, GQLError.CacheError>) -> Void) -> Void
		perform?(`fragment`, `completion`)
    }

    open func clearCache(completion: @escaping (Result<Void, GQLError.CacheError>) -> Void) {
        addInvocation(.m_clearCache__completion_completion(Parameter<(Result<Void, GQLError.CacheError>) -> Void>.value(`completion`)))
		let perform = methodPerformValue(.m_clearCache__completion_completion(Parameter<(Result<Void, GQLError.CacheError>) -> Void>.value(`completion`))) as? (@escaping (Result<Void, GQLError.CacheError>) -> Void) -> Void
		perform?(`completion`)
    }


    fileprivate enum MethodType {
        case m_createCache__for_querydata_datacompletion_completion(Parameter<GenericAttribute>, Parameter<GenericAttribute>, Parameter<(Result<Void, GQLError.CacheError>) -> Void>)
        case m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion(Parameter<GenericAttribute>, Parameter<Bool>, Parameter<GenericAttribute>, Parameter<(Result<Void, GQLError.CacheError>) -> Void>)
        case m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion(Parameter<GenericAttribute>, Parameter<Bool>, Parameter<GenericAttribute>, Parameter<(Result<Void, GQLError.CacheError>) -> Void>)
        case m_cacheExists__for_querycompletion_completion(Parameter<GenericAttribute>, Parameter<(Result<Bool, GQLError.CacheError>) -> Void>)
        case m_cacheExists__of_fragmentcompletion_completion(Parameter<GenericAttribute>, Parameter<(Result<Bool, GQLError.CacheError>) -> Void>)
        case m_clearCache__completion_completion(Parameter<(Result<Void, GQLError.CacheError>) -> Void>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createCache__for_querydata_datacompletion_completion(let lhsQuery, let lhsData, let lhsCompletion), .m_createCache__for_querydata_datacompletion_completion(let rhsQuery, let rhsData, let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "for query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsData, rhs: rhsData, with: matcher), lhsData, rhsData, "data"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)

            case (.m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion(let lhsQuery, let lhsOnlyifexists, let lhsBody, let lhsCompletion), .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion(let rhsQuery, let rhsOnlyifexists, let rhsBody, let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "for query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOnlyifexists, rhs: rhsOnlyifexists, with: matcher), lhsOnlyifexists, rhsOnlyifexists, "onlyIfExists"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsBody, rhs: rhsBody, with: matcher), lhsBody, rhsBody, "body"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)

            case (.m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion(let lhsFragment, let lhsOnlyifexists, let lhsBody, let lhsCompletion), .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion(let rhsFragment, let rhsOnlyifexists, let rhsBody, let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFragment, rhs: rhsFragment, with: matcher), lhsFragment, rhsFragment, "of fragment"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsOnlyifexists, rhs: rhsOnlyifexists, with: matcher), lhsOnlyifexists, rhsOnlyifexists, "onlyIfExists"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsBody, rhs: rhsBody, with: matcher), lhsBody, rhsBody, "body"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)

            case (.m_cacheExists__for_querycompletion_completion(let lhsQuery, let lhsCompletion), .m_cacheExists__for_querycompletion_completion(let rhsQuery, let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsQuery, rhs: rhsQuery, with: matcher), lhsQuery, rhsQuery, "for query"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)

            case (.m_cacheExists__of_fragmentcompletion_completion(let lhsFragment, let lhsCompletion), .m_cacheExists__of_fragmentcompletion_completion(let rhsFragment, let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFragment, rhs: rhsFragment, with: matcher), lhsFragment, rhsFragment, "of fragment"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)

            case (.m_clearCache__completion_completion(let lhsCompletion), .m_clearCache__completion_completion(let rhsCompletion)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsCompletion, rhs: rhsCompletion, with: matcher), lhsCompletion, rhsCompletion, "completion"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_createCache__for_querydata_datacompletion_completion(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_cacheExists__for_querycompletion_completion(p0, p1): return p0.intValue + p1.intValue
            case let .m_cacheExists__of_fragmentcompletion_completion(p0, p1): return p0.intValue + p1.intValue
            case let .m_clearCache__completion_completion(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createCache__for_querydata_datacompletion_completion: return ".createCache(for:data:completion:)"
            case .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion: return ".updateCache(for:onlyIfExists:body:completion:)"
            case .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion: return ".updateCache(of:onlyIfExists:body:completion:)"
            case .m_cacheExists__for_querycompletion_completion: return ".cacheExists(for:completion:)"
            case .m_cacheExists__of_fragmentcompletion_completion: return ".cacheExists(of:completion:)"
            case .m_clearCache__completion_completion: return ".clearCache(completion:)"
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

        public static func createCache<Query>(for query: Parameter<Query>, data: Parameter<Query.Data>, completion: Parameter<(Result<Void, GQLError.CacheError>) -> Void>) -> Verify where Query:GQLQuery { return Verify(method: .m_createCache__for_querydata_datacompletion_completion(`query`.wrapAsGeneric(), `data`.wrapAsGeneric(), `completion`))}
        public static func updateCache<Query>(for query: Parameter<Query>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Query.Data) throws -> Void>, completion: Parameter<(Result<Void, GQLError.CacheError>) -> Void>) -> Verify where Query:GQLQuery { return Verify(method: .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion(`query`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric(), `completion`))}
        public static func updateCache<Fragment>(of fragment: Parameter<Fragment>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Fragment) throws -> Void>, completion: Parameter<(Result<Void, GQLError.CacheError>) -> Void>) -> Verify where Fragment:GQLFragment { return Verify(method: .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion(`fragment`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric(), `completion`))}
        public static func cacheExists<Query>(for query: Parameter<Query>, completion: Parameter<(Result<Bool, GQLError.CacheError>) -> Void>) -> Verify where Query:GQLQuery { return Verify(method: .m_cacheExists__for_querycompletion_completion(`query`.wrapAsGeneric(), `completion`))}
        public static func cacheExists<Fragment>(of fragment: Parameter<Fragment>, completion: Parameter<(Result<Bool, GQLError.CacheError>) -> Void>) -> Verify where Fragment:GQLFragment { return Verify(method: .m_cacheExists__of_fragmentcompletion_completion(`fragment`.wrapAsGeneric(), `completion`))}
        public static func clearCache(completion: Parameter<(Result<Void, GQLError.CacheError>) -> Void>) -> Verify { return Verify(method: .m_clearCache__completion_completion(`completion`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createCache<Query>(for query: Parameter<Query>, data: Parameter<Query.Data>, completion: Parameter<(Result<Void, GQLError.CacheError>) -> Void>, perform: @escaping (Query, Query.Data, @escaping (Result<Void, GQLError.CacheError>) -> Void) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_createCache__for_querydata_datacompletion_completion(`query`.wrapAsGeneric(), `data`.wrapAsGeneric(), `completion`), performs: perform)
        }
        public static func updateCache<Query>(for query: Parameter<Query>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Query.Data) throws -> Void>, completion: Parameter<(Result<Void, GQLError.CacheError>) -> Void>, perform: @escaping (Query, Bool, @escaping (inout Query.Data) throws -> Void, @escaping (Result<Void, GQLError.CacheError>) -> Void) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_updateCache__for_queryonlyIfExists_onlyIfExistsbody_bodycompletion_completion(`query`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric(), `completion`), performs: perform)
        }
        public static func updateCache<Fragment>(of fragment: Parameter<Fragment>, onlyIfExists: Parameter<Bool>, body: Parameter<(inout Fragment) throws -> Void>, completion: Parameter<(Result<Void, GQLError.CacheError>) -> Void>, perform: @escaping (Fragment, Bool, @escaping (inout Fragment) throws -> Void, @escaping (Result<Void, GQLError.CacheError>) -> Void) -> Void) -> Perform where Fragment:GQLFragment {
            return Perform(method: .m_updateCache__of_fragmentonlyIfExists_onlyIfExistsbody_bodycompletion_completion(`fragment`.wrapAsGeneric(), `onlyIfExists`, `body`.wrapAsGeneric(), `completion`), performs: perform)
        }
        public static func cacheExists<Query>(for query: Parameter<Query>, completion: Parameter<(Result<Bool, GQLError.CacheError>) -> Void>, perform: @escaping (Query, @escaping (Result<Bool, GQLError.CacheError>) -> Void) -> Void) -> Perform where Query:GQLQuery {
            return Perform(method: .m_cacheExists__for_querycompletion_completion(`query`.wrapAsGeneric(), `completion`), performs: perform)
        }
        public static func cacheExists<Fragment>(of fragment: Parameter<Fragment>, completion: Parameter<(Result<Bool, GQLError.CacheError>) -> Void>, perform: @escaping (Fragment, @escaping (Result<Bool, GQLError.CacheError>) -> Void) -> Void) -> Perform where Fragment:GQLFragment {
            return Perform(method: .m_cacheExists__of_fragmentcompletion_completion(`fragment`.wrapAsGeneric(), `completion`), performs: perform)
        }
        public static func clearCache(completion: Parameter<(Result<Void, GQLError.CacheError>) -> Void>, perform: @escaping (@escaping (Result<Void, GQLError.CacheError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_clearCache__completion_completion(`completion`), performs: perform)
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

