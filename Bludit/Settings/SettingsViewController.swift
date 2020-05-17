//
//  SettingsViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/3/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    //MARK: - Setting up VIP cycle (Clean Swift)
    var interactor: SettingsInteractor = SettingsInteractor()
    func setupVIP() {
        let presenter = SettingsPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
    }
    
    //MARK: - Set up TableView cells
    /// Title
    let titleCell = UITableViewCell()
    let titleLabel = CellLabel()
    let titleTextField = TextFieldInCell()
    /// Slogan
    let sloganCell = UITableViewCell()
    let sloganLabel = CellLabel()
    let sloganTextField = TextFieldInCell()
    /// Description
    let descriptionCell = UITableViewCell()
    let descriptionLabel = CellLabel()
    let descriptionTextField = TextFieldInCell()
    /// Footer
    let footerCell = UITableViewCell()
    let footerLabel = CellLabel()
    let footerTextField = TextFieldInCell()
    /// Website
    let websiteCell = UITableViewCell()
    let websiteLabel = CellLabel()
    let websiteTextField = TextFieldInCell()
    /// API Token
    let apiTokenCell = UITableViewCell()
    let apiTokenLabel = CellLabel()
    let apiTokenTextField = TextFieldInCell()
    /// Auth Token
    let authTokenCell = UITableViewCell()
    let authTokenLabel = CellLabel()
    let authTokenTextField = TextFieldInCell()
    /// Log Out
    let logoutCell = UITableViewCell()
    let logoutButton: UIButton = {
        let logout = UIButton()
        logout.setTitleColor(.systemRed, for: .normal)
        logout.setTitle("Log out", for: .normal)
        logout.addTarget(self,
                         action: #selector(logoutButtonPressed),
                         for: .touchUpInside)
        logout.translatesAutoresizingMaskIntoConstraints = false
        return logout
    }()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVIP()
        
        interactor.setupNavigation()
        interactor.setupLayout()
        interactor.setupDelegates()
        interactor.fetchCurrentSettings()
    }
    
    //MARK: - Button logic
    /// Log out button  logic
    @objc private func logoutButtonPressed(sender: UIButton) {
        interactor.logoutButtonPressed(sender: sender)
    }
    
    /// Save current settings
    @objc func saveSettings() {
        interactor.saveSettings(title: titleTextField.text,
                                slogan: sloganTextField.text,
                                description: descriptionTextField.text,
                                footer: footerTextField.text,
                                website: websiteTextField.text,
                                apiToken: apiTokenTextField.text,
                                authToken: authTokenTextField.text)
    }
    
}

//MARK: - Set up TableView
extension SettingsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    /// Setting up sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return 3
        case 2:
            return 1
        default:
            fatalError()
        }
    }
    
    /// Setting up cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return titleCell
            case 1:
                return sloganCell
            case 2:
                return descriptionCell
            case 3:
                return footerCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return websiteCell
            case 1:
                return apiTokenCell
            case 2:
                return authTokenCell
            default:
                fatalError()
            }
        case 2:
            return logoutCell
        default:
            fatalError()
        }
    }
    
    /// Section titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "General"
        case 1:
            return "API"
        case 2:
            return nil
        default:
            fatalError()
        }
    }
    
    /// Tapping on a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /// Deselect any row
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

//MARK: - Delegate UITextField
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
