//
//  CreateNewPageViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/4/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class CreateNewPageViewController: UIViewController {

    let bluditAPI = BluditAPI()
    let pageTitleTextField = UITextField()
    let pageContentsTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupStackView()
    }
        
    //MARK: - Set up UI
    func setupNavigation() {
        self.navigationItem.title = "Create new page"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let cacnelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        let createButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(create))
        navigationItem.leftBarButtonItem = cacnelButton
        navigationItem.rightBarButtonItem = createButton
    }
    
    @objc func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func create() {
        bluditAPI.createPage(title: pageTitleTextField.text!, content: pageContentsTextView.text!)
        print("Page created")
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupStackView() {
//        //Cover image
//        let coverImage = UIImageView()
//        coverImage.backgroundColor = UIColor.blue
//        coverImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
//        coverImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
//        coverImage.image = UIImage(named: "buttonFollowCheckGreen")

        //Page title
//        pageTitleTextField.borderStyle = .bezel
        pageTitleTextField.placeholder = "Page title"
//        pageTitleTextField.text = "UITextField example" //Will be needed later for the editing of an existing page

        //Page contents
        pageContentsTextView.delegate = self
        pageContentsTextView.isScrollEnabled = true
        pageContentsTextView.font = UIFont.systemFont(ofSize: 16)
        pageContentsTextView.text = "Page contents"
//        pageContentsTextView.backgroundColor = .gray
        
        //Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 16.0
//        stackView.addArrangedSubview(coverImage)
        stackView.addArrangedSubview(pageTitleTextField)
        stackView.addArrangedSubview(pageContentsTextView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(stackView)

        //Constraints
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: margins.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            pageContentsTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

extension CreateNewPageViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            self.view.endEditing(true)
            return false
        }
        return true
    }
}
