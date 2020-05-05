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
        news.removeAll()
        
        fetchUserPlaylists()
            .combineLatest(fetchUserArtistsLatestRelease())
            .receive(on: DispatchQueue.main)
            .sink { (playlistNews, latestReleaseNews) in
                self.news = (playlistNews + latestReleaseNews).sorted(by: { $0.udpatedAt > $1.udpatedAt })
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Methods
    private func fetchUserPlaylists() -> AnyPublisher<[News], Never> {
        DeezerService
            .shared
            .getUserPlaylists(userId: 2828675864)
            .map { self.convert(playlists: $0) }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    private func fetchUserArtistsLatestRelease() -> AnyPublisher<[News], Never> {
        fetchUserArtistsLatestRelease(userId: 2828675864)
            .replaceError(with: [])
            .eraseToAnyPublisher()
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
    
    private func convert(artist: DeezerArtist, album: DeezerAlbum) -> News? {
        guard let releaseDate = album.releaseDate else { return nil }
        
        return News(id: album.id,
                    title: album.title,
                    creator: NewsCreator(id: artist.id,
                                         name: artist.name,
                                         avatarPath: artist.avatarPath),
                    posterPath: album.posterPath,
                    udpatedAt: releaseDate)
    }
    
    private func getLatestAlbumReleased(albums: [DeezerAlbum]) -> DeezerAlbum? {
        albums
            .min(by: {
                guard
                    let firstAlbumReleaseDate = $0.releaseDate,
                    let secondAlbumReleaseDate = $1.releaseDate
                else { return false }
                
                return firstAlbumReleaseDate > secondAlbumReleaseDate
            })
    }
    
    private func fetchUserArtistsLatestRelease(userId: Int) -> AnyPublisher<[News], Error> {
        let subject = PassthroughSubject<[News], Error>()
        var newsDownloaded = [News]()
        var nbNewsToDownload = 0
        
        return subject
            .handleEvents(receiveSubscription: { [weak self] (_) in
                guard let self = self else { return }
                
                DeezerService
                    .shared
                    .getUserFavoriteArtists(userId: 2828675864)
                    .replaceError(with: [])
                    .sink(receiveValue: { (artists) in
                        nbNewsToDownload = artists.count
                        
                        artists
                            .forEach { [weak self] (artist) in
                                guard let self = self else { return }
                                
                                DeezerService
                                    .shared
                                    .getArtistAlbums(artistId: artist.id)
                                    .compactMap { self.getLatestAlbumReleased(albums: $0) }
                                    .compactMap { self.convert(artist: artist, album: $0) }
                                    .sink(receiveCompletion: { (completion) in
                                        switch completion {
                                        case .failure:
                                            nbNewsToDownload -= 1
                                        case .finished:
                                            break
                                        }
                                        
                                        if nbNewsToDownload == newsDownloaded.count {
                                            subject.send(newsDownloaded)
                                        }
                                    }, receiveValue: { (news) in
                                        newsDownloaded.append(news)
                                    })
                                    .store(in: &self.cancellables)
                            }
                    })
                    .store(in: &self.cancellables)
            })
            .eraseToAnyPublisher()
    }
    
}
