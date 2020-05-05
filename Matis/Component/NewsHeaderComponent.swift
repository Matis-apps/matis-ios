//
//  NewsHeaderComponent.swift
//  Matis
//
//  Created by Maxime Maheo on 05/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct NewsHeaderComponent: View {
    
    // MARK: - Properties
    var avatarPath: String?
    var creatorName: String
    var date: Date
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) {
            avatarPath.map {
                WebImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: $0),
                         size: CGSize(width: 40,
                                      height: 40))
                    .cornerRadius(20)
            }
            
            VStack(alignment: .leading) {
                Text(creatorName)
                    .font(.headline)
                
                Text(date.toString())
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
    }
}

struct NewsHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsHeaderComponent(avatarPath: NewsCreator.one.avatarPath,
                            creatorName: NewsCreator.one.name,
                            date: Date())
    }
}
