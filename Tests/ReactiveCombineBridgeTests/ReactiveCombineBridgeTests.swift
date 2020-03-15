import XCTest
import Combine
import ReactiveSwift

@testable import ReactiveCombineBridge

final class ReactiveCombineBridgeTests: XCTestCase {
    func testConvertsPublisherToSignalProducer() {
        let publisher = PassthroughSubject<Int, Never>()

        var receivedEvents: [Signal<Int, Never>.Event] = []
        publisher.signalProducer()
            .start { event in
                receivedEvents.append(event)
        }

        publisher.send(1)
        publisher.send(2)
        publisher.send(3)
        publisher.send(completion: .finished)

        XCTAssertEqual(receivedEvents, [
            .value(1),
            .value(2),
            .value(3),
            .completed
        ])
    }

    func testConvertsSignalProducerToPublisher() {
        let (signal, observer) = Signal<Int, Never>.pipe()

        var receivedEvents: [CombineEvent<Int, Never>] = []
        _ = signal.publisher()
            .sink(receiveCompletion: { completion in
                receivedEvents.append(.completed(completion))
            }, receiveValue: { value in
                receivedEvents.append(.value(value))
            })

        observer.send(value: 1)
        observer.send(value: 2)
        observer.send(value: 3)
        observer.sendCompleted()

        XCTAssertEqual(receivedEvents, [
            .value(1),
            .value(2),
            .value(3),
            .completed(.finished)
        ])
    }
}
