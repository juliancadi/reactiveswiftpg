//
//  ReactiveSwift+Extensions.swift
//  ReactiveSwift+Extensions
//
//  Created by Julian Caicedo on 20.03.20.
//  Copyright © 2020 juliancadi.com. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

infix operator |> : AdditionPrecedence
infix operator |<> : AdditionPrecedence

@discardableResult func |> <T, U>(value: T, function: ((T) -> U)) -> U {
    function(value)
}

@discardableResult func |<> <T, E>(lhs: Signal<T, E>, rhs: Signal<T, E>) -> Signal<T, E> {
    Signal<T, E>.merge(lhs, rhs)
}

@discardableResult func |<> <T, E>(lhs: SignalProducer<T, E>, rhs: SignalProducer<T, E>) -> SignalProducer<T, E> {
    SignalProducer<T, E>.merge(lhs, rhs)
}
