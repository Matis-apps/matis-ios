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
    @Published var news: [News] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Methods
    func fetchNews() {
        NewsService
            .shared
            .fetchNews(userId: 2828675864)
            .receive(on: DispatchQueue.main)
            .assign(to: \.news, on: self)
            .store(in: &cancellables)
    }
}
