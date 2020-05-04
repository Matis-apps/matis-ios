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
    @EnvironmentObject private var deeplinkViewModel: DeeplinkViewModel
    
    var latestRelease: NewsFeedLatestRelease
    
    private var deezerDeeplinkRoute: DeeplinkRoute {
        .latestRelease(id: latestRelease.id, source: .deezer)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text("Dernière sortie")
                .font(.subheadline)
            
            releaseDateMake()
            
            Text(latestRelease.name)
                .font(.headline)
            
            HStack {
                latestRelease.posterPath.map { (posterPath) in
                    WebImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: posterPath),
                             size: CGSize(width: 150, height: 150))
                        .cornerRadius(4)
                }
                
                if deeplinkViewModel.canOpen(route: deezerDeeplinkRoute) {
                    Button(action: {
                        self.deeplinkViewModel.open(route: self.deezerDeeplinkRoute)
                    }, label: {
                        Text("Ouvrir sur Deezer")
                    })
                    .frame(minHeight: 44)
                }
            }
        }
    }
    
    // MARK: - Methods
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
            .environmentObject(DeeplinkViewModel())
    }
}
