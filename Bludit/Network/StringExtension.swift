//
//  StringExtension.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/4/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

extension String {
    var convertedForTheAPIRequest: String {
        return self.lowercased().replacingOccurrences(of: " ", with: "-")
    }
}
