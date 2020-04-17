//
//  NewOrUpdatedPageResponse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public struct NewOrUpdatedPageResponse: Codable {
    public let status: String
    public let message: String
    public let data: UpdatedPageDetails
}

public struct UpdatedPageDetails: Codable {
    public let key: String
}
