//
//  NewsFeedView.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct NewsFeedView: View {
    
    // MARK: - Properties
    @EnvironmentObject private var newsFeedViewModel: NewsFeedViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                if !newsFeedViewModel.favoriteArtists.isEmpty {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(alignment: .leading) {
                            ForEach(newsFeedViewModel.favoriteArtists) {
                                NewsFeedComponent(artist: $0)
                            }
                        }
                    }
                } else {
                    Text("Chargement ...")
                }
            }
            .navigationBarTitle("Dernières sorties")
        }
        .onAppear {
            self.newsFeedViewModel.fetchUserFavoriteArtists()
            self.newsFeedViewModel.fetchUserPlaylists()
        }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
            .environmentObject(NewsFeedViewModel(favoriteArtists: NewsFeedArtist.list))
    }
}
