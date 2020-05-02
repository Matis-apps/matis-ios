//
//  ApiEndpoint.swift
//  Matis
//
//  Created by Maxime Maheo on 26/03/2020.
//  Copyright © 2020 Maxime Maheo. All rights reserved.
//

import Foundation

protocol RequestBuilder {
    
    associatedtype RequestDataType

    // MARK: - Methods
    func buildRequest(parameters: RequestDataType) throws -> Request
}

protocol ResponseParser {
    
    associatedtype ResponseDataType
    
    // MARK: - Methods
    func parseResponse(data: Data) throws -> ResponseDataType
}

typealias ApiEndpoint = RequestBuilder & ResponseParser
