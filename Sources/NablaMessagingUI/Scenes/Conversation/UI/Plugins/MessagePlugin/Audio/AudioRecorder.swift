import AVFoundation
import Foundation
import NablaMessagingCore
import UIKit

private enum Constants {
    static let filename: String = "_audio_recording.m4a"
    static let settings: [String: Int] = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
    ]
    static let timeLimit: TimeInterval = 600.0
}

protocol AudioRecorderDelegate: AnyObject {
    func audioRecorder(_ recorder: AudioRecorder, didUpdateCurrentRecordingTime time: TimeInterval)
}

class AudioRecorder: NSObject {
    struct Dependencies {
        let logger: Logger
    }

    weak var delegate: AudioRecorderDelegate?

    // MARK: - Initializer

    init(dependencies: Dependencies) {
        logger = dependencies.logger
    }

    // MARK: - Public

    func requestPermission(
        completionQueue: DispatchQueue = .main,
        completion: @escaping (Result<Bool, Error>) -> Void
        
    ) {
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            switch recordingSession.recordPermission {
            case .undetermined:
                recordingSession.requestRecordPermission { allowed in
                    completionQueue.async {
                        completion(.success(allowed))
                    }
                }
            case .denied:
                if let url = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
                completionQueue.async {
                    completion(.success(false))
                }
            case .granted:
                completionQueue.async {
                    completion(.success(true))
                }
            @unknown default:
                completionQueue.async {
                    completion(.success(false))
                }
            }
        } catch {
            logger.error(message: "Cannot set audio category", extra: ["reason": error])
            completionQueue.async {
                completion(.failure(error))
            }
        }
    }

    func startRecording() {
        let recordingUrl = getRecordingURL()
        do {
            let recorder = try AVAudioRecorder(url: recordingUrl, settings: Constants.settings)
            recorder.delegate = self
            recorder.record()
            self.recorder = recorder

            _ = Timer.scheduledTimer(withTimeInterval: Constants.timeLimit, repeats: false) { _ in
                recorder.stop()
            }

            startCurrentTimePublication()
        } catch {
            logger.error(message: "Cannot create AVAudioRecorder", extra: ["reason": error])
        }
    }

    func stopRecording(completion: @escaping (AudioFile) -> Void) {
        self.completion = completion
        recorder?.stop()
        stopCurrentTimePublication()
    }

    // MARK: - Private

    private let logger: Logger
    private let recordingSession: AVAudioSession = .sharedInstance()

    private var recorder: AVAudioRecorder?
    private var progressTimer: Timer?
    private var currentRecordingTime: TimeInterval = 0 {
        didSet {
            delegate?.audioRecorder(self, didUpdateCurrentRecordingTime: currentRecordingTime)
        }
    }

    private var completion: ((AudioFile) -> Void)?

    private func getRecordingURL() -> URL {
        let manager = FileManager.default
        let url = manager.temporaryDirectory.appendingPathComponent(UUID().uuidString + Constants.filename)
        return url
    }

    private func startCurrentTimePublication() {
        guard let recorder = recorder else { return }
        progressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.currentRecordingTime = recorder.currentTime * 1000
        }
    }

    private func stopCurrentTimePublication() {
        progressTimer?.invalidate()
        progressTimer = nil
    }
}

extension AudioRecorder: AVAudioRecorderDelegate {
    // MARK: - AVAudioRecorderDelegate

    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully: Bool) {
        guard successfully else { return }
        let audioFile = AudioFile(
            media: Media(
                type: .audio,
                fileName: Constants.filename,
                fileUrl: recorder.url,
                thumbnailUrl: nil,
                mimeType: .mpeg
            ),
            durationMs: Int(currentRecordingTime)
        )
        self.recorder = nil
        completion?(audioFile)
    }
}
