//
//  ApiRequester.swift
//  Matis
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation
import Combine
//import RxSwift
//
enum ApiRequesterError: LocalizedError {
    case noInternetConnection
    case failedToBuildRequest
    case unknown
    case requestFailed(String?)
    case invalidStatusCode(String?, Int)
    case failedToDecodeResponse
    case invalidUrl(String)
    case selfIsNil

    var localizedDescription: String {
        switch self {
        case .noInternetConnection:
            return "No internet connection"
        case .failedToBuildRequest:
            return "Failed to build request"
        case .unknown:
            return "Unknown error occured"
        case let .requestFailed(stringUrl):
            return "Request failed : \(stringUrl ?? "nil")"
        case let .invalidStatusCode(stringUrl, statusCode):
            return "Invalid status code (\(statusCode)) for request : \(stringUrl ?? "nil")"
        case .failedToDecodeResponse:
            return "Failed to decode response"
        case let .invalidUrl(stringUrl):
            return "Invalid url : \(stringUrl)"
        case .selfIsNil:
            return "Self value is nil"
        }
    }
}

final class ApiRequester {
    
    // MARK: - Properties
    private let urlSession: URLSession
    private let reachability: Reachability?
    
    // MARK: - Lifecycle
    public init(urlSession: URLSession = .shared, reachability: Reachability? = try? Reachability()) {
       self.urlSession = urlSession
       self.reachability = reachability
   }

    // MARK: - Methods
    func fetch<T: ApiEndpoint>(_ endpoint: T, with parameters: T.RequestDataType) -> AnyPublisher<T.ResponseDataType, Error> {
        if reachability?.connection == Reachability.Connection.unavailable {
            return Fail(error: ApiRequesterError.noInternetConnection)
                .eraseToAnyPublisher()
        }
        
        guard let urlRequest = try? endpoint.buildRequest(parameters: parameters).urlRequest else {
            return Fail(error: ApiRequesterError.failedToBuildRequest)
                .eraseToAnyPublisher()
        }
                
        return urlSession
            .dataTaskPublisher(for: urlRequest)
            .tryMap { (data, response) in
                guard let urlResponse = response as? HTTPURLResponse else {
                    throw ApiRequesterError.requestFailed(urlRequest.url?.absoluteString)
                }
                
                guard 200 ..< 300 ~= urlResponse.statusCode else {
                    throw ApiRequesterError.invalidStatusCode(urlRequest.url?.absoluteString, urlResponse.statusCode)
                }
                
                guard let parsedResponse = try? endpoint.parseResponse(data: data) else {
                    throw ApiRequesterError.failedToDecodeResponse
                }
                    
                return parsedResponse
            }
            .retry(max: 5, interval: .seconds(2))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
