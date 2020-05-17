//
//  SettingsInteractor.swift
//  Bludit
//
//  Created by Viktor Gordienko on 5/17/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

final class SettingsInteractor {
    
    /// VIP Cycle
    var presenter = SettingsPresenter()
    
     //MARK: - Private Properties
    private let bluditAPI = BluditAPI()
    private var currentSettings: SettingsResponse? = nil
    private let defaults = UserDefaults.standard
    
    func setupNavigation() {
        presenter.setupNavigation()
    }
    
    func setupLayout() {
        presenter.setupLayout()
    }
    
    func setupDelegates() {
        presenter.setupDelegates()
    }
    
    /// Download current settings and set up UI elements depending on the downloaded settings
    func fetchCurrentSettings() {
        if let settings = defaults.data(forKey: "settings"),
            
            /// Getting the general settings from UserDefaults
            let decodedSettings = try? JSONDecoder().decode(SettingsResponse.self, from: settings) {
            let currentSettings = decodedSettings.data
            
            presenter.showCurrentSettings(currentSettings: currentSettings)
        }
    }
    
    /// Save current settings
    func saveSettings(title: String?,
                      slogan: String?,
                      description: String?,
                      footer: String?,
                      website: String?,
                      apiToken: String?,
                      authToken: String?) {
        /// Save general website settings and upload them
        let updatedSettings = ["title": title as Any,
                               "slogan": slogan as Any,
                               "description": description as Any,
                               "footer": footer as Any] as [String : Any]
        bluditAPI.editSettings(updatedSettings: updatedSettings)
        
        /// Save API-related settings to UserDefaults
        defaults.set(website, forKey: "website")
        defaults.set(apiToken, forKey: "apiToken")
        defaults.set(authToken, forKey: "authToken")
        
        /// Show alert
        presenter.showAlertOnSavedSettings()
    }
    
    /// Log out button  logic
    @objc func logoutButtonPressed(sender: UIButton) {
        presenter.showLoginScreen()
        deleteUserDefaults()
    }
    
    /// Delete cache
    func clearCahce() {
        //TODO: - Clear the cache
    }
    
    /// Delete User Defaults data
    func deleteUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: bundleID)
        }
    }
}
