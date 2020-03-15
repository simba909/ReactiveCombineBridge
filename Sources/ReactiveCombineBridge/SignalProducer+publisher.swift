//
//  SignalProducer+publisher.swift
//  
//
//  Created by Simon Jarbrant on 2020-03-15.
//

import Combine
import ReactiveSwift

public extension SignalProducer {
    func publisher() -> ReactiveSwiftPublisher<Value, Error> {
        return ReactiveSwiftPublisher(producer: self)
    }
}
