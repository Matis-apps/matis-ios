//
//  NewsFeedViewModel.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Combine
import Foundation

final class NewsFeedViewModel: ObservableObject {
    
    // MARK: - Properties
    @Published var favoriteArtists: [DeezerArtist] = []
 
    private var apiPublisher: AnyPublisher<[DeezerArtist], Never>?
    private var apiCancellable: AnyCancellable? {
        willSet {
            apiCancellable?.cancel()
        }
    }
    
    // MARK: - Methods
    func fetchUserFavoriteArtists() {
        apiPublisher = DeezerService()
            .getUserFavoriteArtists(userId: 2828675864)
            .replaceError(with: [])
            .eraseToAnyPublisher()
        
        apiCancellable = apiPublisher?
            .receive(on: DispatchQueue.main)
            .assign(to: \.favoriteArtists, on: self)
    }
    
}
