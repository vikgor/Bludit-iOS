//
//  SettingsPresenter.swift
//  Bludit
//
//  Created by Viktor Gordienko on 5/17/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

final class SettingsPresenter {
    
    /// VIP Cycle
    weak var viewController: SettingsViewController?
    
    func setupDelegates() {
        viewController?.titleTextField.delegate = viewController
        viewController?.sloganTextField.delegate = viewController
        viewController?.descriptionTextField.delegate = viewController
        viewController?.footerTextField.delegate = viewController
        viewController?.websiteTextField.delegate = viewController
        viewController?.apiTokenTextField.delegate = viewController
        viewController?.authTokenTextField.delegate = viewController
    }
    
    //MARK: - Set up UI
    func setupNavigation() {
        viewController?.navigationItem.title = "Settings"
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: viewController, action: #selector(viewController?.saveSettings))
        viewController?.navigationItem.rightBarButtonItems = [save]
        viewController?.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupLayout() {
        
        /// Setting up the tableView
        viewController?.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        viewController?.tableView.keyboardDismissMode = .onDrag
        viewController?.tableView.keyboardDismissMode = .interactive
        
        if let vc = viewController {
            
            /// Setting up the tableView
            vc.tableView = UITableView(frame: CGRect.zero, style: .grouped)
            vc.tableView.keyboardDismissMode = .onDrag
            vc.tableView.keyboardDismissMode = .interactive
            
            /// Adding the cells
            vc.view.addSubview(vc.titleCell)
            vc.view.addSubview(vc.sloganCell)
            vc.view.addSubview(vc.descriptionCell)
            vc.view.addSubview(vc.footerCell)
            vc.view.addSubview(vc.websiteCell)
            vc.view.addSubview(vc.apiTokenCell)
            vc.view.addSubview(vc.authTokenCell)
            vc.view.addSubview(vc.logoutCell)
            
            /// Setting up the cells
            vc.titleCell.addSubview(vc.titleLabel)
            vc.titleCell.addSubview(vc.titleTextField)
            vc.sloganCell.addSubview(vc.sloganLabel)
            vc.sloganCell.addSubview(vc.sloganTextField)
            vc.descriptionCell.addSubview(vc.descriptionLabel)
            vc.descriptionCell.addSubview(vc.descriptionTextField)
            vc.footerCell.addSubview(vc.footerLabel)
            vc.footerCell.addSubview(vc.footerTextField)
            vc.websiteCell.addSubview(vc.websiteLabel)
            vc.websiteCell.addSubview(vc.websiteTextField)
            vc.apiTokenCell.addSubview(vc.apiTokenLabel)
            vc.apiTokenCell.addSubview(vc.apiTokenTextField)
            vc.authTokenCell.addSubview(vc.authTokenLabel)
            vc.authTokenCell.addSubview(vc.authTokenTextField)
            vc.logoutCell.addSubview(vc.logoutButton)
            
            /// Scroll view constraints
            NSLayoutConstraint.activate([
                vc.titleLabel.leadingAnchor.constraint(equalTo: vc.titleCell.leadingAnchor, constant: 20),
                vc.titleLabel.widthAnchor.constraint(equalTo: vc.titleCell.widthAnchor, multiplier: 0.25),
                vc.titleLabel.centerYAnchor.constraint(equalTo: vc.titleCell.centerYAnchor),
                vc.titleTextField.trailingAnchor.constraint(equalTo: vc.titleCell.trailingAnchor, constant: 20),
                vc.titleTextField.widthAnchor.constraint(equalTo: vc.titleCell.widthAnchor, multiplier: 0.75),
                vc.titleTextField.centerYAnchor.constraint(equalTo: vc.titleCell.centerYAnchor),
                vc.sloganLabel.leadingAnchor.constraint(equalTo: vc.sloganCell.leadingAnchor, constant: 20),
                vc.sloganLabel.widthAnchor.constraint(equalTo: vc.sloganCell.widthAnchor, multiplier: 0.25),
                vc.sloganLabel.centerYAnchor.constraint(equalTo: vc.sloganCell.centerYAnchor),
                vc.sloganTextField.trailingAnchor.constraint(equalTo: vc.sloganCell.trailingAnchor, constant: 20),
                vc.sloganTextField.widthAnchor.constraint(equalTo: vc.sloganCell.widthAnchor, multiplier: 0.75),
                vc.sloganTextField.centerYAnchor.constraint(equalTo: vc.sloganCell.centerYAnchor),
                vc.descriptionLabel.leadingAnchor.constraint(equalTo: vc.descriptionCell.leadingAnchor, constant: 20),
                vc.descriptionLabel.widthAnchor.constraint(equalTo: vc.descriptionCell.widthAnchor, multiplier: 0.25),
                vc.descriptionLabel.centerYAnchor.constraint(equalTo: vc.descriptionCell.centerYAnchor),
                vc.descriptionTextField.trailingAnchor.constraint(equalTo: vc.descriptionCell.trailingAnchor, constant: 20),
                vc.descriptionTextField.widthAnchor.constraint(equalTo: vc.descriptionCell.widthAnchor, multiplier: 0.75),
                vc.descriptionTextField.centerYAnchor.constraint(equalTo: vc.descriptionCell.centerYAnchor),
                vc.footerLabel.leadingAnchor.constraint(equalTo: vc.footerCell.leadingAnchor, constant: 20),
                vc.footerLabel.widthAnchor.constraint(equalTo: vc.footerCell.widthAnchor, multiplier: 0.25),
                vc.footerLabel.centerYAnchor.constraint(equalTo: vc.footerCell.centerYAnchor),
                vc.footerTextField.trailingAnchor.constraint(equalTo: vc.footerCell.trailingAnchor, constant: 20),
                vc.footerTextField.widthAnchor.constraint(equalTo: vc.footerCell.widthAnchor, multiplier: 0.75),
                vc.footerTextField.centerYAnchor.constraint(equalTo: vc.footerCell.centerYAnchor),
                vc.websiteLabel.leadingAnchor.constraint(equalTo: vc.websiteCell.leadingAnchor, constant: 20),
                vc.websiteLabel.widthAnchor.constraint(equalTo: vc.websiteCell.widthAnchor, multiplier: 0.25),
                vc.websiteLabel.centerYAnchor.constraint(equalTo: vc.websiteCell.centerYAnchor),
                vc.websiteTextField.trailingAnchor.constraint(equalTo: vc.websiteCell.trailingAnchor, constant: 20),
                vc.websiteTextField.widthAnchor.constraint(equalTo: vc.websiteCell.widthAnchor, multiplier: 0.75),
                vc.websiteTextField.centerYAnchor.constraint(equalTo: vc.websiteCell.centerYAnchor),
                vc.apiTokenLabel.leadingAnchor.constraint(equalTo: vc.apiTokenCell.leadingAnchor, constant: 20),
                vc.apiTokenLabel.widthAnchor.constraint(equalTo: vc.apiTokenCell.widthAnchor, multiplier: 0.25),
                vc.apiTokenLabel.centerYAnchor.constraint(equalTo: vc.apiTokenCell.centerYAnchor),
                vc.apiTokenTextField.trailingAnchor.constraint(equalTo: vc.apiTokenCell.trailingAnchor, constant: 20),
                vc.apiTokenTextField.widthAnchor.constraint(equalTo: vc.apiTokenCell.widthAnchor, multiplier: 0.75),
                vc.apiTokenTextField.centerYAnchor.constraint(equalTo: vc.apiTokenCell.centerYAnchor),
                vc.authTokenLabel.leadingAnchor.constraint(equalTo: vc.authTokenCell.leadingAnchor, constant: 20),
                vc.authTokenLabel.widthAnchor.constraint(equalTo: vc.authTokenCell.widthAnchor, multiplier: 0.25),
                vc.authTokenLabel.centerYAnchor.constraint(equalTo: vc.authTokenCell.centerYAnchor),
                vc.authTokenTextField.trailingAnchor.constraint(equalTo: vc.authTokenCell.trailingAnchor, constant: 20),
                vc.authTokenTextField.widthAnchor.constraint(equalTo: vc.authTokenCell.widthAnchor, multiplier: 0.75),
                vc.authTokenTextField.centerYAnchor.constraint(equalTo: vc.authTokenCell.centerYAnchor),
                vc.logoutButton.widthAnchor.constraint(equalTo: vc.logoutCell.widthAnchor, constant: -40),
                vc.logoutButton.centerYAnchor.constraint(equalTo: vc.logoutCell.centerYAnchor),
                vc.logoutButton.centerXAnchor.constraint(equalTo: vc.logoutCell.centerXAnchor),
            ])
            
        }

    }
    
    func showCurrentSettings(currentSettings: SettingsDetails) {
        
        /// Set up label titles
        viewController?.titleLabel.text = "Title"
        viewController?.sloganLabel.text = "Slogan"
        viewController?.descriptionLabel.text = "Description"
        viewController?.footerLabel.text = "Footer"
        viewController?.websiteLabel.text = "Website"
        viewController?.apiTokenLabel.text = "API Token"
        viewController?.authTokenLabel.text = "Auth Token"
        
        /// Set up placeholders
        viewController?.titleTextField.placeholder = "Title"
        viewController?.sloganTextField.placeholder = "Slogan"
        viewController?.descriptionTextField.placeholder = "Description"
        viewController?.footerTextField.placeholder = "Footer"
        viewController?.websiteTextField.placeholder = "Website"
        viewController?.apiTokenTextField.placeholder = "API Token"
        viewController?.authTokenTextField.placeholder = "Auth Token"
        
        /// Set up basic settings
        viewController?.titleTextField.text = currentSettings.title
        viewController?.sloganTextField.text = currentSettings.slogan
        viewController?.descriptionTextField.text = currentSettings.description
        viewController?.footerTextField.text = currentSettings.footer
        
        /// Get the API strings form UserDefaults
        viewController?.websiteTextField.text = UserDefaults.standard.string(forKey: "website")
        viewController?.apiTokenTextField.text = UserDefaults.standard.string(forKey: "apiToken")
        viewController?.authTokenTextField.text = UserDefaults.standard.string(forKey: "authToken")
    }
    
    func showAlertOnSavedSettings() {
        let alert = UIAlertController(title: "Settings saved", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in }))
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    /// Show Login screen when logging out
    func showLoginScreen() {
        DispatchQueue.main.async {
            let newViewController = LoginViewController()
            newViewController.modalPresentationStyle = .fullScreen
            self.viewController?.present(newViewController, animated: true)
        }
    }
    
}
