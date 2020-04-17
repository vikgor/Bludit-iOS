//
//  EditPageViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/17/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class EditPageViewController: UIViewController {
    
    private let bluditAPI = BluditAPI()
    private let tableView = UITableView()
    private var pageTitle = ""
    private var pageTags = ""
    private var pageContents = ""
    var pageKey = ""
    var initialPageTitle = ""
    var initialPageTags = ""
    var initialPageContents = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
    }
    
    //MARK: - Set up UI
    private func setupNavigation() {
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Edit page"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let cacnelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let createButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = cacnelButton
        navigationItem.rightBarButtonItem = createButton
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.isScrollEnabled = false
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
        if nothingChanged() {
            self.dismiss(animated: true, completion: nil)
        } else {
            showActionSheetForCancel()
        }
    }
    
    /// Edit page
    @objc private func save() {
        if someInputsAreEmpty() {
            showActionSheetForCreate()
        } else {
            bluditAPI.editPage(pageKey: pageKey, title: pageTitle, tags: pageTags, content: pageContents)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    private func showActionSheetForCancel() {
        let alertController = UIAlertController(title: "There are unsaved changes", message: nil, preferredStyle: .actionSheet)
        let  quitButton = UIAlertAction(title: "Quit Editing", style: .destructive, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(quitButton)
        alertController.addAction(cancelButton)
        self.navigationController?.present(alertController, animated: true, completion: nil)
    }
    
    private func showActionSheetForCreate() {
        let alertController = UIAlertController(title: "Some fields are empty", message: "Would you like to save it as draft?", preferredStyle: .actionSheet)
        let  createButton = UIAlertAction(title: "Create Page", style: .default, handler: { (action) -> Void in
            self.bluditAPI.createPage(title: self.pageTitle, tags: self.pageTags, content: self.pageContents, type: "published")
            self.dismiss(animated: true, completion: nil)
        })
        let sendButton = UIAlertAction(title: "Save Draft", style: .default, handler: { (action) -> Void in
            self.bluditAPI.createPage(title: self.pageTitle, tags: self.pageTags, content: self.pageContents, type: "draft")
            self.dismiss(animated: true, completion: nil)
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
        })
        alertController.addAction(createButton)
        alertController.addAction(sendButton)
        alertController.addAction(cancelButton)
        self.navigationController?.present(alertController, animated: true, completion: nil)
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
    
    ///Check if nothing changed
    private func nothingChanged() -> Bool {
        getTextFromInputs()
        if ((pageTitle != initialPageTitle) || (pageContents != initialPageContents) || (pageTags != initialPageTags)) {
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
        if let pageTitle = cellTitle.textField?.text {
            self.pageTitle = pageTitle
        }
        if let pageTags = cellTags.textField?.text {
            self.pageTags = pageTags
        }
        if let pageContents = cellContents.textView?.text {
            self.pageContents = pageContents
        }
    }
    
}

extension EditPageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = TextFieldInTableViewCell(style: .default,
                                                reuseIdentifier: "cell",
                                                placeholder: "Page title",
                                                text: initialPageTitle)
            return cell
        case 1:
            let cell = TextFieldInTableViewCell(style: .default,
                                                reuseIdentifier: "cell",
                                                placeholder: "Page tags (optional, separated)",
                                                text: initialPageTags)
            return cell
        default:
            let cell = TextViewInTableViewCell(style: .default,
                                               reuseIdentifier: "cell",
                                               text: initialPageContents)
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 2:
            return self.tableView.bounds.size.height - tableView.rowHeight
        default:
            return tableView.rowHeight
        }
    }
    
    
}

extension EditPageViewController: UITableViewDelegate { }

extension EditPageViewController: UITextViewDelegate { }

extension EditPageViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) { }
    func textFieldDidEndEditing(_ textField: UITextField) { }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{ return true }
}
