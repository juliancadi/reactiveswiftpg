//
//  SynchronouslyAccessReactiveSignalTests.swift
//  ReactiveSwiftPlaygroundTests
//
//  Created by Julian Caicedo on 20.03.20.
//  Copyright © 2020 juliancadi.com. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import Quick
import Nimble
@testable import ReactiveSwiftPlayground

class SynchronouslyAccessReactiveSignalTests: QuickSpec {

    override func spec() {

        describe("SynchronouslyAccessReactiveSignalTests") {

            // MARK: - FlatMapLatest

            context("FlatMapLatest") {

                var service: FlatMapLatest!
                var serviceValues: [String]!

                beforeEach {
                    service = FlatMapLatest()
                    serviceValues = []

                    service.run()
                        .observeValues { serviceValues.append($0) }
                }

                it("should emit several times if inner signal emits several times") {

                    service.serviceTrigger.send(value: true)
                    service.innerTrigger.send(value: "1")
                    service.innerTrigger.send(value: "2")
                    service.innerTrigger.send(value: "3")

                    expect(serviceValues).toEventually(equal(["1", "2", "3"]))
                }

                it("should never emit if inner signal doesn't emit") {

                    service.serviceTrigger.send(value: true)

                    expect(serviceValues).toEventually(equal([]))
                }

            }

            // MARK: - FlatMapLatestTakeOne

            context("FlatMapLatestTakeOne") {

                var service: FlatMapLatestTakeOne!
                var serviceValues: [String]!

                beforeEach {
                    service = FlatMapLatestTakeOne()
                    serviceValues = []

                    service.run()
                        .observeValues { serviceValues.append($0) }
                }

                it("should emit once even if inner signal emits several times") {

                    service.serviceTrigger.send(value: true)
                    service.innerTrigger.send(value: "1")
                    service.innerTrigger.send(value: "2")
                    service.innerTrigger.send(value: "3")

                    expect(serviceValues).toEventually(equal(["1"]))
                }

                it("should never emit if inner signal doesn't emit") {

                    service.serviceTrigger.send(value: true)

                    expect(serviceValues).toEventually(equal([]))
                }

            }

            #warning("TODO: Take latest from")
            #warning("TODO: Sample")
            #warning("TODO: Combine latest")

        }

    }

}
