//
//  ArtistAlbumsEndpoint.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

final class ArtistAlbumsEndpoint: DeezerApiEndpoint, ApiEndpoint {
    
    typealias RequestDataType = Int
    typealias ResponseDataType = [DeezerAlbum]
    
    // MARK: - Methods
    func buildRequest(parameters: ArtistAlbumsEndpoint.RequestDataType) throws -> Request {
        try buildRequest(method: "artist/\(parameters)/albums")
            .addQueryParameters(parameters: ["limit": 100])
    }
    
    func parseResponse(data: Data) throws -> ArtistAlbumsEndpoint.ResponseDataType {
        try JSONDecoder()
            .decode(DeezerAlbumsData.self, from: data)
            .data
    }
}
