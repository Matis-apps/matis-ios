//
//  NewsFeedLatestRelease.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

struct NewsFeedLatestRelease: Identifiable {
    let id: Int
    let name: String
    let posterPath: String
    let releaseDate: Date
    
    var daysBetweenReleaseDateAndNow: Int {
        let calendar = Calendar.current

        let date1 = calendar.startOfDay(for: releaseDate)
        let date2 = calendar.startOfDay(for: Date())

        return calendar.dateComponents([.day], from: date1, to: date2).day ?? 0
    }
}

extension NewsFeedLatestRelease {
    static let one = NewsFeedLatestRelease(id: 1,
                                           name: "Dune The Alliance EP",
                                           posterPath: "https://cdns-images.dzcdn.net/images/cover/2114b69daf077725014eef1e11b88281/500x500-000000-80-0-0.jpg",
                                           releaseDate: Date())
}
