//
//  ImageEndpoint.swift
//  Matis
//
//  Created by Maxime Maheo on 03/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation
import UIKit

final class ImageEndpoint: ApiEndpoint {
    
    typealias RequestDataType = String
    typealias ResponseDataType = UIImage?
    
    // MARK: - Methods
    func buildRequest(parameters: ImageEndpoint.RequestDataType) throws -> Request {
        guard
            let request = BaseRequest(baseStringUrl: parameters)
        else {
            throw RequestError.failedToCreateRequestWithUrl(parameters)
        }
        
        return request
    }
    
    func parseResponse(data: Data) throws -> ImageEndpoint.ResponseDataType {
        UIImage(data: data)
    }
}
