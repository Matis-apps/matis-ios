//
//  NewsFeedArtist.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

struct NewsFeedArtist: Identifiable {
    let id: Int
    let name: String
    var latestRelease: NewsFeedLatestRelease?
}

extension NewsFeedArtist {
    static let one = NewsFeedArtist(id: 1,
                                    name: "Laurent Garnier",
                                    latestRelease: NewsFeedLatestRelease.one)
    
    static let list = [
        NewsFeedArtist(id: 1,
                       name: "Laurent Garnier",
                       latestRelease: NewsFeedLatestRelease.one),
        NewsFeedArtist(id: 2,
                       name: "Eric Prydz",
                       latestRelease: NewsFeedLatestRelease.one),
        NewsFeedArtist(id: 3,
                       name: "Parov Stelar",
                       latestRelease: NewsFeedLatestRelease.one)
    ]
}
