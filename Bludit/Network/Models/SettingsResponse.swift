//
//  SettingsResponse.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/17/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import Foundation

public struct SettingsResponse: Codable {
    public let status: String
    public let message: String
    public let data: SettingsDetails
}

public struct SettingsDetails: Codable {
    public let adminTheme: String
    public let autosaveInterval: Int
    public let codepen: String
    public let currentBuild: Int
    public let customFields: String
    public let dateFormat: String
    public let description: String
    public let dribbble: String
    public let emailFrom: String
    public let extremeFriendly: Bool
    public let facebook: String
    public let footer: String
    public let github: String
    public let gitlab: String
    public let homepage: String
    public let imageRelativeToAbsolute: Bool
    public let imageRestrict: Bool
    public let instagram: String
    public let itemsPerPage: Int
    public let language: String
    public let linkedin: String
    public let locale: String
    public let logo: String
    public let markdownParser: Bool
    public let mastodon: String
    public let orderBy: String
    public let pageNotFound: String
    public let slogan: String
    public let theme: String
    public let thumbnailHeight: Int
    public let thumbnailQuality: Int
    public let thumbnailWidth: Int
    public let timezone: String
    public let title: String
    public let titleFormatCategory: String
    public let titleFormatHomepage: String
    public let titleFormatPages: String
    public let titleFormatTag: String
    public let twitter: String
    public let uriBlog: String
    public let uriCategory: String
    public let uriPage: String
    public let uriTag: String
    public let url: String
    public let vk: String?
}
