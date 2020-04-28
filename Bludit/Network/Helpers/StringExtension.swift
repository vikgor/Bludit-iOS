//
//  StringExtension.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/4/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

/// Adds dash between words in a string for the correct API request
extension String {
    var convertedForTheAPIRequest: String {
        return self.lowercased().replacingOccurrences(of: " ", with: "-")
    }
}

/// Converts HTML string to a `NSAttributedString`
extension String {
    func htmlAttributedString(color: UIColor?) -> NSAttributedString? {
        let htmlTemplate = """
        <!doctype html>
        <html>
          <head>
            <style>
              body {
                color: \(color?.htmlRGBA ?? "gray");
                font-family: -apple-system;
              }
            </style>
          </head>
          <body>
            \(self)
          </body>
        </html>
        """

        guard let data = htmlTemplate.data(using: .utf16) else {
            return nil
        }

        guard let attributedString = try? NSAttributedString(
            data: data,
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil
            ) else {
            return nil
        }

        return attributedString
    }
}
