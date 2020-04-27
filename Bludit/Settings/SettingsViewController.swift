//
//  SettingsViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/3/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

final class SettingsViewController: UITableViewController {
    
    private let bluditAPI = BluditAPI()
    private var currentSettings: SettingsResponse? = nil
    private let defaults = UserDefaults.standard
    
    //MARK: - Set up TableView cells
    private let titleCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let sloganCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let sloganTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Slogan"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let descriptionCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Description"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let footerCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let footerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Footer"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let websiteCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let websiteTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Website domain"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let apiTokenCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let apiTokenTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "API Token"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let authTokenCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let authTokenTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Auth Token"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let feedbackCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "API"
        cell.accessoryType = .disclosureIndicator
        return cell
    }()
    
    private let feedback2Cell: UITableViewCell = {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = "Feedback2"
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = "More"
        return cell
    }()
    
    private let checkmarkCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Checkmark"
        cell.accessoryType = .checkmark
        return cell
    }()
    
    private let switchCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let switchLabel: UILabel = {
        let label = UILabel()
        label.text = "Markdown Parser"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let onOffSwitch: UISwitch = {
        let onOff = UISwitch()
        onOff.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        onOff.translatesAutoresizingMaskIntoConstraints = false
        return onOff
    }()
    
    private let logoutCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let logoutButton: UIButton = {
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
        
        fetchCurrentSettings()
        setupNavigation()
        setupLayout()
        
        titleTextField.delegate = self
        sloganTextField.delegate = self
        descriptionTextField.delegate = self
        footerTextField.delegate = self
        websiteTextField.delegate = self
        apiTokenTextField.delegate = self
        authTokenTextField.delegate = self
    }
    
    //MARK: - Set up UI
    private func setupNavigation() {
        navigationItem.title = "Settings"
        let save = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveSettings))
        navigationItem.rightBarButtonItems = [save]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupLayout() {
        /// Setting up the tableView
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.keyboardDismissMode = .interactive
        
        /// Adding the cells
        view.addSubview(titleCell)
        view.addSubview(sloganCell)
        view.addSubview(descriptionCell)
        view.addSubview(footerCell)
        
        view.addSubview(websiteCell)
        view.addSubview(apiTokenCell)
        view.addSubview(authTokenCell)
        
//        view.addSubview(feedbackCell)
//        view.addSubview(feedback2Cell)
//        view.addSubview(checkmarkCell)
//        view.addSubview(switchCell)
        
        view.addSubview(logoutCell)
        
        /// Setting up the cells
        titleCell.addSubview(titleTextField)
        sloganCell.addSubview(sloganTextField)
        descriptionCell.addSubview(descriptionTextField)
        footerCell.addSubview(footerTextField)
        
        websiteCell.addSubview(websiteTextField)
        apiTokenCell.addSubview(apiTokenTextField)
        authTokenCell.addSubview(authTokenTextField)
        
//        switchCell.addSubview(switchLabel)
//        switchCell.addSubview(onOffSwitch)
        
        logoutCell.addSubview(logoutButton)
        
        /// Scroll view constraints
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: titleCell.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: titleCell.trailingAnchor, constant: 20),
            titleTextField.centerYAnchor.constraint(equalTo: titleCell.centerYAnchor),
            sloganTextField.leadingAnchor.constraint(equalTo: sloganCell.leadingAnchor, constant: 20),
            sloganTextField.trailingAnchor.constraint(equalTo: sloganCell.trailingAnchor, constant: 20),
            sloganTextField.centerYAnchor.constraint(equalTo: sloganCell.centerYAnchor),
            descriptionTextField.leadingAnchor.constraint(equalTo: descriptionCell.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: descriptionCell.trailingAnchor, constant: 20),
            descriptionTextField.centerYAnchor.constraint(equalTo: descriptionCell.centerYAnchor),
            footerTextField.leadingAnchor.constraint(equalTo: footerCell.leadingAnchor, constant: 20),
            footerTextField.trailingAnchor.constraint(equalTo: footerCell.trailingAnchor, constant: 20),
            footerTextField.centerYAnchor.constraint(equalTo: footerCell.centerYAnchor),
            
            websiteTextField.leadingAnchor.constraint(equalTo: websiteCell.leadingAnchor, constant: 20),
            websiteTextField.trailingAnchor.constraint(equalTo: websiteCell.trailingAnchor, constant: 20),
            websiteTextField.centerYAnchor.constraint(equalTo: websiteCell.centerYAnchor),
            apiTokenTextField.leadingAnchor.constraint(equalTo: apiTokenCell.leadingAnchor, constant: 20),
            apiTokenTextField.trailingAnchor.constraint(equalTo: apiTokenCell.trailingAnchor, constant: 20),
            apiTokenTextField.centerYAnchor.constraint(equalTo: apiTokenCell.centerYAnchor),
            authTokenTextField.leadingAnchor.constraint(equalTo: authTokenCell.leadingAnchor, constant: 20),
            authTokenTextField.trailingAnchor.constraint(equalTo: authTokenCell.trailingAnchor, constant: 20),
            authTokenTextField.centerYAnchor.constraint(equalTo: authTokenCell.centerYAnchor),
            
//            switchLabel.leadingAnchor.constraint(equalTo: switchCell.leadingAnchor, constant: 20),
//            switchLabel.centerYAnchor.constraint(equalTo: switchCell.centerYAnchor),
//            onOffSwitch.trailingAnchor.constraint(equalTo: switchCell.trailingAnchor, constant: -20),
//            onOffSwitch.centerYAnchor.constraint(equalTo: switchCell.centerYAnchor),
            
            logoutButton.widthAnchor.constraint(equalTo: logoutCell.widthAnchor, constant: -40),
            logoutButton.centerYAnchor.constraint(equalTo: logoutCell.centerYAnchor),
            logoutButton.centerXAnchor.constraint(equalTo: logoutCell.centerXAnchor)
        ])
    }
    
    //MARK: - Logic
    /// Set up UI elements depending on the downloaded settings
    private func fetchCurrentSettings() {
        if let settings = defaults.data(forKey: "settings"),
            
            ///Getting the general settings from UserDefaults
            let decodedSettings = try? JSONDecoder().decode(SettingsResponse.self, from: settings) {
            let currentSettings = decodedSettings.data
            titleTextField.text = currentSettings.title
            sloganTextField.text = currentSettings.slogan
            descriptionTextField.text = currentSettings.description
            footerTextField.text = currentSettings.footer
            onOffSwitch.isOn = currentSettings.markdownParser
            
            /// Getting the API strings form UserDefaults
            websiteTextField.text = defaults.string(forKey: "website")
            apiTokenTextField.text = defaults.string(forKey: "apiToken")
            authTokenTextField.text = defaults.string(forKey: "authToken")
        }
    }
    
    /// Save current settings
    @objc private func saveSettings() {
        ///Save general website settings and upload them
        let updatedSettings = ["title": titleTextField.text as Any,
                               "slogan": sloganTextField.text as Any,
                               "description": descriptionTextField.text as Any,
                               "footer": footerTextField.text as Any,
                               "markdownParser": onOffSwitch.isOn] as [String : Any]
        bluditAPI.editSettings(updatedSettings: updatedSettings)
        
        ///Save API-related settings to UserDefaults
        defaults.set(websiteTextField.text, forKey: "website")
        defaults.set(apiTokenTextField.text, forKey: "apiToken")
        defaults.set(authTokenTextField.text, forKey: "authToken")
        
        /// Show alert
        let alert = UIAlertController(title: "Settings saved", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /// UISwitch logic
    @objc private func handleSwitch(sender: UISwitch) {
        print("Switch triggered")
    }
    
    /// Log out button  logic
    @objc private func logoutButtonPressed(sender: UIButton) {
        print("Log out button pressed")
        showLoginScreen()
        
        deleteUserDefaults()
    }
    
    private func showLoginScreen() {
        DispatchQueue.main.async {
            let newViewController = LoginViewController()
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true)
        }
    }
    
    private func clearCahce() {
        
        //TODO: - Clear the cache
        
    }
    
    private func deleteUserDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            defaults.removePersistentDomain(forName: bundleID)
        }
    }
}

//MARK: - Set up TableView
extension SettingsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
//        return 5
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
//            return 2
//        case 3:
//            return 2
//        case 4:
//            return 1
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
//            switch indexPath.row {
//            case 0:
//                return feedbackCell
//            case 1:
//                return feedback2Cell
//            default:
//                fatalError()
//            }
//        case 3:
//            switch indexPath.row {
//            case 0:
//                return checkmarkCell
//            case 1:
//                return switchCell
//            default:
//                fatalError()
//            }
//        case 4:
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
//            return "More"
//        case 3:
//            return "More stuff for later"
//        case 4:
            return nil
        default:
            fatalError()
        }
    }
    
    /// Tapping on a cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ///Deselect any row
        tableView.deselectRow(at: indexPath, animated: true)
        
        ///1st row in 4th section
        if indexPath.section == 3 && indexPath.row == 0 {
            if checkmarkCell.accessoryType == .none {
                checkmarkCell.accessoryType = .checkmark
            } else {
                checkmarkCell.accessoryType = .none
            }
        }
        ///1st row in 3rd section
        if indexPath.section == 2 && indexPath.row == 0 {
            DispatchQueue.main.async {
                let destination = SettingsTextField(style: .grouped, navigationTitle: (tableView.cellForRow(at: indexPath)?.textLabel?.text)!)
                self.navigationController?.pushViewController(destination, animated: true)
            }
        }
    }
    
}

//MARK: - Delegate UITextField
extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
