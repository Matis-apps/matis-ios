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
    @Published var favoriteArtists: [NewsFeedArtist]
 
    private var cancellables = Set<AnyCancellable>()
    private let deezerService = DeezerService()
    
    // MARK: - Lifecycle
    init(favoriteArtists: [NewsFeedArtist] = []) {
        self.favoriteArtists = favoriteArtists
    }
    
    // MARK: - Methods
    func fetchUserFavoriteArtists() {
        deezerService
            .getUserFavoriteArtists(userId: 2828675864)
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .map {
                $0
                    .map { NewsFeedArtist(id: $0.id, name: $0.name, avatarPath: $0.avatarPath, latestRelease: nil) }
                    .sorted(by: { $0.name < $1.name })
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.favoriteArtists, on: self)
            .store(in: &cancellables)
    }
    
//    func fetchLatestRelease(for artist: NewsFeedArtist) {
//        guard let index = favoriteArtists.firstIndex(where: { $0.id == artist.id }) else { return }
//
//        deezerService
//            .getArtistAlbums(artistId: artist.id)
//            .replaceError(with: [])
//            .eraseToAnyPublisher()
//            .map { $0.min(by: { $0.releaseDateComputed ?? Date() > $1.releaseDateComputed ?? Date() }) }
//            .map { $0 != nil ? NewsFeedLatestRelease(id: $0!.id, name: $0!.title, releaseDate: $0!.releaseDateComputed ?? Date()) : nil }
//            .receive(on: DispatchQueue.main)
//            .sink { self.favoriteArtists[index].latestRelease = $0 }
//            .store(in: &cancellables)
//    }
    
}
