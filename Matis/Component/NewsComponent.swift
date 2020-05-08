//
//  NewsComponent.swift
//  Matis
//
//  Created by Maxime Maheo on 05/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct NewsComponent: View {
    
    // MARK: - Properties
    @EnvironmentObject private var deeplinkViewModel: DeeplinkViewModel

    var news: News
    
    var deeplinkRoute: DeeplinkRoute {
        switch news.type {
        case .latestAlbumReleased:
            return .album(id: news.id, source: .deezer)
        case .latestPlaylistUpdated:
            return .playlist(id: news.id, source: .deezer)
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            NewsHeaderComponent(avatarPath: news.creator.avatarPath,
                                creatorName: news.creator.name,
                                date: news.udpatedAt)
                 
            NewsContentComponent(title: news.title,
                                 posterPath: news.posterPath)
            
            if deeplinkViewModel.canOpen(route: deeplinkRoute) {
                Button(action: {
                    self.deeplinkViewModel.open(route: self.deeplinkRoute)
                }, label: {
                    Text("")
                })
            }
        }
        .padding(.bottom, 16)
    }
}

struct NewsComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsComponent(news: News.one)
            .environmentObject(DeeplinkViewModel())
    }
}
