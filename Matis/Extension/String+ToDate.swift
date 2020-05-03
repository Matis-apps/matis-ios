//
//  String+ToDate.swift
//  Matis
//
//  Created by Maxime Maheo on 03/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

extension String {
    func toDate(format: String? = nil) -> Date? {
        let dateFormatter = DateFormatter()
        
        if format != nil {
            dateFormatter.dateFormat = format
        } else {
            dateFormatter.dateStyle = .medium
        }

        return dateFormatter.date(from: self)
    }
}
