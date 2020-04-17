//
//  CategoriesResponse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/17/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public struct CategoriesResponse: Codable {
    public let status: String
    public let message: String
    public let data: [CategoriesDetails]
}

public struct CategoriesDetails: Codable {
    public let name: String
    public let description: String
    public let template: String
    public let list: [String]
    public let key: String
}
