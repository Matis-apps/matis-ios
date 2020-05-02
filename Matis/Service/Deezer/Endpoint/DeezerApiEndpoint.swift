//
//  DeezerApiEndpoint.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

class DeezerApiEndpoint {
    
    // MARK: - Methods
    func buildRequest(method: String) throws -> Request {
        let stringUrl = "https://api.deezer.com/\(method)"
        
        guard let request = BaseRequest(baseStringUrl: stringUrl) else {
            throw RequestError.failedToCreateRequestWithUrl(stringUrl)
        }
        
        return request
    }
    
}
