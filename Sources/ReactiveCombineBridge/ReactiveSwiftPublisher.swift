//
//  ReactiveSwiftPublisher.swift
//  
//
//  Created by Simon Jarbrant on 2020-03-15.
//

import Combine
import ReactiveSwift

public struct ReactiveSwiftPublisher<Output, Failure: Error>: Publisher {
    private let producer: SignalProducer<Output, Failure>

    init(producer: SignalProducer<Output, Failure>) {
        self.producer = producer
    }

    public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
        let subscription = ReactiveSwiftSubscription(
            producer: producer,
            subscriber: subscriber)

        subscription.start()
    }
}
