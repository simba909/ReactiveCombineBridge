//
//  Signal+publisher.swift
//
//
//  Created by Simon Jarbrant on 2020-03-15.
//

import Combine
import ReactiveSwift

public extension Signal {
    func publisher() -> ReactiveSwiftPublisher<Value, Error> {
        return producer.publisher()
    }
}
