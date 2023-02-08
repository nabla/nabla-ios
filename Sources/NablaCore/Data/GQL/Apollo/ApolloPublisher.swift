import Apollo
import Combine
import Foundation

struct ApolloPublisher<Response>: Publisher {
    // MARK: - Internal

    typealias Output = Response
    typealias Failure = Error
    
    typealias ResultHandler = (Result<Response, Error>) -> Void
    typealias Factory = (@escaping ResultHandler) -> Combine.Cancellable
    
    func receive<S>(subscriber: S) where S: Subscriber, Failure == S.Failure, Output == S.Input {
        let subscription = Subscription(factory: factory, subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
    
    // MARK: Init
    
    init(
        factory: @escaping Factory
    ) {
        self.factory = factory
    }
    
    // MARK: - Private
    
    private let factory: Factory
}

extension ApolloPublisher {
    final class Subscription<S: Subscriber>: Combine.Subscription where S.Input == Output, S.Failure == Failure {
        // MARK: - Internal
        
        func cancel() {
            subscriber = nil
            cancellable?.cancel()
            cancellable = nil
        }
        
        func request(_ demand: Subscribers.Demand) {
            guard let subscriber = subscriber, demand > 0 else { return }
            
            cancellable = factory { response in
                switch response {
                case let .failure(error):
                    subscriber.receive(completion: .failure(error))
                case let .success(result):
                    _ = subscriber.receive(result)
                }
            }
        }
        
        // MARK: Init
        
        init(
            factory: @escaping Factory,
            subscriber: S
        ) {
            self.factory = factory
            self.subscriber = subscriber
        }
        
        deinit {
            cancellable?.cancel()
        }
        
        // MARK: - Private
        
        private let factory: Factory
        
        private var subscriber: S?
        private var cancellable: Combine.Cancellable?
    }
}
