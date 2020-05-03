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
    let releaseDateString: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "cover_big"
        case releaseDateString = "release_date"
    }
}

extension DeezerAlbum {
    var releaseDate: Date? {
        releaseDateString.toDate(format: "yyyy-MM-dd")
    }
}
