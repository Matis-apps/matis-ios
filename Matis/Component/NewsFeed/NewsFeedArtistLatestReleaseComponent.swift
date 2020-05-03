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
            NewsFeedUserProfileHeaderComponent(avatarPath: artist.avatarPath,
                                               name: artist.name)
            
            Text("Dernière sortie")
                .font(.subheadline)
            
            Text("Il y a \(artist.latestRelease.daysBetweenReleaseDateAndNow) jours")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(artist.latestRelease.name)
                .font(.headline)
            
            WebImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: artist.latestRelease.posterPath),
                     size: CGSize(width: 150, height: 150))
                .cornerRadius(4)
        }
    }
}

struct NewsFeedArtistLatestReleaseComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedArtistLatestReleaseComponent(artist: NewsFeedArtist.one)
    }
}
