//
//  NewsViewModel.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Combine
import Foundation

final class NewsViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var news: [News]
     
    // MARK: - Lifecycle
    init(news: [News] = []) {
        self.news = news
    }
    
    // MARK: - Methods
    func fetchNews() {
        
    }
    
}
