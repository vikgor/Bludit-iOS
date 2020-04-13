//
//  StringExtension.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/4/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

///Adds dash between words in a string for the correct API request
extension String {
    var convertedForTheAPIRequest: String {
        return self.lowercased().replacingOccurrences(of: " ", with: "-")
    }
}

///Converts HTML string to a `NSAttributedString`
extension String {
    var htmlAttributedString: NSAttributedString? {
        return try? NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
    }
}
