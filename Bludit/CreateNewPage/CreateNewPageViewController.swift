//
//  CreateNewPageViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/4/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class CreateNewPageViewController: UIViewController {

    private let bluditAPI = BluditAPI()
    private let tableView = UITableView()
    private var pageTitle: String? = nil
    private var pageTags: String? = nil
    private var pageContents: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
    }
        
    //MARK: - Set up UI
    private func setupNavigation() {
        self.navigationItem.title = "Create new page"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let cacnelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let createButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(create))
        navigationItem.leftBarButtonItem = cacnelButton
        navigationItem.rightBarButtonItem = createButton
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: margins.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: margins.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: margins.leftAnchor)
        ])
    }
    
    /// Cancel creating new page
    @objc private func cancel() {
        if bothInputsAreEmpty() {
            self.dismiss(animated: true, completion: nil)
        } else {
            showActionSheetForCancel()
        }
    }
        
    /// Create new page
    @objc private func create() {
        if someInputsAreEmpty() {
            showActionSheetForCreate()
        } else {
            bluditAPI.createPage(title: pageTitle!, tags: pageTags!, content: pageContents!, type: "published")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func showActionSheetForCancel() {
        let alertController = UIAlertController()
        let  deleteButton = UIAlertAction(title: "Delete Draft", style: .destructive, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        let sendButton = UIAlertAction(title: "Save Draft", style: .default, handler: { (action) -> Void in
            self.bluditAPI.createPage(title: self.pageTitle!, tags: self.pageTags!, content: self.pageContents!, type: "draft")
            self.dismiss(animated: true, completion: nil)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(deleteButton)
        alertController.addAction(sendButton)
        alertController.addAction(cancelButton)
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }

    private func showActionSheetForCreate() {
        let alertController = UIAlertController(title: "Some fields are empty", message: "Would you like to save it as draft?", preferredStyle: .actionSheet)
        let  createButton = UIAlertAction(title: "Create Page", style: .default, handler: { (action) -> Void in
            self.bluditAPI.createPage(title: self.pageTitle!, tags: self.pageTags!, content: self.pageContents!, type: "published")
            self.dismiss(animated: true, completion: nil)
        })
        let sendButton = UIAlertAction(title: "Save Draft", style: .default, handler: { (action) -> Void in
            self.bluditAPI.createPage(title: self.pageTitle!, tags: self.pageTags!, content: self.pageContents!, type: "draft")
            self.dismiss(animated: true, completion: nil)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(createButton)
        alertController.addAction(sendButton)
        alertController.addAction(cancelButton)
        self.navigationController!.present(alertController, animated: true, completion: nil)
    }

    ///Check if both the title and contents is empty
    private func bothInputsAreEmpty() -> Bool {
        getTextFromInputs()
        if ((pageTitle != "") || (pageContents != "")) {
            return false
        } else {
            return true
        }
    }

    ///Check if either the title or contents is empty
    private func someInputsAreEmpty() -> Bool {
        getTextFromInputs()
        if ((pageTitle != "") && (pageContents != "")) {
            return false
        } else {
            return true
        }
    }
    
    private func getTextFromInputs() {
        let cellTitle = self.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TextFieldInTableViewCell
        let cellTags = self.tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextFieldInTableViewCell
        let cellContents = self.tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextViewInTableViewCell
        ///Assign text from inputs to variables=
        pageTitle = cellTitle.textField?.text
        pageTags = cellTags.textField?.text
        pageContents = cellContents.textView?.text
    }
    
}

extension CreateNewPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = TextFieldInTableViewCell(style: .default, reuseIdentifier: "cell", placeholder: "Page title")
            return cell
        case 1:
            let cell = TextFieldInTableViewCell(style: .default, reuseIdentifier: "cell", placeholder: "Page tags (optional, separated)")
            return cell
        default:
            let cell = TextViewInTableViewCell(style: .default, reuseIdentifier: "cell")
            return cell
        }
        
    }
    
    // A stupid but working workaround to make the textView cell bigger. Fix later
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            return 420
        default:
            return tableView.rowHeight
        }
    }
    
    
}

extension CreateNewPageViewController: UITableViewDelegate { }

extension CreateNewPageViewController: UITextViewDelegate { }

extension CreateNewPageViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) { }
    func textFieldDidEndEditing(_ textField: UITextField) { }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{ return true }
}
