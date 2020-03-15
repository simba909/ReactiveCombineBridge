//
//  CombineEvent.swift
//  
//
//  Created by Simon Jarbrant on 2020-03-15.
//

import Combine

enum CombineEvent<Output, Failure: Error> {
    case value(Output)
    case completed(Subscribers.Completion<Failure>)
}

extension CombineEvent: Equatable where Output: Equatable, Failure: Equatable {}
