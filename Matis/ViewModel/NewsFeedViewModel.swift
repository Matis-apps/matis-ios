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
    
    // MARK: - Lifecycle
    init(favoriteArtists: [NewsFeedArtist] = []) {
        self.favoriteArtists = favoriteArtists
    }
    
    // MARK: - Methods
    func fetchUserFavoriteArtists() {
        favoriteArtists.removeAll()

        DeezerService.shared
            .getUserFavoriteArtists(userId: 2828675864)
            .map { $0.map { self.fetchLatestRelease(from: $0) } }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (_) in
                
            }, receiveValue: { (publishers) in
                var nbOfArtistsToDownload = publishers.count
                var artistsDownloaded = [NewsFeedArtist]()
                
                publishers.forEach { [weak self] (publisher) in
                    guard let self = self else { return }
                    
                    publisher.sink(receiveCompletion: { [weak self] (completion) in
                        switch completion {
                        case .failure:
                            nbOfArtistsToDownload -= 1
                            
                            if nbOfArtistsToDownload == artistsDownloaded.count {
                                self?.favoriteArtists.append(contentsOf: artistsDownloaded.sorted(by: { $0.latestRelease.releaseDate > $1.latestRelease.releaseDate }))
                            }
                        case .finished:
                            break
                        }
                    }, receiveValue: { [weak self] (newsFeedArtist) in
                        if let newsFeedArtist = newsFeedArtist {
                            artistsDownloaded.append(newsFeedArtist)
                        } else {
                            nbOfArtistsToDownload -= 1
                        }
                        
                        if nbOfArtistsToDownload == artistsDownloaded.count {
                            self?.favoriteArtists.append(contentsOf: artistsDownloaded.sorted(by: { $0.latestRelease.releaseDate > $1.latestRelease.releaseDate }))
                        }
                    })
                    .store(in: &self.cancellables)
                }
            })
            .store(in: &cancellables)
    }
    
    private func fetchLatestRelease(from artist: DeezerArtist) -> AnyPublisher<NewsFeedArtist?, Error> {
        DeezerService.shared
            .getArtistAlbums(artistId: artist.id)
            .map { $0.min(by: { $0.releaseDate.toDate() ?? Date() > $1.releaseDate.toDate() ?? Date() }) }
            .map { (deezerAlbum) in
                guard
                    let deezerAlbum = deezerAlbum,
                    let albumReleaseDate = deezerAlbum.releaseDate.toDate(format: "yyyy-MM-dd")
                else { return nil }
                
                return NewsFeedArtist(id: artist.id,
                                      name: artist.name,
                                      avatarPath: artist.avatarPath,
                                      latestRelease: NewsFeedLatestRelease(id: deezerAlbum.id,
                                                                           name: deezerAlbum.title,
                                                                           posterPath: deezerAlbum.posterPath,
                                                                           releaseDate: albumReleaseDate))
            }
            .eraseToAnyPublisher()
    }
        
}
