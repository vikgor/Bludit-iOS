//
//  SettingsTextField.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/25/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

final class SettingsTextField: UITableViewController {

    private var navigationTitle: String? = nil
    
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
    public init(style: UITableView.Style, navigationTitle: String) {
        super.init(style: style)
        self.navigationTitle = navigationTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupLayout()
        titleTextField.delegate = self
        titleTextField.becomeFirstResponder()
    }
    
    
    //MARK: - Set up UI
    private func setupNavigation() {
        navigationItem.title = navigationTitle
//        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupLayout() {
        /// Setting up the tableView
        self.tableView = UITableView(frame: CGRect.zero, style: .grouped)
        
        /// Adding the cells
        view.addSubview(titleCell)
        
        /// Setting up the cells
        titleCell.addSubview(titleTextField)
        
        /// Scroll view constraints
        NSLayoutConstraint.activate([
            titleTextField.leadingAnchor.constraint(equalTo: titleCell.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: titleCell.trailingAnchor, constant: 20),
            titleTextField.centerYAnchor.constraint(equalTo: titleCell.centerYAnchor)
        ])
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    /// Setting up cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return titleCell
            default:
                fatalError()
            }
        default:
            fatalError()
        }
    }
    
    /// Section titles
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "General"
        default:
            fatalError()
        }
    }
    
}

//MARK: - Delegate UITextField
extension SettingsTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
