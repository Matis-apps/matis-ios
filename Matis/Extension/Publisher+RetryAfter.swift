//
//  Publisher+RetryAfter.swift
//  Matis
//
//  Created by Maxime Maheo on 05/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Combine
import Foundation

extension Publisher {
    func retry<Output, Failure>(max nbRetry: Int,
                                         interval: DispatchTimeInterval)
        -> Publishers.Catch<Self, AnyPublisher<Output, Failure>> where Output == Self.Output, Failure == Self.Failure {
        self.catch { _ in
            Publishers
                .Delay(upstream: self,
                       interval: DispatchQueue.SchedulerTimeType.Stride(interval),
                       tolerance: 1,
                       scheduler: DispatchQueue.global())
                .retry(nbRetry)
                .eraseToAnyPublisher()
        }
    }
}
