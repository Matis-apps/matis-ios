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
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case releaseDate = "release_date"
    }
}

extension DeezerAlbum {
    var releaseDateComputed: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: releaseDate)
    }
}
