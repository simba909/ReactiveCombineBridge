//
//  ReactiveSwiftSubscription.swift
//  
//
//  Created by Simon Jarbrant on 2020-03-15.
//

import Combine
import ReactiveSwift

final class ReactiveSwiftSubscription<S, Output, Failure>: Subscription where S: Subscriber, S.Input == Output, S.Failure == Failure {
    private let producer: SignalProducer<Output, Failure>

    private var subscriber: S?
    private var disposable: Disposable?

    init(producer: SignalProducer<Output, Failure>, subscriber: S) {
        self.producer = producer
        self.subscriber = subscriber
    }

    func request(_ demand: Subscribers.Demand) {
        // TODO: Implement support for demand
    }

    func start() {
        disposable = producer.start { [subscriber] event in
            switch event {
            case .completed:
                subscriber?.receive(completion: .finished)
            case .failed(let error):
                subscriber?.receive(completion: .failure(error))
            case .interrupted:
                break
            case .value(let value):
                // TODO: Manage demand
                _ = subscriber?.receive(value)
            }
        }
    }

    func cancel() {
        disposable?.dispose()
        disposable = nil
        subscriber = nil
    }
}
