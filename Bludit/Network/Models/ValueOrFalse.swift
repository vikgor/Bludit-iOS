//
//  ValueOrFalse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/14/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

/// Helper for PageDetails.coverImage and such, where type can either be Bool or String
public struct ValueOrFalse<T:Codable>: Codable {
    public var description: String
    let value: T?
    public init(from decoder:Decoder) throws {
        let container = try decoder.singleValueContainer()
        let falseValue = try? container.decode(Bool.self)
        if falseValue == nil {
            value = try container.decode(T.self)
            description = try container.decode(T.self) as! String
        } else {
            value = nil
            description = ""
        }
    }
}
