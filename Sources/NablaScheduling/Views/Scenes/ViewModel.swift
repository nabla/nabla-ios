import Combine
import Foundation

protocol ViewModel: AnyObject {
    func onChange() -> AnyPublisher<Void, Never>
    func onChange(throttle: DispatchQueue.SchedulerTimeType.Stride) -> AnyPublisher<Void, Never>
}

extension ViewModel where Self: ObservableObject {
    func onChange() -> AnyPublisher<Void, Never> {
        objectWillChange
            .map { _ in }
            .receive(on: DispatchQueue.main)
            .merge(with: Just(()))
            .eraseToAnyPublisher()
    }
    
    func onChange(throttle: DispatchQueue.SchedulerTimeType.Stride) -> AnyPublisher<Void, Never> {
        objectWillChange
            .map { _ in }
            .throttle(for: throttle, scheduler: DispatchQueue.main, latest: true)
            .merge(with: Just(()))
            .eraseToAnyPublisher()
    }
}

@propertyWrapper
class ObservedViewModel<T> {
    var wrappedValue: T
    
    @discardableResult
    func onChange(_ execute: @escaping (T) -> Void) -> AnyCancellable {
        guard let viewModel = wrappedValue as? ViewModel else { return AnyCancellable {} }
        let cancellable = viewModel.onChange()
            .sink { [weak self] in
                guard let self = self else { return }
                execute(self.wrappedValue)
            }
        cancellable.store(in: &subscriptions)
        return cancellable
    }
    
    @discardableResult
    func onChange(throttle: DispatchQueue.SchedulerTimeType.Stride, _ execute: @escaping (T) -> Void) -> AnyCancellable {
        guard let viewModel = wrappedValue as? ViewModel else { return AnyCancellable {} }
        let cancellable = viewModel.onChange(throttle: throttle)
            .sink { [weak self] in
                guard let self = self else { return }
                execute(self.wrappedValue)
            }
        cancellable.store(in: &subscriptions)
        return cancellable
    }
    
    init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
    
    private var subscriptions = Set<AnyCancellable>()
}
