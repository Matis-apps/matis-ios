//
//  NewsFeedLatestReleaseComponent.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct NewsFeedLatestReleaseComponent: View {
    
    // MARK: - Properties
    var latestRelease: NewsFeedLatestRelease
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text("Dernière sortie")
                .font(.subheadline)
            
            Text("Il y a \(latestRelease.daysBetweenReleaseDateAndNow) jours")
                .font(.caption)
                .foregroundColor(.gray)
            
            Text(latestRelease.name)
                .font(.headline)
            
            WebImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: latestRelease.posterPath),
                     size: CGSize(width: 150, height: 150))
                .cornerRadius(4)
        }
    }
}

struct NewsFeedLatestReleaseComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedLatestReleaseComponent(latestRelease: NewsFeedLatestRelease.one)
    }
}
