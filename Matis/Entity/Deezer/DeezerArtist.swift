//
//  DeezerArtist.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

struct DeezerArtistsData: Codable {
    let data: [DeezerArtist]
}

struct DeezerArtist: Codable {
    let id: Int
    let name: String
}
