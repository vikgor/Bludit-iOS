//
//  FindPageResponse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public struct FindPageResponse: Decodable {
    public let status: String
    public let message: String
    public let data: PageDetails
}
