//
//  UserFavoriteArtistsEndpoint.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

final class UserFavoriteArtistsEndpoint: DeezerApiEndpoint, ApiEndpoint {
    
    typealias RequestDataType = Int
    typealias ResponseDataType = [DeezerArtist]
    
    // MARK: - Methods
    func buildRequest(parameters: UserFavoriteArtistsEndpoint.RequestDataType) throws -> Request {
        try buildRequest(method: "user/\(parameters)/artists")
            .addQueryParameters(parameters: ["limit": 100])
    }
    
    func parseResponse(data: Data) throws -> UserFavoriteArtistsEndpoint.ResponseDataType {
        try JSONDecoder()
            .decode(DeezerArtistsData.self, from: data)
            .data
    }
}
