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
    @Published var favoriteArtists: [NewsFeedArtist] {
        didSet {
            favoriteArtists
                .sort { (firstArtist, secondArtist) -> Bool in
                    guard
                        let firstLatestRelease = firstArtist.latestRelease,
                        let secondLatestRelease = secondArtist.latestRelease
                    else { return false }
                    
                    return firstLatestRelease.releaseDate > secondLatestRelease.releaseDate
                }
        }
    }
 
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    init(favoriteArtists: [NewsFeedArtist] = []) {
        self.favoriteArtists = favoriteArtists
    }
    
    // MARK: - Methods
    func fetchUserFavoriteArtists() {
        DeezerService
            .shared
            .getUserFavoriteArtists(userId: 2828675864)
            .map { $0.map { NewsFeedArtist(id: $0.id, name: $0.name, avatarPath: $0.avatarPath) } }
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .assign(to: \.favoriteArtists, on: self)
            .store(in: &cancellables)
    }
    
    func fetchLatestRelease(for artist: NewsFeedArtist) {
        DeezerService
            .shared
            .getArtistAlbums(artistId: artist.id)
            .replaceError(with: [])
            .compactMap { self.latestReleasedAlbum(albums: $0) }
            .compactMap { self.convert(album: $0) }
            .map { self.create(artist: artist, latestRelease: $0) }
            .receive(on: DispatchQueue.main)
            .sink { self.replace(artist: $0) }
            .store(in: &cancellables)
    }
    
    func fetchUserPlaylists() {
        DeezerService
            .shared
            .getUserPlaylists(userId: 2828675864)
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .sink { _ in }
            .store(in: &cancellables)
    }
    
    // MARK: - Private methods
    private func latestReleasedAlbum(albums: [DeezerAlbum]) -> DeezerAlbum? {
        albums
            .min { (firstAlbum, secondAlbum) -> Bool in
                guard
                    let firstAlbumReleaseDate = firstAlbum.releaseDate,
                    let secondAlbumReleaseDate = secondAlbum.releaseDate
                else { return false }
                
                return firstAlbumReleaseDate > secondAlbumReleaseDate
            }
    }
    
    private func convert(album: DeezerAlbum) -> NewsFeedLatestRelease? {
        guard let releaseDate = album.releaseDate else { return nil }
        
        return NewsFeedLatestRelease(id: album.id,
                                     name: album.title,
                                     posterPath: album.posterPath,
                                     releaseDate: releaseDate)
    }
    
    private func create(artist: NewsFeedArtist, latestRelease: NewsFeedLatestRelease) -> NewsFeedArtist {
        var tempArtist = artist
        tempArtist.latestRelease = latestRelease
        
        return tempArtist
    }
    
    private func replace(artist: NewsFeedArtist) {
        guard
            let favoriteArtistIndex = favoriteArtists.firstIndex(where: { $0.id == artist.id }),
            artist.latestRelease != nil
        else { return }

        var tempFavoriteArtits = favoriteArtists
        tempFavoriteArtits[favoriteArtistIndex] = artist
        
        self.favoriteArtists = tempFavoriteArtits
            
    }
}
