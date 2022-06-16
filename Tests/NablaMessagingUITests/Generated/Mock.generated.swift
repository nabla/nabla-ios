// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import NablaMessagingCore
@testable import NablaMessagingUI


// MARK: - AudioRecorderComposerPresenter

open class AudioRecorderComposerPresenterMock: AudioRecorderComposerPresenter, Mock {
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





    open func userDidRequestStartRecording() {
        addInvocation(.m_userDidRequestStartRecording)
		let perform = methodPerformValue(.m_userDidRequestStartRecording) as? () -> Void
		perform?()
    }

    open func userDidRequestStopRecording() {
        addInvocation(.m_userDidRequestStopRecording)
		let perform = methodPerformValue(.m_userDidRequestStopRecording) as? () -> Void
		perform?()
    }

    open func userDidRequestCancelRecording() {
        addInvocation(.m_userDidRequestCancelRecording)
		let perform = methodPerformValue(.m_userDidRequestCancelRecording) as? () -> Void
		perform?()
    }

    open func start() {
        addInvocation(.m_start)
		let perform = methodPerformValue(.m_start) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_userDidRequestStartRecording
        case m_userDidRequestStopRecording
        case m_userDidRequestCancelRecording
        case m_start

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidRequestStartRecording, .m_userDidRequestStartRecording): return .match

            case (.m_userDidRequestStopRecording, .m_userDidRequestStopRecording): return .match

            case (.m_userDidRequestCancelRecording, .m_userDidRequestCancelRecording): return .match

            case (.m_start, .m_start): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidRequestStartRecording: return 0
            case .m_userDidRequestStopRecording: return 0
            case .m_userDidRequestCancelRecording: return 0
            case .m_start: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidRequestStartRecording: return ".userDidRequestStartRecording()"
            case .m_userDidRequestStopRecording: return ".userDidRequestStopRecording()"
            case .m_userDidRequestCancelRecording: return ".userDidRequestCancelRecording()"
            case .m_start: return ".start()"
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

        public static func userDidRequestStartRecording() -> Verify { return Verify(method: .m_userDidRequestStartRecording)}
        public static func userDidRequestStopRecording() -> Verify { return Verify(method: .m_userDidRequestStopRecording)}
        public static func userDidRequestCancelRecording() -> Verify { return Verify(method: .m_userDidRequestCancelRecording)}
        public static func start() -> Verify { return Verify(method: .m_start)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func userDidRequestStartRecording(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidRequestStartRecording, performs: perform)
        }
        public static func userDidRequestStopRecording(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidRequestStopRecording, performs: perform)
        }
        public static func userDidRequestCancelRecording(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidRequestCancelRecording, performs: perform)
        }
        public static func start(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_start, performs: perform)
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

// MARK: - ConversationPresenter

open class ConversationPresenterMock: ConversationPresenter, Mock {
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





    open func didTapOnSend(text: String, medias: [Media], replyingToMessageUUID replyToUUID: UUID?) {
        addInvocation(.m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID(Parameter<String>.value(`text`), Parameter<[Media]>.value(`medias`), Parameter<UUID?>.value(`replyToUUID`)))
		let perform = methodPerformValue(.m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID(Parameter<String>.value(`text`), Parameter<[Media]>.value(`medias`), Parameter<UUID?>.value(`replyToUUID`))) as? (String, [Media], UUID?) -> Void
		perform?(`text`, `medias`, `replyToUUID`)
    }

    open func didUpdateDraftText(_ text: String) {
        addInvocation(.m_didUpdateDraftText__text(Parameter<String>.value(`text`)))
		let perform = methodPerformValue(.m_didUpdateDraftText__text(Parameter<String>.value(`text`))) as? (String) -> Void
		perform?(`text`)
    }

    open func didFinishRecordingAudioFile(_ file: AudioFile, replyingToMessageUUID replyToUUID: UUID?) {
        addInvocation(.m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID(Parameter<AudioFile>.value(`file`), Parameter<UUID?>.value(`replyToUUID`)))
		let perform = methodPerformValue(.m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID(Parameter<AudioFile>.value(`file`), Parameter<UUID?>.value(`replyToUUID`))) as? (AudioFile, UUID?) -> Void
		perform?(`file`, `replyToUUID`)
    }

    open func didTapDeleteMessageButton(withId messageId: UUID) {
        addInvocation(.m_didTapDeleteMessageButton__withId_messageId(Parameter<UUID>.value(`messageId`)))
		let perform = methodPerformValue(.m_didTapDeleteMessageButton__withId_messageId(Parameter<UUID>.value(`messageId`))) as? (UUID) -> Void
		perform?(`messageId`)
    }

    open func didTapMedia(_ media: Media) {
        addInvocation(.m_didTapMedia__media(Parameter<Media>.value(`media`)))
		let perform = methodPerformValue(.m_didTapMedia__media(Parameter<Media>.value(`media`))) as? (Media) -> Void
		perform?(`media`)
    }

    open func didTapTextItem(withId: UUID) {
        addInvocation(.m_didTapTextItem__withId_withId(Parameter<UUID>.value(`withId`)))
		let perform = methodPerformValue(.m_didTapTextItem__withId_withId(Parameter<UUID>.value(`withId`))) as? (UUID) -> Void
		perform?(`withId`)
    }

    open func didReplyToMessage(withId: UUID) {
        addInvocation(.m_didReplyToMessage__withId_withId(Parameter<UUID>.value(`withId`)))
		let perform = methodPerformValue(.m_didReplyToMessage__withId_withId(Parameter<UUID>.value(`withId`))) as? (UUID) -> Void
		perform?(`withId`)
    }

    open func didTapMessagePreview(withId: UUID) {
        addInvocation(.m_didTapMessagePreview__withId_withId(Parameter<UUID>.value(`withId`)))
		let perform = methodPerformValue(.m_didTapMessagePreview__withId_withId(Parameter<UUID>.value(`withId`))) as? (UUID) -> Void
		perform?(`withId`)
    }

    open func didTapCameraButton() {
        addInvocation(.m_didTapCameraButton)
		let perform = methodPerformValue(.m_didTapCameraButton) as? () -> Void
		perform?()
    }

    open func didTapPhotoLibraryButton() {
        addInvocation(.m_didTapPhotoLibraryButton)
		let perform = methodPerformValue(.m_didTapPhotoLibraryButton) as? () -> Void
		perform?()
    }

    @available(iOS 14, *)
	open func didTapDocumentLibraryButton() {
        addInvocation(.m_didTapDocumentLibraryButton)
		let perform = methodPerformValue(.m_didTapDocumentLibraryButton) as? () -> Void
		perform?()
    }

    open func didReachEndOfConversation() {
        addInvocation(.m_didReachEndOfConversation)
		let perform = methodPerformValue(.m_didReachEndOfConversation) as? () -> Void
		perform?()
    }

    open func retry() {
        addInvocation(.m_retry)
		let perform = methodPerformValue(.m_retry) as? () -> Void
		perform?()
    }

    open func start() {
        addInvocation(.m_start)
		let perform = methodPerformValue(.m_start) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID(Parameter<String>, Parameter<[Media]>, Parameter<UUID?>)
        case m_didUpdateDraftText__text(Parameter<String>)
        case m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID(Parameter<AudioFile>, Parameter<UUID?>)
        case m_didTapDeleteMessageButton__withId_messageId(Parameter<UUID>)
        case m_didTapMedia__media(Parameter<Media>)
        case m_didTapTextItem__withId_withId(Parameter<UUID>)
        case m_didReplyToMessage__withId_withId(Parameter<UUID>)
        case m_didTapMessagePreview__withId_withId(Parameter<UUID>)
        case m_didTapCameraButton
        case m_didTapPhotoLibraryButton
        case m_didTapDocumentLibraryButton
        case m_didReachEndOfConversation
        case m_retry
        case m_start

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID(let lhsText, let lhsMedias, let lhsReplytouuid), .m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID(let rhsText, let rhsMedias, let rhsReplytouuid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher), lhsText, rhsText, "text"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMedias, rhs: rhsMedias, with: matcher), lhsMedias, rhsMedias, "medias"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsReplytouuid, rhs: rhsReplytouuid, with: matcher), lhsReplytouuid, rhsReplytouuid, "replyingToMessageUUID replyToUUID"))
				return Matcher.ComparisonResult(results)

            case (.m_didUpdateDraftText__text(let lhsText), .m_didUpdateDraftText__text(let rhsText)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsText, rhs: rhsText, with: matcher), lhsText, rhsText, "_ text"))
				return Matcher.ComparisonResult(results)

            case (.m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID(let lhsFile, let lhsReplytouuid), .m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID(let rhsFile, let rhsReplytouuid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsFile, rhs: rhsFile, with: matcher), lhsFile, rhsFile, "_ file"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsReplytouuid, rhs: rhsReplytouuid, with: matcher), lhsReplytouuid, rhsReplytouuid, "replyingToMessageUUID replyToUUID"))
				return Matcher.ComparisonResult(results)

            case (.m_didTapDeleteMessageButton__withId_messageId(let lhsMessageid), .m_didTapDeleteMessageButton__withId_messageId(let rhsMessageid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessageid, rhs: rhsMessageid, with: matcher), lhsMessageid, rhsMessageid, "withId messageId"))
				return Matcher.ComparisonResult(results)

            case (.m_didTapMedia__media(let lhsMedia), .m_didTapMedia__media(let rhsMedia)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMedia, rhs: rhsMedia, with: matcher), lhsMedia, rhsMedia, "_ media"))
				return Matcher.ComparisonResult(results)

            case (.m_didTapTextItem__withId_withId(let lhsWithid), .m_didTapTextItem__withId_withId(let rhsWithid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsWithid, rhs: rhsWithid, with: matcher), lhsWithid, rhsWithid, "withId"))
				return Matcher.ComparisonResult(results)

            case (.m_didReplyToMessage__withId_withId(let lhsWithid), .m_didReplyToMessage__withId_withId(let rhsWithid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsWithid, rhs: rhsWithid, with: matcher), lhsWithid, rhsWithid, "withId"))
				return Matcher.ComparisonResult(results)

            case (.m_didTapMessagePreview__withId_withId(let lhsWithid), .m_didTapMessagePreview__withId_withId(let rhsWithid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsWithid, rhs: rhsWithid, with: matcher), lhsWithid, rhsWithid, "withId"))
				return Matcher.ComparisonResult(results)

            case (.m_didTapCameraButton, .m_didTapCameraButton): return .match

            case (.m_didTapPhotoLibraryButton, .m_didTapPhotoLibraryButton): return .match

            case (.m_didTapDocumentLibraryButton, .m_didTapDocumentLibraryButton): return .match

            case (.m_didReachEndOfConversation, .m_didReachEndOfConversation): return .match

            case (.m_retry, .m_retry): return .match

            case (.m_start, .m_start): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_didUpdateDraftText__text(p0): return p0.intValue
            case let .m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID(p0, p1): return p0.intValue + p1.intValue
            case let .m_didTapDeleteMessageButton__withId_messageId(p0): return p0.intValue
            case let .m_didTapMedia__media(p0): return p0.intValue
            case let .m_didTapTextItem__withId_withId(p0): return p0.intValue
            case let .m_didReplyToMessage__withId_withId(p0): return p0.intValue
            case let .m_didTapMessagePreview__withId_withId(p0): return p0.intValue
            case .m_didTapCameraButton: return 0
            case .m_didTapPhotoLibraryButton: return 0
            case .m_didTapDocumentLibraryButton: return 0
            case .m_didReachEndOfConversation: return 0
            case .m_retry: return 0
            case .m_start: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID: return ".didTapOnSend(text:medias:replyingToMessageUUID:)"
            case .m_didUpdateDraftText__text: return ".didUpdateDraftText(_:)"
            case .m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID: return ".didFinishRecordingAudioFile(_:replyingToMessageUUID:)"
            case .m_didTapDeleteMessageButton__withId_messageId: return ".didTapDeleteMessageButton(withId:)"
            case .m_didTapMedia__media: return ".didTapMedia(_:)"
            case .m_didTapTextItem__withId_withId: return ".didTapTextItem(withId:)"
            case .m_didReplyToMessage__withId_withId: return ".didReplyToMessage(withId:)"
            case .m_didTapMessagePreview__withId_withId: return ".didTapMessagePreview(withId:)"
            case .m_didTapCameraButton: return ".didTapCameraButton()"
            case .m_didTapPhotoLibraryButton: return ".didTapPhotoLibraryButton()"
            case .m_didTapDocumentLibraryButton: return ".didTapDocumentLibraryButton()"
            case .m_didReachEndOfConversation: return ".didReachEndOfConversation()"
            case .m_retry: return ".retry()"
            case .m_start: return ".start()"
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

        public static func didTapOnSend(text: Parameter<String>, medias: Parameter<[Media]>, replyingToMessageUUID replyToUUID: Parameter<UUID?>) -> Verify { return Verify(method: .m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID(`text`, `medias`, `replyToUUID`))}
        public static func didUpdateDraftText(_ text: Parameter<String>) -> Verify { return Verify(method: .m_didUpdateDraftText__text(`text`))}
        public static func didFinishRecordingAudioFile(_ file: Parameter<AudioFile>, replyingToMessageUUID replyToUUID: Parameter<UUID?>) -> Verify { return Verify(method: .m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID(`file`, `replyToUUID`))}
        public static func didTapDeleteMessageButton(withId messageId: Parameter<UUID>) -> Verify { return Verify(method: .m_didTapDeleteMessageButton__withId_messageId(`messageId`))}
        public static func didTapMedia(_ media: Parameter<Media>) -> Verify { return Verify(method: .m_didTapMedia__media(`media`))}
        public static func didTapTextItem(withId: Parameter<UUID>) -> Verify { return Verify(method: .m_didTapTextItem__withId_withId(`withId`))}
        public static func didReplyToMessage(withId: Parameter<UUID>) -> Verify { return Verify(method: .m_didReplyToMessage__withId_withId(`withId`))}
        public static func didTapMessagePreview(withId: Parameter<UUID>) -> Verify { return Verify(method: .m_didTapMessagePreview__withId_withId(`withId`))}
        public static func didTapCameraButton() -> Verify { return Verify(method: .m_didTapCameraButton)}
        public static func didTapPhotoLibraryButton() -> Verify { return Verify(method: .m_didTapPhotoLibraryButton)}
        @available(iOS 14, *)
		public static func didTapDocumentLibraryButton() -> Verify { return Verify(method: .m_didTapDocumentLibraryButton)}
        public static func didReachEndOfConversation() -> Verify { return Verify(method: .m_didReachEndOfConversation)}
        public static func retry() -> Verify { return Verify(method: .m_retry)}
        public static func start() -> Verify { return Verify(method: .m_start)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func didTapOnSend(text: Parameter<String>, medias: Parameter<[Media]>, replyingToMessageUUID replyToUUID: Parameter<UUID?>, perform: @escaping (String, [Media], UUID?) -> Void) -> Perform {
            return Perform(method: .m_didTapOnSend__text_textmedias_mediasreplyingToMessageUUID_replyToUUID(`text`, `medias`, `replyToUUID`), performs: perform)
        }
        public static func didUpdateDraftText(_ text: Parameter<String>, perform: @escaping (String) -> Void) -> Perform {
            return Perform(method: .m_didUpdateDraftText__text(`text`), performs: perform)
        }
        public static func didFinishRecordingAudioFile(_ file: Parameter<AudioFile>, replyingToMessageUUID replyToUUID: Parameter<UUID?>, perform: @escaping (AudioFile, UUID?) -> Void) -> Perform {
            return Perform(method: .m_didFinishRecordingAudioFile__filereplyingToMessageUUID_replyToUUID(`file`, `replyToUUID`), performs: perform)
        }
        public static func didTapDeleteMessageButton(withId messageId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_didTapDeleteMessageButton__withId_messageId(`messageId`), performs: perform)
        }
        public static func didTapMedia(_ media: Parameter<Media>, perform: @escaping (Media) -> Void) -> Perform {
            return Perform(method: .m_didTapMedia__media(`media`), performs: perform)
        }
        public static func didTapTextItem(withId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_didTapTextItem__withId_withId(`withId`), performs: perform)
        }
        public static func didReplyToMessage(withId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_didReplyToMessage__withId_withId(`withId`), performs: perform)
        }
        public static func didTapMessagePreview(withId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_didTapMessagePreview__withId_withId(`withId`), performs: perform)
        }
        public static func didTapCameraButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_didTapCameraButton, performs: perform)
        }
        public static func didTapPhotoLibraryButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_didTapPhotoLibraryButton, performs: perform)
        }
        @available(iOS 14, *)
		public static func didTapDocumentLibraryButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_didTapDocumentLibraryButton, performs: perform)
        }
        public static func didReachEndOfConversation(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_didReachEndOfConversation, performs: perform)
        }
        public static func retry(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_retry, performs: perform)
        }
        public static func start(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_start, performs: perform)
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

// MARK: - NablaMessagingClientProtocol

open class NablaMessagingClientProtocolMock: NablaMessagingClientProtocol, Mock {
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

    public var logger: Logger {
		get {	invocations.append(.p_logger_get); return __p_logger ?? givenGetterValue(.p_logger_get, "NablaMessagingClientProtocolMock - stub value for logger was not defined") }
	}
	private var __p_logger: (Logger)?





    open func createConversation(handler: @escaping (Result<Conversation, NablaError>) -> Void) -> Cancellable {
        addInvocation(.m_createConversation__handler_handler(Parameter<(Result<Conversation, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_createConversation__handler_handler(Parameter<(Result<Conversation, NablaError>) -> Void>.value(`handler`))) as? (@escaping (Result<Conversation, NablaError>) -> Void) -> Void
		perform?(`handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_createConversation__handler_handler(Parameter<(Result<Conversation, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createConversation(handler: @escaping (Result<Conversation, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for createConversation(handler: @escaping (Result<Conversation, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func watchItems(ofConversationWithId conversationId: UUID, handler: @escaping (Result<ConversationItems, NablaError>) -> Void) -> PaginatedWatcher {
        addInvocation(.m_watchItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<ConversationItems, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_watchItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<ConversationItems, NablaError>) -> Void>.value(`handler`))) as? (UUID, @escaping (Result<ConversationItems, NablaError>) -> Void) -> Void
		perform?(`conversationId`, `handler`)
		var __value: PaginatedWatcher
		do {
		    __value = try methodReturnValue(.m_watchItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<ConversationItems, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchItems(ofConversationWithId conversationId: UUID, handler: @escaping (Result<ConversationItems, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for watchItems(ofConversationWithId conversationId: UUID, handler: @escaping (Result<ConversationItems, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func setIsTyping(_ isTyping: Bool, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        addInvocation(.m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))) as? (Bool, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void
		perform?(`isTyping`, `conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for setIsTyping(_ isTyping: Bool, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for setIsTyping(_ isTyping: Bool, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func markConversationAsSeen(_ conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        addInvocation(.m_markConversationAsSeen__conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_markConversationAsSeen__conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))) as? (UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void
		perform?(`conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_markConversationAsSeen__conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for markConversationAsSeen(_ conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for markConversationAsSeen(_ conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func watchConversations(handler: @escaping (Result<ConversationList, NablaError>) -> Void) -> PaginatedWatcher {
        addInvocation(.m_watchConversations__handler_handler(Parameter<(Result<ConversationList, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_watchConversations__handler_handler(Parameter<(Result<ConversationList, NablaError>) -> Void>.value(`handler`))) as? (@escaping (Result<ConversationList, NablaError>) -> Void) -> Void
		perform?(`handler`)
		var __value: PaginatedWatcher
		do {
		    __value = try methodReturnValue(.m_watchConversations__handler_handler(Parameter<(Result<ConversationList, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversations(handler: @escaping (Result<ConversationList, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for watchConversations(handler: @escaping (Result<ConversationList, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func watchConversation(_ conversationId: UUID, handler: @escaping (Result<Conversation, NablaError>) -> Void) -> Cancellable {
        addInvocation(.m_watchConversation__conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<Conversation, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_watchConversation__conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<Conversation, NablaError>) -> Void>.value(`handler`))) as? (UUID, @escaping (Result<Conversation, NablaError>) -> Void) -> Void
		perform?(`conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_watchConversation__conversationIdhandler_handler(Parameter<UUID>.value(`conversationId`), Parameter<(Result<Conversation, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversation(_ conversationId: UUID, handler: @escaping (Result<Conversation, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for watchConversation(_ conversationId: UUID, handler: @escaping (Result<Conversation, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func sendMessage(_ message: MessageInput, replyingToMessageWithId: UUID?, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        addInvocation(.m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyingToMessageWithId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyingToMessageWithId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))) as? (MessageInput, UUID?, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void
		perform?(`message`, `replyingToMessageWithId`, `conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyingToMessageWithId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for sendMessage(_ message: MessageInput, replyingToMessageWithId: UUID?, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for sendMessage(_ message: MessageInput, replyingToMessageWithId: UUID?, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func retrySending(itemWithId itemId: UUID, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        addInvocation(.m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`itemId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`itemId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))) as? (UUID, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void
		perform?(`itemId`, `conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(Parameter<UUID>.value(`itemId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for retrySending(itemWithId itemId: UUID, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for retrySending(itemWithId itemId: UUID, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func deleteMessage(withId messageId: UUID, conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        addInvocation(.m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(Parameter<UUID>.value(`messageId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(Parameter<UUID>.value(`messageId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))) as? (UUID, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void
		perform?(`messageId`, `conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(Parameter<UUID>.value(`messageId`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for deleteMessage(withId messageId: UUID, conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for deleteMessage(withId messageId: UUID, conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
		}
		return __value
    }

    open func sendMessage(_ message: MessageInput, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void) -> Cancellable {
        addInvocation(.m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(Parameter<MessageInput>.value(`message`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`)))
		let perform = methodPerformValue(.m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(Parameter<MessageInput>.value(`message`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))) as? (MessageInput, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void
		perform?(`message`, `conversationId`, `handler`)
		var __value: Cancellable
		do {
		    __value = try methodReturnValue(.m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(Parameter<MessageInput>.value(`message`), Parameter<UUID>.value(`conversationId`), Parameter<(Result<Void, NablaError>) -> Void>.value(`handler`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for sendMessage(_ message: MessageInput, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
			Failure("Stub return value not specified for sendMessage(_ message: MessageInput, inConversationWithId conversationId: UUID, handler: @escaping (Result<Void, NablaError>) -> Void). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_createConversation__handler_handler(Parameter<(Result<Conversation, NablaError>) -> Void>)
        case m_watchItems__ofConversationWithId_conversationIdhandler_handler(Parameter<UUID>, Parameter<(Result<ConversationItems, NablaError>) -> Void>)
        case m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(Parameter<Bool>, Parameter<UUID>, Parameter<(Result<Void, NablaError>) -> Void>)
        case m_markConversationAsSeen__conversationIdhandler_handler(Parameter<UUID>, Parameter<(Result<Void, NablaError>) -> Void>)
        case m_watchConversations__handler_handler(Parameter<(Result<ConversationList, NablaError>) -> Void>)
        case m_watchConversation__conversationIdhandler_handler(Parameter<UUID>, Parameter<(Result<Conversation, NablaError>) -> Void>)
        case m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(Parameter<MessageInput>, Parameter<UUID?>, Parameter<UUID>, Parameter<(Result<Void, NablaError>) -> Void>)
        case m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(Parameter<UUID>, Parameter<UUID>, Parameter<(Result<Void, NablaError>) -> Void>)
        case m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(Parameter<UUID>, Parameter<UUID>, Parameter<(Result<Void, NablaError>) -> Void>)
        case m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(Parameter<MessageInput>, Parameter<UUID>, Parameter<(Result<Void, NablaError>) -> Void>)
        case p_logger_get

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createConversation__handler_handler(let lhsHandler), .m_createConversation__handler_handler(let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_watchItems__ofConversationWithId_conversationIdhandler_handler(let lhsConversationid, let lhsHandler), .m_watchItems__ofConversationWithId_conversationIdhandler_handler(let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(let lhsIstyping, let lhsConversationid, let lhsHandler), .m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(let rhsIstyping, let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIstyping, rhs: rhsIstyping, with: matcher), lhsIstyping, rhsIstyping, "_ isTyping"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_markConversationAsSeen__conversationIdhandler_handler(let lhsConversationid, let lhsHandler), .m_markConversationAsSeen__conversationIdhandler_handler(let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "_ conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversations__handler_handler(let lhsHandler), .m_watchConversations__handler_handler(let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversation__conversationIdhandler_handler(let lhsConversationid, let lhsHandler), .m_watchConversation__conversationIdhandler_handler(let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "_ conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(let lhsMessage, let lhsReplyingtomessagewithid, let lhsConversationid, let lhsHandler), .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(let rhsMessage, let rhsReplyingtomessagewithid, let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "_ message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsReplyingtomessagewithid, rhs: rhsReplyingtomessagewithid, with: matcher), lhsReplyingtomessagewithid, rhsReplyingtomessagewithid, "replyingToMessageWithId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(let lhsItemid, let lhsConversationid, let lhsHandler), .m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(let rhsItemid, let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsItemid, rhs: rhsItemid, with: matcher), lhsItemid, rhsItemid, "itemWithId itemId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(let lhsMessageid, let lhsConversationid, let lhsHandler), .m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(let rhsMessageid, let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessageid, rhs: rhsMessageid, with: matcher), lhsMessageid, rhsMessageid, "withId messageId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)

            case (.m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(let lhsMessage, let lhsConversationid, let lhsHandler), .m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(let rhsMessage, let rhsConversationid, let rhsHandler)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "_ message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsHandler, rhs: rhsHandler, with: matcher), lhsHandler, rhsHandler, "handler"))
				return Matcher.ComparisonResult(results)
            case (.p_logger_get,.p_logger_get): return Matcher.ComparisonResult.match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_createConversation__handler_handler(p0): return p0.intValue
            case let .m_watchItems__ofConversationWithId_conversationIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_markConversationAsSeen__conversationIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_watchConversations__handler_handler(p0): return p0.intValue
            case let .m_watchConversation__conversationIdhandler_handler(p0, p1): return p0.intValue + p1.intValue
            case let .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(p0, p1, p2, p3): return p0.intValue + p1.intValue + p2.intValue + p3.intValue
            case let .m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case .p_logger_get: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createConversation__handler_handler: return ".createConversation(handler:)"
            case .m_watchItems__ofConversationWithId_conversationIdhandler_handler: return ".watchItems(ofConversationWithId:handler:)"
            case .m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler: return ".setIsTyping(_:inConversationWithId:handler:)"
            case .m_markConversationAsSeen__conversationIdhandler_handler: return ".markConversationAsSeen(_:handler:)"
            case .m_watchConversations__handler_handler: return ".watchConversations(handler:)"
            case .m_watchConversation__conversationIdhandler_handler: return ".watchConversation(_:handler:)"
            case .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler: return ".sendMessage(_:replyingToMessageWithId:inConversationWithId:handler:)"
            case .m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler: return ".retrySending(itemWithId:inConversationWithId:handler:)"
            case .m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler: return ".deleteMessage(withId:conversationId:handler:)"
            case .m_sendMessage__messageinConversationWithId_conversationIdhandler_handler: return ".sendMessage(_:inConversationWithId:handler:)"
            case .p_logger_get: return "[get] .logger"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }

        public static func logger(getter defaultValue: Logger...) -> PropertyStub {
            return Given(method: .p_logger_get, products: defaultValue.map({ StubProduct.return($0 as Any) }))
        }

        public static func createConversation(handler: Parameter<(Result<Conversation, NablaError>) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_createConversation__handler_handler(`handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<ConversationItems, NablaError>) -> Void>, willReturn: PaginatedWatcher...) -> MethodStub {
            return Given(method: .m_watchItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(`isTyping`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func markConversationAsSeen(_ conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_markConversationAsSeen__conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversations(handler: Parameter<(Result<ConversationList, NablaError>) -> Void>, willReturn: PaginatedWatcher...) -> MethodStub {
            return Given(method: .m_watchConversations__handler_handler(`handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, handler: Parameter<(Result<Conversation, NablaError>) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_watchConversation__conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyingToMessageWithId: Parameter<UUID?>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(`message`, `replyingToMessageWithId`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(`itemId`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(`messageId`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willReturn: Cancellable...) -> MethodStub {
            return Given(method: .m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(`message`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createConversation(handler: Parameter<(Result<Conversation, NablaError>) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_createConversation__handler_handler(`handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func watchItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<ConversationItems, NablaError>) -> Void>, willProduce: (Stubber<PaginatedWatcher>) -> Void) -> MethodStub {
            let willReturn: [PaginatedWatcher] = []
			let given: Given = { return Given(method: .m_watchItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (PaginatedWatcher).self)
			willProduce(stubber)
			return given
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(`isTyping`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func markConversationAsSeen(_ conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_markConversationAsSeen__conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func watchConversations(handler: Parameter<(Result<ConversationList, NablaError>) -> Void>, willProduce: (Stubber<PaginatedWatcher>) -> Void) -> MethodStub {
            let willReturn: [PaginatedWatcher] = []
			let given: Given = { return Given(method: .m_watchConversations__handler_handler(`handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (PaginatedWatcher).self)
			willProduce(stubber)
			return given
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, handler: Parameter<(Result<Conversation, NablaError>) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_watchConversation__conversationIdhandler_handler(`conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyingToMessageWithId: Parameter<UUID?>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(`message`, `replyingToMessageWithId`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(`itemId`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(`messageId`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, willProduce: (Stubber<Cancellable>) -> Void) -> MethodStub {
            let willReturn: [Cancellable] = []
			let given: Given = { return Given(method: .m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(`message`, `conversationId`, `handler`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Cancellable).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createConversation(handler: Parameter<(Result<Conversation, NablaError>) -> Void>) -> Verify { return Verify(method: .m_createConversation__handler_handler(`handler`))}
        public static func watchItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<ConversationItems, NablaError>) -> Void>) -> Verify { return Verify(method: .m_watchItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`))}
        public static func setIsTyping(_ isTyping: Parameter<Bool>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>) -> Verify { return Verify(method: .m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(`isTyping`, `conversationId`, `handler`))}
        public static func markConversationAsSeen(_ conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>) -> Verify { return Verify(method: .m_markConversationAsSeen__conversationIdhandler_handler(`conversationId`, `handler`))}
        public static func watchConversations(handler: Parameter<(Result<ConversationList, NablaError>) -> Void>) -> Verify { return Verify(method: .m_watchConversations__handler_handler(`handler`))}
        public static func watchConversation(_ conversationId: Parameter<UUID>, handler: Parameter<(Result<Conversation, NablaError>) -> Void>) -> Verify { return Verify(method: .m_watchConversation__conversationIdhandler_handler(`conversationId`, `handler`))}
        public static func sendMessage(_ message: Parameter<MessageInput>, replyingToMessageWithId: Parameter<UUID?>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>) -> Verify { return Verify(method: .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(`message`, `replyingToMessageWithId`, `conversationId`, `handler`))}
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>) -> Verify { return Verify(method: .m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(`itemId`, `conversationId`, `handler`))}
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>) -> Verify { return Verify(method: .m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(`messageId`, `conversationId`, `handler`))}
        public static func sendMessage(_ message: Parameter<MessageInput>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>) -> Verify { return Verify(method: .m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(`message`, `conversationId`, `handler`))}
        public static var logger: Verify { return Verify(method: .p_logger_get) }
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createConversation(handler: Parameter<(Result<Conversation, NablaError>) -> Void>, perform: @escaping (@escaping (Result<Conversation, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_createConversation__handler_handler(`handler`), performs: perform)
        }
        public static func watchItems(ofConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<ConversationItems, NablaError>) -> Void>, perform: @escaping (UUID, @escaping (Result<ConversationItems, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_watchItems__ofConversationWithId_conversationIdhandler_handler(`conversationId`, `handler`), performs: perform)
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, perform: @escaping (Bool, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_setIsTyping__isTypinginConversationWithId_conversationIdhandler_handler(`isTyping`, `conversationId`, `handler`), performs: perform)
        }
        public static func markConversationAsSeen(_ conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, perform: @escaping (UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_markConversationAsSeen__conversationIdhandler_handler(`conversationId`, `handler`), performs: perform)
        }
        public static func watchConversations(handler: Parameter<(Result<ConversationList, NablaError>) -> Void>, perform: @escaping (@escaping (Result<ConversationList, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_watchConversations__handler_handler(`handler`), performs: perform)
        }
        public static func watchConversation(_ conversationId: Parameter<UUID>, handler: Parameter<(Result<Conversation, NablaError>) -> Void>, perform: @escaping (UUID, @escaping (Result<Conversation, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_watchConversation__conversationIdhandler_handler(`conversationId`, `handler`), performs: perform)
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyingToMessageWithId: Parameter<UUID?>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, perform: @escaping (MessageInput, UUID?, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationIdhandler_handler(`message`, `replyingToMessageWithId`, `conversationId`, `handler`), performs: perform)
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, perform: @escaping (UUID, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_retrySending__itemWithId_itemIdinConversationWithId_conversationIdhandler_handler(`itemId`, `conversationId`, `handler`), performs: perform)
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, perform: @escaping (UUID, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_deleteMessage__withId_messageIdconversationId_conversationIdhandler_handler(`messageId`, `conversationId`, `handler`), performs: perform)
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, inConversationWithId conversationId: Parameter<UUID>, handler: Parameter<(Result<Void, NablaError>) -> Void>, perform: @escaping (MessageInput, UUID, @escaping (Result<Void, NablaError>) -> Void) -> Void) -> Perform {
            return Perform(method: .m_sendMessage__messageinConversationWithId_conversationIdhandler_handler(`message`, `conversationId`, `handler`), performs: perform)
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

