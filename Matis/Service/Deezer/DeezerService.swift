//
//  DeezerService.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Combine

final class DeezerService {
    
    // MARK: - Properties
    private let apiRequester = ApiRequester()
    
    // MARK: - Methods
    func getUserFavoriteArtists(userId: Int) -> AnyPublisher<[DeezerArtist], Error> {
        apiRequester.fetch(UserFavoriteArtistsEndpoint(), with: userId)
    }
    
    func getArtistAlbums(artistId: Int) -> AnyPublisher<[DeezerAlbum], Error> {
        apiRequester.fetch(ArtistAlbumsEndpoint(), with: artistId)
    }
    
}
