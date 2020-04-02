//
//  DeletedPageResponse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/3/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public struct DeletedPageResponse: Decodable {
    public let status: String
    public let message: String
}
