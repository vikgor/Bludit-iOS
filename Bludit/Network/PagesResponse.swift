//
//  PagesResponse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public struct PagesResponse: Decodable {
    public let status: String
    public let message: String
    public let data: [PagesDataResponse]
}

public struct PagesDataResponse: Decodable {
    public let key: String
    public let title: String
    public let content: String
    public let contentRaw: String
    public let description: String
    public let type: String
    public let slug: String
    public let date: String
    public let dateUTC: String
    public let tags: String
    public let permalink: String
    public let coverImage: Bool
    public let coverImageFilename: Bool
}
