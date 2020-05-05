//
//  WebImage.swift
//  Matis
//
//  Created by Maxime Maheo on 03/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct WebImage: View {
    
    // MARK: - Properties
    @ObservedObject var imageLoader: ImageLoader
    @State private var isLoaded: Bool = false
    var size: CGSize?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .renderingMode(.original)
                    .frame(width: size?.width, height: size?.height)
                    .opacity(isLoaded ? 1 : 0.1)
                    .animation(.easeInOut)
                    .onAppear { self.isLoaded = true }
            } else {
                Rectangle()
                .foregroundColor(.gray)
                .cornerRadius(4)
                .frame(width: size?.width, height: size?.height)
                .opacity(0.3)
            }
         }
    }
}

struct WebImage_Previews: PreviewProvider {
    static var previews: some View {
        WebImage(imageLoader: ImageLoaderCache.shared.loaderFor(path: NewsCreator.one.avatarPath),
                 size: CGSize(width: 100, height: 100))
    }
}
