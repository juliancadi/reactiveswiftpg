//
//  FlatMapLatestTakeOne.swift
//  ReactiveSwiftPlayground
//
//  Created by Julian Caicedo on 20.03.20.
//  Copyright © 2020 juliancadi.com. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift

final class FlatMapLatestTakeOne {

    let (serviceSignal, serviceTrigger) = Signal<Bool, Never>.pipe()
    let (innerSignal, innerTrigger) = Signal<String, Never>.pipe()

    func run() -> Signal<String, Never> {
        start()
            |> watchReactiveProperty
            |> informResult
    }

}

private extension FlatMapLatestTakeOne {

    func start() -> Signal<Bool, Never> {
        serviceSignal
    }

    func watchReactiveProperty(_ input: Signal<Bool, Never>) -> Signal<String, Never> {
        input
            .filter { $0 }
            .flatMap(.latest) { [weak self] _ -> Signal<String, Never> in
                guard let self = self else { return Signal.empty }
                return self.innerSignal
                    .take(first: 1)
                    .on { print("🐣 Emitting inside flatMap: \($0)") }
            }
    }

    func informResult(_ input: Signal<String, Never>) -> Signal<String, Never> {
        input.on {
            print("🗺 FlatMapLatest: \($0)")
        }
    }

}
