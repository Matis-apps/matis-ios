//
//  ImageService.swift
//  Matis
//
//  Created by Maxime Maheo on 03/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Combine
import UIKit

final class ImageService {
    
    // MARK: - Properties
    static let shared = ImageService()
    
    private let apiRequester = ApiRequester()
    
    // MARK: - Lifecycle
    private init() { }
    
    // MARK: - Methods
    func getImage(from path: String) -> AnyPublisher<UIImage?, Error> {
        apiRequester.fetch(ImageEndpoint(), with: path)
    }
    
}
