//
//  UserPlaylistsEndpoint.swift
//  Matis
//
//  Created by Maxime Maheo on 05/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

final class UserPlaylistsEndpoint: DeezerApiEndpoint, ApiEndpoint {
    
    typealias RequestDataType = Int
    typealias ResponseDataType = [DeezerPlaylist]
    
    // MARK: - Methods
    func buildRequest(parameters: UserPlaylistsEndpoint.RequestDataType) throws -> Request {
        try buildRequest(method: "user/\(parameters)/playlists")
            .addQueryParameters(parameters: ["limit": 100])
    }
    
    func parseResponse(data: Data) throws -> UserPlaylistsEndpoint.ResponseDataType {
        try JSONDecoder()
            .decode(DeezerPlaylistsData.self, from: data)
            .data
    }
}
