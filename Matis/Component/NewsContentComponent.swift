//
//  NewsContentComponent.swift
//  Matis
//
//  Created by Maxime Maheo on 06/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct NewsContentComponent: View {
    
    // MARK: - Properties
    var title: String
    var posterPath: String?
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.subheadline)
            
            posterPath.map { (posterPath) in
                WebImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: posterPath))
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            }
        }
    }
}

struct NewsContentComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsContentComponent(title: News.one.title,
                             posterPath: News.one.posterPath)
    }
}
