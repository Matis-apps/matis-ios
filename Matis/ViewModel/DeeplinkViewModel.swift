//
//  DeeplinkViewModel.swift
//  Matis
//
//  Created by Maxime Maheo on 04/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation
import UIKit

enum DeeplinkSource {
    case deezer
}

enum DeeplinkRoute {
    case latestRelease(id: Int, source: DeeplinkSource)
}

final class DeeplinkViewModel: ObservableObject {
    
    // MARK: - Methods
    func canOpen(route: DeeplinkRoute) -> Bool {
        switch route {
        case let .latestRelease(_, source):
            switch source {
            case .deezer:
                guard let url = createDeeplinkUrl(from: route) else { return false }
                
                return UIApplication.shared.canOpenURL(url)
            }
        }
    }
 
    func open(route: DeeplinkRoute) {
        if canOpen(route: route), let url = createDeeplinkUrl(from: route) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    private func createDeeplinkUrl(from route: DeeplinkRoute) -> URL? {
        switch route {
        case let .latestRelease(id, source):
            switch source {
            case .deezer:
                return URL(string: "deezer://www.deezer.com/album/\(id)")
            }
        }
    }

}
