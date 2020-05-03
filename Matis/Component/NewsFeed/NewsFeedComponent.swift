//
//  NewsFeedComponent.swift
//  Matis
//
//  Created by Maxime Maheo on 03/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct NewsFeedComponent: View {
    
    // MARK: - Properties
    @EnvironmentObject private var newsFeedViewModel: NewsFeedViewModel
    
    var artist: NewsFeedArtist
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            NewsFeedUserProfileHeaderComponent(avatarPath: artist.avatarPath,
                                               name: artist.name)
            
            artist.latestRelease.map {
                NewsFeedLatestReleaseComponent(latestRelease: $0)
            }
        }
        .padding()
        .onAppear {
            if self.artist.latestRelease == nil {
                self.newsFeedViewModel.fetchLatestRelease(for: self.artist)
            }
        }
    }
}

struct NewsFeedComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedComponent(artist: NewsFeedArtist.one)
            .environmentObject(NewsFeedViewModel(favoriteArtists: NewsFeedArtist.list))
    }
}
