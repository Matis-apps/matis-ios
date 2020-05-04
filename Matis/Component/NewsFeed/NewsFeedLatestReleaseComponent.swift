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
            
            releaseDateMake()
            
            Text(latestRelease.name)
                .font(.headline)
            
            WebImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: latestRelease.posterPath),
                     size: CGSize(width: 150, height: 150))
                .cornerRadius(4)
        }
    }
    
    private func releaseDateMake() -> some View {
        let releaseDateString = latestRelease.daysBetweenReleaseDateAndNow <= 0 ? "Dans" : "Il y a"
        let daysString = latestRelease.daysBetweenReleaseDateAndNow == 0 ? "jour" : "jours"
        let days = abs(latestRelease.daysBetweenReleaseDateAndNow)
        
        return Text("\(releaseDateString) \(days) \(daysString)")
            .font(.caption)
            .foregroundColor(.gray)
    }
}

struct NewsFeedLatestReleaseComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedLatestReleaseComponent(latestRelease: NewsFeedLatestRelease.one)
    }
}
