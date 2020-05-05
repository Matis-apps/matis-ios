//
//  News.swift
//  Matis
//
//  Created by Maxime Maheo on 05/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

struct News: Identifiable {
    let id: Int
    let title: String
    let creator: NewsCreator
    let posterPath: String?
    let udpatedAt: Date
}

struct NewsCreator: Identifiable {
    let id: Int
    let name: String
    let avatarPath: String?
}

extension News {
    static let one = News(id: 129932722,
                          title: "Vision EP",
                          creator: NewsCreator.list[1],
                          posterPath: "https://cdns-images.dzcdn.net/images/cover/d713bd2026a702494c953f5d748d5bfb/500x500-000000-80-0-0.jpg",
                          udpatedAt: Date())
    
    static let list = [
        News(id: 96873792,
             title: "Contrasts",
             creator: NewsCreator.list[0],
             posterPath: "https://cdns-images.dzcdn.net/images/cover/f5b18738124d8bc6785e50b0b6f02a48/500x500-000000-80-0-0.jpg",
             udpatedAt: Date()),
        News(id: 129932722,
             title: "Vision EP",
             creator: NewsCreator.list[1],
             posterPath: "https://cdns-images.dzcdn.net/images/cover/d713bd2026a702494c953f5d748d5bfb/500x500-000000-80-0-0.jpg",
             udpatedAt: Date())
    ]
}

extension NewsCreator {
    static let one = NewsCreator(id: 5384533,
                                 name: "Charlotte De Witte",
                                 avatarPath: "https://e-cdns-images.dzcdn.net/images/artist/c75f18985240b7a97c042ac54188ff68/500x500-000000-80-0-0.jpg")
    
    static let list = [
        NewsCreator(id: 6055914,
                    name: "Bellaire",
                    avatarPath: "https://e-cdns-images.dzcdn.net/images/artist/272a98a48b9acf46a15c67b3fe5be5a8/500x500-000000-80-0-0.jpg"),
        NewsCreator(id: 5384533,
                    name: "Charlotte De Witte",
                    avatarPath: "https://e-cdns-images.dzcdn.net/images/artist/c75f18985240b7a97c042ac54188ff68/500x500-000000-80-0-0.jpg")
    ]
}
