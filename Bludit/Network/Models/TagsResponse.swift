//
//  TagsResponse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public struct TagsResponse: Codable {
    public let status: String
    public let message: String
    public let data: [TagsDetails]
}

public struct TagsDetails: Codable {
    public let name: String
    public let list: [String]
    public let key: String
}
