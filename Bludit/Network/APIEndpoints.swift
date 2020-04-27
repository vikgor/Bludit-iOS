//
//  APIEndpoints.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public enum APIEndpoints: String {
    case pages = "/api/pages"
    case tags = "/api/tags"
    case categories = "/api/categories"
    case settings = "/api/settings"
    case users = "/api/users"
    case files = "/api/files"
    case images = "/api/images"
    
    // (GET) /api/pages
    // (GET) /api/pages/<key>
    // (PUT) /api/pages/<key>
    // (DELETE) /api/pages/<key>
    // (POST) /api/pages
    // (GET) /api/settings
    // (PUT) /api/settings
    // (POST) /api/images
    // (GET) /api/tags
    // (GET) /api/tags/<key>
    // (GET) /api/categories
    // (GET) /api/categories/<key>
    // (GET) /api/users
    // (GET) /api/users/<username>
    // (GET) /api/files/<page-key>
}
