import Foundation

final class SharedTask<T> {
    // MARK: - Internal

    typealias Completion = (T) -> Void
    typealias Resolver = (T) -> Void

    init(asyncTask: @escaping (_ resolver: @escaping Resolver) -> Void) {
        self.asyncTask = asyncTask
    }

    func addOnComplete(_ completion: @escaping Completion) {
        if let result = result {
            completion(result)
        } else {
            completions.append(completion)
        }
    }

    func resume() {
        guard !resumed else { return }
        resumed = true

        asyncTask { [weak self] result in
            self?.result = result
            self?.completions.forEach { completion in
                completion(result)
            }
        }
    }

    // MARK: - Private

    private let asyncTask: (@escaping Resolver) -> Void
    private var completions = [Completion]()

    private var resumed: Bool = false
    private var result: T?
}
