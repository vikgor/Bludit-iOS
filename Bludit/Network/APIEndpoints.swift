//
//  APIEndpoints.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public enum APIEndpoints: String {
    //fix the slashes in host name
    case pages = "/1/bludit/api/pages"
    case tags = "/1/bludit/api/tags"
    case categories = "/1/bludit/api/categories"
    case settings = "/1/bludit/api/settings"
    case users = "/1/bludit/api/users"
    case files = "/1/bludit/api/files"
    
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
