//
//  NewsService.swift
//  Matis
//
//  Created by Maxime Maheo on 06/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Combine

final class NewsService {
    
    // MARK: - Properties
    static let shared = NewsService()
    
    private let apiRequester = ApiRequester()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    func fetchNews(userId: Int) -> AnyPublisher<[News], Never> {
        fetchUserPlaylists(userId: userId)
            .combineLatest(fetchUserArtistsLatestRelease(userId: userId))
            .map { ($0 + $1).sorted(by: { $0.udpatedAt > $1.udpatedAt }) }
            .map { self.filterCreatorIsNot(userId: userId, news: $0) }
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private methods
    private func filterCreatorIsNot(userId: Int, news: [News]) -> [News] {
        news.filter { $0.creator.id != userId }
    }
    
    private func fetchUserPlaylists(userId: Int) -> AnyPublisher<[News], Never> {
        DeezerService
            .shared
            .fetchUserPlaylists(userId: userId)
            .map { self.convert(playlists: $0) }
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
                     udpatedAt: $0.updatedAtDate,
                     type: .latestPlaylistUpdated)
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
                    udpatedAt: releaseDate,
                    type: .latestAlbumReleased)
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
    
    private func fetchUserArtistsLatestRelease(userId: Int) -> AnyPublisher<[News], Never> {
        let subject = PassthroughSubject<[News], Never>()
        var newsDownloaded = [News]()
        var nbNewsToDownload = 0
        
        return subject
            .handleEvents(receiveSubscription: { [weak self] (_) in
                guard let self = self else { return }
                
                DeezerService
                    .shared
                    .fetchUserFavoriteArtists(userId: 2828675864)
                    .replaceError(with: [])
                    .sink(receiveValue: { (artists) in
                        nbNewsToDownload = artists.count
                        
                        artists
                            .forEach { [weak self] (artist) in
                                guard let self = self else { return }
                                
                                DeezerService
                                    .shared
                                    .fetchArtistAlbums(artistId: artist.id)
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
