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
    @Published var news: [News] {
        didSet {
            news.sort(by: { $0.udpatedAt > $1.udpatedAt })
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
     
    // MARK: - Lifecycle
    init(news: [News] = []) {
        self.news = news
    }
    
    // MARK: - Methods
    func fetchNews() {
        fetchUserPlaylists()
    }
    
    // MARK: - Methods
    private func fetchUserPlaylists() {
        DeezerService
            .shared
            .getUserPlaylists(userId: 2828675864)
            .map { self.convert(playlists: $0) }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.news, on: self)
            .store(in: &cancellables)
    }
    
    private func convert(playlists: [DeezerPlaylist]) -> [News] {
        playlists
            .map {
                News(id: $0.id,
                     title: $0.title,
                     creator: NewsCreator(id: $0.creator.id,
                                          name: $0.creator.name,
                                          avatarPath: nil),
                     posterPath: $0.posterPath,
                     udpatedAt: $0.updatedAtDate)
            }
    }
    
}
