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
            if !newsViewModel.news.isEmpty {
                List(newsViewModel.news) {
                    NewsComponent(news: $0)
                }
                .navigationBarTitle("Fil d'actualités")
            } else {
                Text("Chargement ...")
            }
        }
        .onAppear {
            self.newsViewModel.fetchNews()
        }
    }
}
