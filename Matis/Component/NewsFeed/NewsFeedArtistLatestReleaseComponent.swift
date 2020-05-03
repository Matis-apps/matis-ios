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
        }
    }
}

struct NewsFeedArtistLatestReleaseComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedArtistLatestReleaseComponent(artist: NewsFeedArtist.one)
    }
}
