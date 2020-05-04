//
//  NewsFeedUserProfileHeaderComponent.swift
//  Matis
//
//  Created by Maxime Maheo on 03/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct NewsFeedUserProfileHeaderComponent: View {
    
    // MARK: - Properties
    var avatarPath: String?
    var name: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            WebImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: avatarPath),
                     size: CGSize(width: 40, height: 40))
                .cornerRadius(20)
            
            Text(name)
                .fontWeight(.semibold)
            
            Spacer()
        }
    }
}

struct NewsFeedUserProfileHeaderComponent_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedUserProfileHeaderComponent(avatarPath: nil,
                                           name: "Eric Prydz")
    }
}
