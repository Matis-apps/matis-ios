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
    @ObservedObject private var newsFeedViewModel = NewsFeedViewModel()
    
    // MARK: - Body
    var body: some View {
        List(newsFeedViewModel.favoriteArtists) {
            Text($0.name)
        }
        .onAppear { self.newsFeedViewModel.fetchUserFavoriteArtists() }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
