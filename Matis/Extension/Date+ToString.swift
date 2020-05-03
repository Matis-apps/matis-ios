//
//  Date+ToString.swift
//  Matis
//
//  Created by Maxime Maheo on 02/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import Foundation

extension Date {
    func toString(format: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        
        if format != nil {
            dateFormatter.dateFormat = format
        } else {
            dateFormatter.dateStyle = .medium
        }

        return dateFormatter.string(from: self)
    }
}
