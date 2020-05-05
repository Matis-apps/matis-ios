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
    @EnvironmentObject private var newsViewModel: NewsViewModel
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            ZStack {
                if !newsViewModel.news.isEmpty {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack(alignment: .leading) {
                            ForEach(newsViewModel.news) {
                                Text("\($0.creator.name)")
                            }
                        }
                    }
                } else {
                    Text("Chargement ...")
                }
            }
            .navigationBarTitle("Fil d'actualités")
        }
        .onAppear {
            self.newsViewModel.fetchNews()
        }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
            .environmentObject(NewsViewModel(news: News.list))
    }
}
