// Generated using Sourcery 1.8.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT


// Generated with SwiftyMocky 4.1.0
// Required Sourcery: 1.8.0


import SwiftyMocky
import XCTest
import NablaCore
import NablaMessagingCore
import Combine
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

    open func didTap(image: ImageFile) {
        addInvocation(.m_didTap__image_image(Parameter<ImageFile>.value(`image`)))
		let perform = methodPerformValue(.m_didTap__image_image(Parameter<ImageFile>.value(`image`))) as? (ImageFile) -> Void
		perform?(`image`)
    }

    open func didTap(document: DocumentFile) {
        addInvocation(.m_didTap__document_document(Parameter<DocumentFile>.value(`document`)))
		let perform = methodPerformValue(.m_didTap__document_document(Parameter<DocumentFile>.value(`document`))) as? (DocumentFile) -> Void
		perform?(`document`)
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

    open func didTapJoinVideoCall(url: String, token: String) {
        addInvocation(.m_didTapJoinVideoCall__url_urltoken_token(Parameter<String>.value(`url`), Parameter<String>.value(`token`)))
		let perform = methodPerformValue(.m_didTapJoinVideoCall__url_urltoken_token(Parameter<String>.value(`url`), Parameter<String>.value(`token`))) as? (String, String) -> Void
		perform?(`url`, `token`)
    }

    open func didTapScanDocumentButton() {
        addInvocation(.m_didTapScanDocumentButton)
		let perform = methodPerformValue(.m_didTapScanDocumentButton) as? () -> Void
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
        case m_didTap__image_image(Parameter<ImageFile>)
        case m_didTap__document_document(Parameter<DocumentFile>)
        case m_didTapTextItem__withId_withId(Parameter<UUID>)
        case m_didReplyToMessage__withId_withId(Parameter<UUID>)
        case m_didTapMessagePreview__withId_withId(Parameter<UUID>)
        case m_didTapCameraButton
        case m_didTapPhotoLibraryButton
        case m_didTapJoinVideoCall__url_urltoken_token(Parameter<String>, Parameter<String>)
        case m_didTapScanDocumentButton
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

            case (.m_didTap__image_image(let lhsImage), .m_didTap__image_image(let rhsImage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsImage, rhs: rhsImage, with: matcher), lhsImage, rhsImage, "image"))
				return Matcher.ComparisonResult(results)

            case (.m_didTap__document_document(let lhsDocument), .m_didTap__document_document(let rhsDocument)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsDocument, rhs: rhsDocument, with: matcher), lhsDocument, rhsDocument, "document"))
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

            case (.m_didTapJoinVideoCall__url_urltoken_token(let lhsUrl, let lhsToken), .m_didTapJoinVideoCall__url_urltoken_token(let rhsUrl, let rhsToken)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsUrl, rhs: rhsUrl, with: matcher), lhsUrl, rhsUrl, "url"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsToken, rhs: rhsToken, with: matcher), lhsToken, rhsToken, "token"))
				return Matcher.ComparisonResult(results)

            case (.m_didTapScanDocumentButton, .m_didTapScanDocumentButton): return .match

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
            case let .m_didTap__image_image(p0): return p0.intValue
            case let .m_didTap__document_document(p0): return p0.intValue
            case let .m_didTapTextItem__withId_withId(p0): return p0.intValue
            case let .m_didReplyToMessage__withId_withId(p0): return p0.intValue
            case let .m_didTapMessagePreview__withId_withId(p0): return p0.intValue
            case .m_didTapCameraButton: return 0
            case .m_didTapPhotoLibraryButton: return 0
            case let .m_didTapJoinVideoCall__url_urltoken_token(p0, p1): return p0.intValue + p1.intValue
            case .m_didTapScanDocumentButton: return 0
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
            case .m_didTap__image_image: return ".didTap(image:)"
            case .m_didTap__document_document: return ".didTap(document:)"
            case .m_didTapTextItem__withId_withId: return ".didTapTextItem(withId:)"
            case .m_didReplyToMessage__withId_withId: return ".didReplyToMessage(withId:)"
            case .m_didTapMessagePreview__withId_withId: return ".didTapMessagePreview(withId:)"
            case .m_didTapCameraButton: return ".didTapCameraButton()"
            case .m_didTapPhotoLibraryButton: return ".didTapPhotoLibraryButton()"
            case .m_didTapJoinVideoCall__url_urltoken_token: return ".didTapJoinVideoCall(url:token:)"
            case .m_didTapScanDocumentButton: return ".didTapScanDocumentButton()"
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
        public static func didTap(image: Parameter<ImageFile>) -> Verify { return Verify(method: .m_didTap__image_image(`image`))}
        public static func didTap(document: Parameter<DocumentFile>) -> Verify { return Verify(method: .m_didTap__document_document(`document`))}
        public static func didTapTextItem(withId: Parameter<UUID>) -> Verify { return Verify(method: .m_didTapTextItem__withId_withId(`withId`))}
        public static func didReplyToMessage(withId: Parameter<UUID>) -> Verify { return Verify(method: .m_didReplyToMessage__withId_withId(`withId`))}
        public static func didTapMessagePreview(withId: Parameter<UUID>) -> Verify { return Verify(method: .m_didTapMessagePreview__withId_withId(`withId`))}
        public static func didTapCameraButton() -> Verify { return Verify(method: .m_didTapCameraButton)}
        public static func didTapPhotoLibraryButton() -> Verify { return Verify(method: .m_didTapPhotoLibraryButton)}
        public static func didTapJoinVideoCall(url: Parameter<String>, token: Parameter<String>) -> Verify { return Verify(method: .m_didTapJoinVideoCall__url_urltoken_token(`url`, `token`))}
        public static func didTapScanDocumentButton() -> Verify { return Verify(method: .m_didTapScanDocumentButton)}
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
        public static func didTap(image: Parameter<ImageFile>, perform: @escaping (ImageFile) -> Void) -> Perform {
            return Perform(method: .m_didTap__image_image(`image`), performs: perform)
        }
        public static func didTap(document: Parameter<DocumentFile>, perform: @escaping (DocumentFile) -> Void) -> Perform {
            return Perform(method: .m_didTap__document_document(`document`), performs: perform)
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
        public static func didTapJoinVideoCall(url: Parameter<String>, token: Parameter<String>, perform: @escaping (String, String) -> Void) -> Perform {
            return Perform(method: .m_didTapJoinVideoCall__url_urltoken_token(`url`, `token`), performs: perform)
        }
        public static func didTapScanDocumentButton(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_didTapScanDocumentButton, performs: perform)
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

// MARK: - InboxPresenter

open class InboxPresenterMock: InboxPresenter, Mock {
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





    open func userDidTapCreateConversation() {
        addInvocation(.m_userDidTapCreateConversation)
		let perform = methodPerformValue(.m_userDidTapCreateConversation) as? () -> Void
		perform?()
    }

    open func userDidSelectConversation(_ conversation: Conversation) {
        addInvocation(.m_userDidSelectConversation__conversation(Parameter<Conversation>.value(`conversation`)))
		let perform = methodPerformValue(.m_userDidSelectConversation__conversation(Parameter<Conversation>.value(`conversation`))) as? (Conversation) -> Void
		perform?(`conversation`)
    }

    open func start() {
        addInvocation(.m_start)
		let perform = methodPerformValue(.m_start) as? () -> Void
		perform?()
    }


    fileprivate enum MethodType {
        case m_userDidTapCreateConversation
        case m_userDidSelectConversation__conversation(Parameter<Conversation>)
        case m_start

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_userDidTapCreateConversation, .m_userDidTapCreateConversation): return .match

            case (.m_userDidSelectConversation__conversation(let lhsConversation), .m_userDidSelectConversation__conversation(let rhsConversation)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversation, rhs: rhsConversation, with: matcher), lhsConversation, rhsConversation, "_ conversation"))
				return Matcher.ComparisonResult(results)

            case (.m_start, .m_start): return .match
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case .m_userDidTapCreateConversation: return 0
            case let .m_userDidSelectConversation__conversation(p0): return p0.intValue
            case .m_start: return 0
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_userDidTapCreateConversation: return ".userDidTapCreateConversation()"
            case .m_userDidSelectConversation__conversation: return ".userDidSelectConversation(_:)"
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

        public static func userDidTapCreateConversation() -> Verify { return Verify(method: .m_userDidTapCreateConversation)}
        public static func userDidSelectConversation(_ conversation: Parameter<Conversation>) -> Verify { return Verify(method: .m_userDidSelectConversation__conversation(`conversation`))}
        public static func start() -> Verify { return Verify(method: .m_start)}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func userDidTapCreateConversation(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_userDidTapCreateConversation, performs: perform)
        }
        public static func userDidSelectConversation(_ conversation: Parameter<Conversation>, perform: @escaping (Conversation) -> Void) -> Perform {
            return Perform(method: .m_userDidSelectConversation__conversation(`conversation`), performs: perform)
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





    open func createConversation(title: String?, providerIds: [UUID]?, initialMessage: MessageInput?) throws -> Conversation {
        addInvocation(.m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`), Parameter<MessageInput?>.value(`initialMessage`)))
		let perform = methodPerformValue(.m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`), Parameter<MessageInput?>.value(`initialMessage`))) as? (String?, [UUID]?, MessageInput?) -> Void
		perform?(`title`, `providerIds`, `initialMessage`)
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`), Parameter<MessageInput?>.value(`initialMessage`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for createConversation(title: String?, providerIds: [UUID]?, initialMessage: MessageInput?). Use given")
			Failure("Stub return value not specified for createConversation(title: String?, providerIds: [UUID]?, initialMessage: MessageInput?). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func createDraftConversation(title: String?, providerIds: [UUID]?) -> Conversation {
        addInvocation(.m_createDraftConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`)))
		let perform = methodPerformValue(.m_createDraftConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))) as? (String?, [UUID]?) -> Void
		perform?(`title`, `providerIds`)
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_createDraftConversation__title_titleproviderIds_providerIds(Parameter<String?>.value(`title`), Parameter<[UUID]?>.value(`providerIds`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createDraftConversation(title: String?, providerIds: [UUID]?). Use given")
			Failure("Stub return value not specified for createDraftConversation(title: String?, providerIds: [UUID]?). Use given")
		}
		return __value
    }

    open func watchItems(ofConversationWithId conversationId: UUID) -> AnyPublisher<PaginatedList<ConversationItem>, NablaError> {
        addInvocation(.m_watchItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_watchItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		var __value: AnyPublisher<PaginatedList<ConversationItem>, NablaError>
		do {
		    __value = try methodReturnValue(.m_watchItems__ofConversationWithId_conversationId(Parameter<UUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchItems(ofConversationWithId conversationId: UUID). Use given")
			Failure("Stub return value not specified for watchItems(ofConversationWithId conversationId: UUID). Use given")
		}
		return __value
    }

    open func setIsTyping(_ isTyping: Bool, inConversationWithId conversationId: UUID) throws {
        addInvocation(.m_setIsTyping__isTypinginConversationWithId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_setIsTyping__isTypinginConversationWithId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`))) as? (Bool, UUID) -> Void
		perform?(`isTyping`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_setIsTyping__isTypinginConversationWithId_conversationId(Parameter<Bool>.value(`isTyping`), Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func markConversationAsSeen(_ conversationId: UUID) throws {
        addInvocation(.m_markConversationAsSeen__conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_markConversationAsSeen__conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		do {
		    _ = try methodReturnValue(.m_markConversationAsSeen__conversationId(Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
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

    open func watchConversation(withId conversationId: UUID) -> AnyPublisher<Conversation, NablaError> {
        addInvocation(.m_watchConversation__withId_conversationId(Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_watchConversation__withId_conversationId(Parameter<UUID>.value(`conversationId`))) as? (UUID) -> Void
		perform?(`conversationId`)
		var __value: AnyPublisher<Conversation, NablaError>
		do {
		    __value = try methodReturnValue(.m_watchConversation__withId_conversationId(Parameter<UUID>.value(`conversationId`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for watchConversation(withId conversationId: UUID). Use given")
			Failure("Stub return value not specified for watchConversation(withId conversationId: UUID). Use given")
		}
		return __value
    }

    open func sendMessage(_ message: MessageInput, replyingToMessageWithId: UUID?, inConversationWithId conversationId: UUID) throws {
        addInvocation(.m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyingToMessageWithId`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyingToMessageWithId`), Parameter<UUID>.value(`conversationId`))) as? (MessageInput, UUID?, UUID) -> Void
		perform?(`message`, `replyingToMessageWithId`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(Parameter<MessageInput>.value(`message`), Parameter<UUID?>.value(`replyingToMessageWithId`), Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func retrySending(itemWithId itemId: UUID, inConversationWithId conversationId: UUID) throws {
        addInvocation(.m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(Parameter<UUID>.value(`itemId`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(Parameter<UUID>.value(`itemId`), Parameter<UUID>.value(`conversationId`))) as? (UUID, UUID) -> Void
		perform?(`itemId`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(Parameter<UUID>.value(`itemId`), Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func deleteMessage(withId messageId: UUID, conversationId: UUID) throws {
        addInvocation(.m_deleteMessage__withId_messageIdconversationId_conversationId(Parameter<UUID>.value(`messageId`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_deleteMessage__withId_messageIdconversationId_conversationId(Parameter<UUID>.value(`messageId`), Parameter<UUID>.value(`conversationId`))) as? (UUID, UUID) -> Void
		perform?(`messageId`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_deleteMessage__withId_messageIdconversationId_conversationId(Parameter<UUID>.value(`messageId`), Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func addRefetchTriggers(_ triggers: RefetchTrigger...) {
        addInvocation(.m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>.value(`triggers`)))
		let perform = methodPerformValue(.m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>.value(`triggers`))) as? ([RefetchTrigger]) -> Void
		perform?(`triggers`)
    }

    open func sendMessage(_ message: MessageInput, inConversationWithId conversationId: UUID) throws {
        addInvocation(.m_sendMessage__messageinConversationWithId_conversationId(Parameter<MessageInput>.value(`message`), Parameter<UUID>.value(`conversationId`)))
		let perform = methodPerformValue(.m_sendMessage__messageinConversationWithId_conversationId(Parameter<MessageInput>.value(`message`), Parameter<UUID>.value(`conversationId`))) as? (MessageInput, UUID) -> Void
		perform?(`message`, `conversationId`)
		do {
		    _ = try methodReturnValue(.m_sendMessage__messageinConversationWithId_conversationId(Parameter<MessageInput>.value(`message`), Parameter<UUID>.value(`conversationId`))).casted() as Void
		} catch MockError.notStubed {
			// do nothing
		} catch {
		    throw error
		}
    }

    open func createConversation(title: String?) throws -> Conversation {
        addInvocation(.m_createConversation__title_title(Parameter<String?>.value(`title`)))
		let perform = methodPerformValue(.m_createConversation__title_title(Parameter<String?>.value(`title`))) as? (String?) -> Void
		perform?(`title`)
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_createConversation__title_title(Parameter<String?>.value(`title`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for createConversation(title: String?). Use given")
			Failure("Stub return value not specified for createConversation(title: String?). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func createConversation(providerIds: [UUID]?) throws -> Conversation {
        addInvocation(.m_createConversation__providerIds_providerIds(Parameter<[UUID]?>.value(`providerIds`)))
		let perform = methodPerformValue(.m_createConversation__providerIds_providerIds(Parameter<[UUID]?>.value(`providerIds`))) as? ([UUID]?) -> Void
		perform?(`providerIds`)
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_createConversation__providerIds_providerIds(Parameter<[UUID]?>.value(`providerIds`))).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for createConversation(providerIds: [UUID]?). Use given")
			Failure("Stub return value not specified for createConversation(providerIds: [UUID]?). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func createConversation() throws -> Conversation {
        addInvocation(.m_createConversation)
		let perform = methodPerformValue(.m_createConversation) as? () -> Void
		perform?()
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_createConversation).casted()
		} catch MockError.notStubed {
			onFatalFailure("Stub return value not specified for createConversation(). Use given")
			Failure("Stub return value not specified for createConversation(). Use given")
		} catch {
		    throw error
		}
		return __value
    }

    open func createDraftConversation() -> Conversation {
        addInvocation(.m_createDraftConversation)
		let perform = methodPerformValue(.m_createDraftConversation) as? () -> Void
		perform?()
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_createDraftConversation).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createDraftConversation(). Use given")
			Failure("Stub return value not specified for createDraftConversation(). Use given")
		}
		return __value
    }

    open func createDraftConversation(title: String?) -> Conversation {
        addInvocation(.m_createDraftConversation__title_title(Parameter<String?>.value(`title`)))
		let perform = methodPerformValue(.m_createDraftConversation__title_title(Parameter<String?>.value(`title`))) as? (String?) -> Void
		perform?(`title`)
		var __value: Conversation
		do {
		    __value = try methodReturnValue(.m_createDraftConversation__title_title(Parameter<String?>.value(`title`))).casted()
		} catch {
			onFatalFailure("Stub return value not specified for createDraftConversation(title: String?). Use given")
			Failure("Stub return value not specified for createDraftConversation(title: String?). Use given")
		}
		return __value
    }


    fileprivate enum MethodType {
        case m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(Parameter<String?>, Parameter<[UUID]?>, Parameter<MessageInput?>)
        case m_createDraftConversation__title_titleproviderIds_providerIds(Parameter<String?>, Parameter<[UUID]?>)
        case m_watchItems__ofConversationWithId_conversationId(Parameter<UUID>)
        case m_setIsTyping__isTypinginConversationWithId_conversationId(Parameter<Bool>, Parameter<UUID>)
        case m_markConversationAsSeen__conversationId(Parameter<UUID>)
        case m_watchConversations
        case m_watchConversation__withId_conversationId(Parameter<UUID>)
        case m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(Parameter<MessageInput>, Parameter<UUID?>, Parameter<UUID>)
        case m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(Parameter<UUID>, Parameter<UUID>)
        case m_deleteMessage__withId_messageIdconversationId_conversationId(Parameter<UUID>, Parameter<UUID>)
        case m_addRefetchTriggers__triggers(Parameter<[RefetchTrigger]>)
        case m_sendMessage__messageinConversationWithId_conversationId(Parameter<MessageInput>, Parameter<UUID>)
        case m_createConversation__title_title(Parameter<String?>)
        case m_createConversation__providerIds_providerIds(Parameter<[UUID]?>)
        case m_createConversation
        case m_createDraftConversation
        case m_createDraftConversation__title_title(Parameter<String?>)

        static func compareParameters(lhs: MethodType, rhs: MethodType, matcher: Matcher) -> Matcher.ComparisonResult {
            switch (lhs, rhs) {
            case (.m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(let lhsTitle, let lhsProviderids, let lhsInitialmessage), .m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(let rhsTitle, let rhsProviderids, let rhsInitialmessage)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "title"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsProviderids, rhs: rhsProviderids, with: matcher), lhsProviderids, rhsProviderids, "providerIds"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsInitialmessage, rhs: rhsInitialmessage, with: matcher), lhsInitialmessage, rhsInitialmessage, "initialMessage"))
				return Matcher.ComparisonResult(results)

            case (.m_createDraftConversation__title_titleproviderIds_providerIds(let lhsTitle, let lhsProviderids), .m_createDraftConversation__title_titleproviderIds_providerIds(let rhsTitle, let rhsProviderids)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "title"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsProviderids, rhs: rhsProviderids, with: matcher), lhsProviderids, rhsProviderids, "providerIds"))
				return Matcher.ComparisonResult(results)

            case (.m_watchItems__ofConversationWithId_conversationId(let lhsConversationid), .m_watchItems__ofConversationWithId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "ofConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_setIsTyping__isTypinginConversationWithId_conversationId(let lhsIstyping, let lhsConversationid), .m_setIsTyping__isTypinginConversationWithId_conversationId(let rhsIstyping, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsIstyping, rhs: rhsIstyping, with: matcher), lhsIstyping, rhsIstyping, "_ isTyping"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_markConversationAsSeen__conversationId(let lhsConversationid), .m_markConversationAsSeen__conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "_ conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_watchConversations, .m_watchConversations): return .match

            case (.m_watchConversation__withId_conversationId(let lhsConversationid), .m_watchConversation__withId_conversationId(let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "withId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(let lhsMessage, let lhsReplyingtomessagewithid, let lhsConversationid), .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(let rhsMessage, let rhsReplyingtomessagewithid, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "_ message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsReplyingtomessagewithid, rhs: rhsReplyingtomessagewithid, with: matcher), lhsReplyingtomessagewithid, rhsReplyingtomessagewithid, "replyingToMessageWithId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(let lhsItemid, let lhsConversationid), .m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(let rhsItemid, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsItemid, rhs: rhsItemid, with: matcher), lhsItemid, rhsItemid, "itemWithId itemId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_deleteMessage__withId_messageIdconversationId_conversationId(let lhsMessageid, let lhsConversationid), .m_deleteMessage__withId_messageIdconversationId_conversationId(let rhsMessageid, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessageid, rhs: rhsMessageid, with: matcher), lhsMessageid, rhsMessageid, "withId messageId"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_addRefetchTriggers__triggers(let lhsTriggers), .m_addRefetchTriggers__triggers(let rhsTriggers)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTriggers, rhs: rhsTriggers, with: matcher), lhsTriggers, rhsTriggers, "_ triggers"))
				return Matcher.ComparisonResult(results)

            case (.m_sendMessage__messageinConversationWithId_conversationId(let lhsMessage, let lhsConversationid), .m_sendMessage__messageinConversationWithId_conversationId(let rhsMessage, let rhsConversationid)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsMessage, rhs: rhsMessage, with: matcher), lhsMessage, rhsMessage, "_ message"))
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsConversationid, rhs: rhsConversationid, with: matcher), lhsConversationid, rhsConversationid, "inConversationWithId conversationId"))
				return Matcher.ComparisonResult(results)

            case (.m_createConversation__title_title(let lhsTitle), .m_createConversation__title_title(let rhsTitle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "title"))
				return Matcher.ComparisonResult(results)

            case (.m_createConversation__providerIds_providerIds(let lhsProviderids), .m_createConversation__providerIds_providerIds(let rhsProviderids)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsProviderids, rhs: rhsProviderids, with: matcher), lhsProviderids, rhsProviderids, "providerIds"))
				return Matcher.ComparisonResult(results)

            case (.m_createConversation, .m_createConversation): return .match

            case (.m_createDraftConversation, .m_createDraftConversation): return .match

            case (.m_createDraftConversation__title_title(let lhsTitle), .m_createDraftConversation__title_title(let rhsTitle)):
				var results: [Matcher.ParameterComparisonResult] = []
				results.append(Matcher.ParameterComparisonResult(Parameter.compare(lhs: lhsTitle, rhs: rhsTitle, with: matcher), lhsTitle, rhsTitle, "title"))
				return Matcher.ComparisonResult(results)
            default: return .none
            }
        }

        func intValue() -> Int {
            switch self {
            case let .m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_createDraftConversation__title_titleproviderIds_providerIds(p0, p1): return p0.intValue + p1.intValue
            case let .m_watchItems__ofConversationWithId_conversationId(p0): return p0.intValue
            case let .m_setIsTyping__isTypinginConversationWithId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_markConversationAsSeen__conversationId(p0): return p0.intValue
            case .m_watchConversations: return 0
            case let .m_watchConversation__withId_conversationId(p0): return p0.intValue
            case let .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(p0, p1, p2): return p0.intValue + p1.intValue + p2.intValue
            case let .m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_deleteMessage__withId_messageIdconversationId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_addRefetchTriggers__triggers(p0): return p0.intValue
            case let .m_sendMessage__messageinConversationWithId_conversationId(p0, p1): return p0.intValue + p1.intValue
            case let .m_createConversation__title_title(p0): return p0.intValue
            case let .m_createConversation__providerIds_providerIds(p0): return p0.intValue
            case .m_createConversation: return 0
            case .m_createDraftConversation: return 0
            case let .m_createDraftConversation__title_title(p0): return p0.intValue
            }
        }
        func assertionName() -> String {
            switch self {
            case .m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage: return ".createConversation(title:providerIds:initialMessage:)"
            case .m_createDraftConversation__title_titleproviderIds_providerIds: return ".createDraftConversation(title:providerIds:)"
            case .m_watchItems__ofConversationWithId_conversationId: return ".watchItems(ofConversationWithId:)"
            case .m_setIsTyping__isTypinginConversationWithId_conversationId: return ".setIsTyping(_:inConversationWithId:)"
            case .m_markConversationAsSeen__conversationId: return ".markConversationAsSeen(_:)"
            case .m_watchConversations: return ".watchConversations()"
            case .m_watchConversation__withId_conversationId: return ".watchConversation(withId:)"
            case .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId: return ".sendMessage(_:replyingToMessageWithId:inConversationWithId:)"
            case .m_retrySending__itemWithId_itemIdinConversationWithId_conversationId: return ".retrySending(itemWithId:inConversationWithId:)"
            case .m_deleteMessage__withId_messageIdconversationId_conversationId: return ".deleteMessage(withId:conversationId:)"
            case .m_addRefetchTriggers__triggers: return ".addRefetchTriggers(_:)"
            case .m_sendMessage__messageinConversationWithId_conversationId: return ".sendMessage(_:inConversationWithId:)"
            case .m_createConversation__title_title: return ".createConversation(title:)"
            case .m_createConversation__providerIds_providerIds: return ".createConversation(providerIds:)"
            case .m_createConversation: return ".createConversation()"
            case .m_createDraftConversation: return ".createDraftConversation()"
            case .m_createDraftConversation__title_title: return ".createDraftConversation(title:)"
            }
        }
    }

    open class Given: StubbedMethod {
        fileprivate var method: MethodType

        private init(method: MethodType, products: [StubProduct]) {
            self.method = method
            super.init(products)
        }


        public static func createConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, initialMessage: Parameter<MessageInput?>, willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(`title`, `providerIds`, `initialMessage`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createDraftConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_createDraftConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchItems(ofConversationWithId conversationId: Parameter<UUID>, willReturn: AnyPublisher<PaginatedList<ConversationItem>, NablaError>...) -> MethodStub {
            return Given(method: .m_watchItems__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversations(willReturn: AnyPublisher<PaginatedList<Conversation>, NablaError>...) -> MethodStub {
            return Given(method: .m_watchConversations, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func watchConversation(withId conversationId: Parameter<UUID>, willReturn: AnyPublisher<Conversation, NablaError>...) -> MethodStub {
            return Given(method: .m_watchConversation__withId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createConversation(title: Parameter<String?>, willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_createConversation__title_title(`title`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createConversation(providerIds: Parameter<[UUID]?>, willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_createConversation__providerIds_providerIds(`providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createConversation(willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_createConversation, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createDraftConversation(willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_createDraftConversation, products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createDraftConversation(title: Parameter<String?>, willReturn: Conversation...) -> MethodStub {
            return Given(method: .m_createDraftConversation__title_title(`title`), products: willReturn.map({ StubProduct.return($0 as Any) }))
        }
        public static func createDraftConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, willProduce: (Stubber<Conversation>) -> Void) -> MethodStub {
            let willReturn: [Conversation] = []
			let given: Given = { return Given(method: .m_createDraftConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
        public static func watchItems(ofConversationWithId conversationId: Parameter<UUID>, willProduce: (Stubber<AnyPublisher<PaginatedList<ConversationItem>, NablaError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<PaginatedList<ConversationItem>, NablaError>] = []
			let given: Given = { return Given(method: .m_watchItems__ofConversationWithId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<PaginatedList<ConversationItem>, NablaError>).self)
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
        public static func watchConversation(withId conversationId: Parameter<UUID>, willProduce: (Stubber<AnyPublisher<Conversation, NablaError>>) -> Void) -> MethodStub {
            let willReturn: [AnyPublisher<Conversation, NablaError>] = []
			let given: Given = { return Given(method: .m_watchConversation__withId_conversationId(`conversationId`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (AnyPublisher<Conversation, NablaError>).self)
			willProduce(stubber)
			return given
        }
        public static func createDraftConversation(willProduce: (Stubber<Conversation>) -> Void) -> MethodStub {
            let willReturn: [Conversation] = []
			let given: Given = { return Given(method: .m_createDraftConversation, products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
        public static func createDraftConversation(title: Parameter<String?>, willProduce: (Stubber<Conversation>) -> Void) -> MethodStub {
            let willReturn: [Conversation] = []
			let given: Given = { return Given(method: .m_createDraftConversation__title_title(`title`), products: willReturn.map({ StubProduct.return($0 as Any) })) }()
			let stubber = given.stub(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
        public static func createConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, initialMessage: Parameter<MessageInput?>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(`title`, `providerIds`, `initialMessage`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func createConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, initialMessage: Parameter<MessageInput?>, willProduce: (StubberThrows<Conversation>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(`title`, `providerIds`, `initialMessage`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, inConversationWithId conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_setIsTyping__isTypinginConversationWithId_conversationId(`isTyping`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, inConversationWithId conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_setIsTyping__isTypinginConversationWithId_conversationId(`isTyping`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func markConversationAsSeen(_ conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_markConversationAsSeen__conversationId(`conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func markConversationAsSeen(_ conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_markConversationAsSeen__conversationId(`conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyingToMessageWithId: Parameter<UUID?>, inConversationWithId conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(`message`, `replyingToMessageWithId`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyingToMessageWithId: Parameter<UUID?>, inConversationWithId conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(`message`, `replyingToMessageWithId`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(`itemId`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(`itemId`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_deleteMessage__withId_messageIdconversationId_conversationId(`messageId`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_deleteMessage__withId_messageIdconversationId_conversationId(`messageId`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, inConversationWithId conversationId: Parameter<UUID>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_sendMessage__messageinConversationWithId_conversationId(`message`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, inConversationWithId conversationId: Parameter<UUID>, willProduce: (StubberThrows<Void>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_sendMessage__messageinConversationWithId_conversationId(`message`, `conversationId`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Void).self)
			willProduce(stubber)
			return given
        }
        public static func createConversation(title: Parameter<String?>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_createConversation__title_title(`title`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func createConversation(title: Parameter<String?>, willProduce: (StubberThrows<Conversation>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_createConversation__title_title(`title`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
        public static func createConversation(providerIds: Parameter<[UUID]?>, willThrow: Error...) -> MethodStub {
            return Given(method: .m_createConversation__providerIds_providerIds(`providerIds`), products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func createConversation(providerIds: Parameter<[UUID]?>, willProduce: (StubberThrows<Conversation>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_createConversation__providerIds_providerIds(`providerIds`), products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
        public static func createConversation(willThrow: Error...) -> MethodStub {
            return Given(method: .m_createConversation, products: willThrow.map({ StubProduct.throw($0) }))
        }
        public static func createConversation(willProduce: (StubberThrows<Conversation>) -> Void) -> MethodStub {
            let willThrow: [Error] = []
			let given: Given = { return Given(method: .m_createConversation, products: willThrow.map({ StubProduct.throw($0) })) }()
			let stubber = given.stubThrows(for: (Conversation).self)
			willProduce(stubber)
			return given
        }
    }

    public struct Verify {
        fileprivate var method: MethodType

        public static func createConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, initialMessage: Parameter<MessageInput?>) -> Verify { return Verify(method: .m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(`title`, `providerIds`, `initialMessage`))}
        public static func createDraftConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>) -> Verify { return Verify(method: .m_createDraftConversation__title_titleproviderIds_providerIds(`title`, `providerIds`))}
        public static func watchItems(ofConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_watchItems__ofConversationWithId_conversationId(`conversationId`))}
        public static func setIsTyping(_ isTyping: Parameter<Bool>, inConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_setIsTyping__isTypinginConversationWithId_conversationId(`isTyping`, `conversationId`))}
        public static func markConversationAsSeen(_ conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_markConversationAsSeen__conversationId(`conversationId`))}
        public static func watchConversations() -> Verify { return Verify(method: .m_watchConversations)}
        public static func watchConversation(withId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_watchConversation__withId_conversationId(`conversationId`))}
        public static func sendMessage(_ message: Parameter<MessageInput>, replyingToMessageWithId: Parameter<UUID?>, inConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(`message`, `replyingToMessageWithId`, `conversationId`))}
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(`itemId`, `conversationId`))}
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_deleteMessage__withId_messageIdconversationId_conversationId(`messageId`, `conversationId`))}
        public static func addRefetchTriggers(_ triggers: Parameter<[RefetchTrigger]>) -> Verify { return Verify(method: .m_addRefetchTriggers__triggers(`triggers`))}
        public static func sendMessage(_ message: Parameter<MessageInput>, inConversationWithId conversationId: Parameter<UUID>) -> Verify { return Verify(method: .m_sendMessage__messageinConversationWithId_conversationId(`message`, `conversationId`))}
        public static func createConversation(title: Parameter<String?>) -> Verify { return Verify(method: .m_createConversation__title_title(`title`))}
        public static func createConversation(providerIds: Parameter<[UUID]?>) -> Verify { return Verify(method: .m_createConversation__providerIds_providerIds(`providerIds`))}
        public static func createConversation() -> Verify { return Verify(method: .m_createConversation)}
        public static func createDraftConversation() -> Verify { return Verify(method: .m_createDraftConversation)}
        public static func createDraftConversation(title: Parameter<String?>) -> Verify { return Verify(method: .m_createDraftConversation__title_title(`title`))}
    }

    public struct Perform {
        fileprivate var method: MethodType
        var performs: Any

        public static func createConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, initialMessage: Parameter<MessageInput?>, perform: @escaping (String?, [UUID]?, MessageInput?) -> Void) -> Perform {
            return Perform(method: .m_createConversation__title_titleproviderIds_providerIdsinitialMessage_initialMessage(`title`, `providerIds`, `initialMessage`), performs: perform)
        }
        public static func createDraftConversation(title: Parameter<String?>, providerIds: Parameter<[UUID]?>, perform: @escaping (String?, [UUID]?) -> Void) -> Perform {
            return Perform(method: .m_createDraftConversation__title_titleproviderIds_providerIds(`title`, `providerIds`), performs: perform)
        }
        public static func watchItems(ofConversationWithId conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_watchItems__ofConversationWithId_conversationId(`conversationId`), performs: perform)
        }
        public static func setIsTyping(_ isTyping: Parameter<Bool>, inConversationWithId conversationId: Parameter<UUID>, perform: @escaping (Bool, UUID) -> Void) -> Perform {
            return Perform(method: .m_setIsTyping__isTypinginConversationWithId_conversationId(`isTyping`, `conversationId`), performs: perform)
        }
        public static func markConversationAsSeen(_ conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_markConversationAsSeen__conversationId(`conversationId`), performs: perform)
        }
        public static func watchConversations(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_watchConversations, performs: perform)
        }
        public static func watchConversation(withId conversationId: Parameter<UUID>, perform: @escaping (UUID) -> Void) -> Perform {
            return Perform(method: .m_watchConversation__withId_conversationId(`conversationId`), performs: perform)
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, replyingToMessageWithId: Parameter<UUID?>, inConversationWithId conversationId: Parameter<UUID>, perform: @escaping (MessageInput, UUID?, UUID) -> Void) -> Perform {
            return Perform(method: .m_sendMessage__messagereplyingToMessageWithId_replyingToMessageWithIdinConversationWithId_conversationId(`message`, `replyingToMessageWithId`, `conversationId`), performs: perform)
        }
        public static func retrySending(itemWithId itemId: Parameter<UUID>, inConversationWithId conversationId: Parameter<UUID>, perform: @escaping (UUID, UUID) -> Void) -> Perform {
            return Perform(method: .m_retrySending__itemWithId_itemIdinConversationWithId_conversationId(`itemId`, `conversationId`), performs: perform)
        }
        public static func deleteMessage(withId messageId: Parameter<UUID>, conversationId: Parameter<UUID>, perform: @escaping (UUID, UUID) -> Void) -> Perform {
            return Perform(method: .m_deleteMessage__withId_messageIdconversationId_conversationId(`messageId`, `conversationId`), performs: perform)
        }
        public static func addRefetchTriggers(_ triggers: Parameter<[RefetchTrigger]>, perform: @escaping ([RefetchTrigger]) -> Void) -> Perform {
            return Perform(method: .m_addRefetchTriggers__triggers(`triggers`), performs: perform)
        }
        public static func sendMessage(_ message: Parameter<MessageInput>, inConversationWithId conversationId: Parameter<UUID>, perform: @escaping (MessageInput, UUID) -> Void) -> Perform {
            return Perform(method: .m_sendMessage__messageinConversationWithId_conversationId(`message`, `conversationId`), performs: perform)
        }
        public static func createConversation(title: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .m_createConversation__title_title(`title`), performs: perform)
        }
        public static func createConversation(providerIds: Parameter<[UUID]?>, perform: @escaping ([UUID]?) -> Void) -> Perform {
            return Perform(method: .m_createConversation__providerIds_providerIds(`providerIds`), performs: perform)
        }
        public static func createConversation(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_createConversation, performs: perform)
        }
        public static func createDraftConversation(perform: @escaping () -> Void) -> Perform {
            return Perform(method: .m_createDraftConversation, performs: perform)
        }
        public static func createDraftConversation(title: Parameter<String?>, perform: @escaping (String?) -> Void) -> Perform {
            return Perform(method: .m_createDraftConversation__title_title(`title`), performs: perform)
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

