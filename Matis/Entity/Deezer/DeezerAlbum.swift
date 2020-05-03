//
//  DeezerAlbum.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

struct DeezerAlbumsData: Codable {
    let data: [DeezerAlbum]
}

struct DeezerAlbum: Codable {
    let id: Int
    let title: String
    let posterPath: String
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "cover_big"
        case releaseDate = "release_date"
    }
}
