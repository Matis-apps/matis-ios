//
//  DeezerPlaylist.swift
//  Matis
//
//  Created by Maxime Maheo on 05/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

struct DeezerPlaylistsData: Codable {
    let data: [DeezerPlaylist]
}

struct DeezerPlaylist: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let updatedAt: Double
    let creator: DeezerPlaylistCreator

    var updatedAtDate: Date {
        Date(timeIntervalSince1970: updatedAt)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, creator
        case posterPath = "picture_big"
        case updatedAt = "time_mod"
    }
}

struct DeezerPlaylistCreator: Codable {
    let id: Int
    let name: String
}
