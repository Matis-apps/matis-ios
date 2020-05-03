//
//  ImageLoader.swift
//  Matis
//
//  Created by Maxime Maheo on 03/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

final class ImageLoaderCache {
    
    // MARK: - Properties
    static let shared = ImageLoaderCache()
    
    private var loaders: NSCache<NSString, ImageLoader> = NSCache()
    
    // MARK: - Lifecycle
    private init() { }
            
    // MARK: - Methods
    func loaderFor(path: String?) -> ImageLoader {
        let key = NSString(string: path ?? "missing")
        
        if let loader = loaders.object(forKey: key) {
            return loader
        }
        
        let loader = ImageLoader(path: path)
        loaders.setObject(loader, forKey: key)
        
        return loader
    }
}

final class ImageLoader: ObservableObject {
    
    // MARK: - Properties
    @Published var image: UIImage?
    
    private let path: String?
    
    private var cancellable: AnyCancellable? {
        willSet {
            cancellable?.cancel()
        }
    }
    
    // MARK: - Lifecycle
    init(path: String?) {
        self.path = path
        
        loadImage()
    }
    
    // MARK: - Methods
    private func loadImage() {
        guard let path = path, image == nil else { return }
        
        cancellable = ImageService
            .shared
            .getImage(from: path)
            .receive(on: DispatchQueue.main)
            .replaceError(with: nil)
            .assign(to: \.image, on: self)
    }
    
}
