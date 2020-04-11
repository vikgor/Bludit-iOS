//
//  LoginViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let bluditAPI = BluditAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testRequests()
        
        view.backgroundColor = .systemBackground
        setupSubviews()
    }
    
    private func setupSubviews() {
        
        /// Bludit label
        let label = UILabel()
        label.font = .systemFont(ofSize: 40.0)
        label.text = "BLUDIT"
        
        /// Website text field
        let websiteTextField = UITextField()
        websiteTextField.textAlignment = .left
        websiteTextField.autocapitalizationType = .none
        websiteTextField.placeholder = "Website"
        websiteTextField.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        
        /// API Token text field
        let apiTokenTextField = UITextField()
        apiTokenTextField.textAlignment = .left
        apiTokenTextField.autocapitalizationType = .none
        apiTokenTextField.placeholder = "API Token"
        apiTokenTextField.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        
        /// Login button
        let loginButton = UIButton()
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 4
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self,
                              action: #selector(authenticate),
                              for: UIControl.Event.touchUpInside)
        
        ///Stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(websiteTextField)
        stackView.addArrangedSubview(apiTokenTextField)
        stackView.addArrangedSubview(loginButton)
        stackView.layoutSubviews()
        view.addSubview(stackView)
        
        ///Constraints
        let margins = view.layoutMarginsGuide
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            //the "-50" constant moves the stackView up a little, remove it when the view goes up when the keyboard is presented
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: margins.widthAnchor),
            websiteTextField.widthAnchor.constraint(equalTo: margins.widthAnchor),
            apiTokenTextField.widthAnchor.constraint(equalTo: margins.widthAnchor),
            loginButton.widthAnchor.constraint(equalTo: margins.widthAnchor),
        ])
        stackView.spacing = 20.0
    }

    @objc func authenticate() {
        showNextScreen()
    }
    
    func showNextScreen() {
        DispatchQueue.main.async {
            let newViewController = TabBarViewController()
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true)
        }
    }
    
    /// Testing basic requests. Need it before I make a mock server and test everything properly
    func testRequests() {
//        bluditAPI.listPages() { listPagesResponse in print(listPagesResponse as Any) }
//        bluditAPI.findPage(query: "An") { foundPageResponse in print(foundPageResponse) }
//        bluditAPI.findPage(query: "Anot") { foundPageResponse in print(foundPageResponse) }
//        bluditAPI.findPage(query: "Another") { foundPageResponse in print(foundPageResponse) }
//        bluditAPI.findPage(query: "another") { foundPageResponse in print(foundPageResponse) }
//        bluditAPI.listTags()
//        bluditAPI.listCategories()
//        bluditAPI.createPage(title: "delete me",
//                             content:  "This page will be deleted")
//        bluditAPI.editPage(query: "find-me",
//                           title: "Find me (edited)",
//                           content: "Page found and edited")
//        bluditAPI.deletePage(query: "find-me")
    }
}

extension LoginViewController: UITextFieldDelegate {
}
