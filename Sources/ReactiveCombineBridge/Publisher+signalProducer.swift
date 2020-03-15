//
//  Publisher+signalProducer.swift
//  
//
//  Created by Simon Jarbrant on 2020-03-15.
//

import Combine
import ReactiveSwift

public extension Publisher {
    func signalProducer() -> SignalProducer<Output, Failure> {
        return SignalProducer { observer, lifetime in
            let cancellable = self.sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error)
                }
            }, receiveValue: { value in
                observer.send(value: value)
            })

            lifetime.observeEnded {
                cancellable.cancel()
            }
        }
    }
}
