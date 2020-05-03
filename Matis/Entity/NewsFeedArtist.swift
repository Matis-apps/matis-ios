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
    let avatarPath: String
    let latestRelease: NewsFeedLatestRelease
}

extension NewsFeedArtist {
    static let one = NewsFeedArtist(id: 1,
                                    name: "Laurent Garnier",
                                    avatarPath: "https://cdns-images.dzcdn.net/images/artist/511518a2ad9350f1c4cc53a33250dd68/500x500-000000-80-0-0.jpg",
                                    latestRelease: NewsFeedLatestRelease.one)
    
    static let list = [
        NewsFeedArtist(id: 1,
                       name: "Laurent Garnier",
                       avatarPath: "https://cdns-images.dzcdn.net/images/artist/511518a2ad9350f1c4cc53a33250dd68/500x500-000000-80-0-0.jpg",
                       latestRelease: NewsFeedLatestRelease.one),
        NewsFeedArtist(id: 2,
                       name: "Eric Prydz",
                       avatarPath: "https://cdns-images.dzcdn.net/images/artist/a5155d0d598721e59460aafc199972fb/500x500-000000-80-0-0.jpg",
                       latestRelease: NewsFeedLatestRelease.one),
        NewsFeedArtist(id: 3,
                       name: "Parov Stelar",
                       avatarPath: "https://cdns-images.dzcdn.net/images/artist/4e7af3a92bf2df785d210fd9690e4c2e/500x500-000000-80-0-0.jpg",
                       latestRelease: NewsFeedLatestRelease.one)
    ]
}
