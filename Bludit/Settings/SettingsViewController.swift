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
    
    private let firstNameCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let lastNameCell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "First name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let feedbackCell: UITableViewCell = {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Feedback"
        cell.accessoryType = .disclosureIndicator
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
        label.text = "Switch"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let onOffSwitch: UISwitch = {
        let onOff = UISwitch()
        onOff.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        onOff.translatesAutoresizingMaskIntoConstraints = false
        return onOff
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLayout()
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
        
        ///Adding the cells
        view.addSubview(firstNameCell)
        view.addSubview(lastNameCell)
        view.addSubview(feedbackCell)
        view.addSubview(checkmarkCell)
        view.addSubview(switchCell)
        
        ///Setting up the cells
        firstNameCell.addSubview(firstNameTextField)
        lastNameCell.addSubview(lastNameTextField)
        switchCell.addSubview(switchLabel)
        switchCell.addSubview(onOffSwitch)
        
        ///Scroll view constraints
        NSLayoutConstraint.activate([
            firstNameTextField.leadingAnchor.constraint(equalTo: firstNameCell.leadingAnchor, constant: 20),
            firstNameTextField.trailingAnchor.constraint(equalTo: firstNameCell.trailingAnchor, constant: 20),
            firstNameTextField.centerYAnchor.constraint(equalTo: firstNameCell.centerYAnchor),
            lastNameTextField.leadingAnchor.constraint(equalTo: lastNameCell.leadingAnchor, constant: 20),
            lastNameTextField.trailingAnchor.constraint(equalTo: lastNameCell.trailingAnchor, constant: 20),
            lastNameTextField.centerYAnchor.constraint(equalTo: lastNameCell.centerYAnchor),
            switchLabel.leadingAnchor.constraint(equalTo: switchCell.leadingAnchor, constant: 20),
            switchLabel.centerYAnchor.constraint(equalTo: switchCell.centerYAnchor),
            onOffSwitch.trailingAnchor.constraint(equalTo: switchCell.trailingAnchor, constant: -20),
            onOffSwitch.centerYAnchor.constraint(equalTo: switchCell.centerYAnchor)
        ])
    }
    
    @objc private func saveSettings() {
//     extremeFriendly": true
        let markdownParserSwitch = onOffSwitch.isOn
        let updatedSettings = ["markdownParser": markdownParserSwitch]
        bluditAPI.editSettings(updatedSettings: updatedSettings)
    }
    
    @objc private func handleSwitch(sender: UISwitch) {
        print("Switch triggered")
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 1
        case 2:
            return 2
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return firstNameCell
            case 1:
                return lastNameCell
            default:
                fatalError()
            }
        case 1:
            switch indexPath.row {
            case 0:
                return feedbackCell
            default:
                fatalError()
            }
        case 2:
            switch indexPath.row {
            case 0:
                return checkmarkCell
            case 1:
                return switchCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Profile"
        case 1:
            return "Contact"
        case 2:
            return "More stuff"
        default:
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: false)
            if checkmarkCell.accessoryType == .none {
                checkmarkCell.accessoryType = .checkmark
            } else {
                checkmarkCell.accessoryType = .none
            }
        }
    }
    
}
