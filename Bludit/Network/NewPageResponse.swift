//
//  NewPageResponse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public struct NewPageResponse: Decodable {
    public let status: String
    public let message: String
    public let data: NewPageDetails
}

public struct NewPageDetails: Decodable {
    public let key: String
}
