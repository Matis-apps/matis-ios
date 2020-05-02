//
//  NewsFeedArtistLatestReleaseComponent.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct NewsFeedArtistLatestReleaseComponent: View {
    
    // MARK: - Properties
    @EnvironmentObject private var newsFeedViewModel: NewsFeedViewModel

    var artist: NewsFeedArtist
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(artist.name)
                .font(.headline)
            
            HStack {
                Text("Latest release:")
                    .font(.subheadline)
                
                Text(artist.latestRelease?.name ?? "none")
            }
            
            if artist.latestRelease != nil {
                if artist.latestRelease!.daysBetweenReleaseDateAndNow > 30 {
                    Text("\(artist.latestRelease!.releaseDate.format())")
                } else {
                    Text("\(artist.latestRelease!.daysBetweenReleaseDateAndNow) days ago.")
                }
            } else {
                Text("Unknown")
            }
        }
        .onAppear { self.newsFeedViewModel.fetchLatestRelease(for: self.artist) }
    }
}

struct NewsFeedArtistLatestReleaseComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedArtistLatestReleaseComponent(artist: NewsFeedArtist.one)
    }
}
