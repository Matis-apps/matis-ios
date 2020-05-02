//
//  Request.swift
//  Matis
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

enum RequestError: LocalizedError {
    case failedToCreateRequestWithUrl(String)

    var localizedDescription: String {
        switch self {
        case let .failedToCreateRequestWithUrl(url):
            return "Failed to create the request with url : \(url)"
        }
    }
}

protocol Request {
    var urlRequest: URLRequest { get }
}

extension URLRequest {
    
    mutating func addQueryParameters(parameters: [String: String]) {
        guard
            !parameters.isEmpty,
            let stringUrl = url?.absoluteString,
            var components = URLComponents(string: stringUrl)
        else { return }

        components.queryItems = components.queryItems ?? []

        for key in parameters.keys.sorted(by: <) {
            components.queryItems?.append(URLQueryItem(name: key, value: parameters[key]))
        }

        url = components.url
    }

    mutating func addHttpHeadersFields(parameters: [String: String]) {
        for key in parameters.keys.sorted(by: <) {
            setValue(parameters[key], forHTTPHeaderField: key)
        }
    }

    mutating func addBodyParameters(_ parameters: Any) {
        guard let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }

        httpBody = data
    }
    
}
