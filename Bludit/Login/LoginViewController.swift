//
//  LoginViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let bluditAPI = BluditAPI()
    private var websiteTextField = UITextField()
    private var apiTokenTextField = UITextField()
    private var authTokenTextField = UITextField()
    private var loginButton = UIButton()
    private let defaults = UserDefaults.standard
    
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
        websiteTextField.delegate = self
        websiteTextField.tag = 0
        websiteTextField.returnKeyType = .next
        websiteTextField.placeholder = "Website"
        websiteTextField.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        self.websiteTextField = websiteTextField
        
        /// API Token text field
        let apiTokenTextField = UITextField()
        apiTokenTextField.textAlignment = .left
        apiTokenTextField.autocapitalizationType = .none
        apiTokenTextField.delegate = self
        apiTokenTextField.tag = 1
        apiTokenTextField.returnKeyType = .done
        apiTokenTextField.placeholder = "API Token"
        apiTokenTextField.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        self.apiTokenTextField = apiTokenTextField
        
        /// Auth Token text field
        let authTokenTextField = UITextField()
        authTokenTextField.textAlignment = .left
        authTokenTextField.autocapitalizationType = .none
        authTokenTextField.delegate = self
        authTokenTextField.tag = 2
        authTokenTextField.returnKeyType = .done
        authTokenTextField.placeholder = "Auth Token"
        authTokenTextField.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
        self.authTokenTextField = authTokenTextField
        
        /// Login button
        let loginButton = UIButton()
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 4
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self,
                              action: #selector(authenticate),
                              for: .touchUpInside)
        loginButton.isEnabled = false
        loginButton.alpha = 0.5
        self.loginButton = loginButton
        
        ///Stack view
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(websiteTextField)
        stackView.addArrangedSubview(apiTokenTextField)
        stackView.addArrangedSubview(authTokenTextField)
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
            authTokenTextField.widthAnchor.constraint(equalTo: margins.widthAnchor),
            loginButton.widthAnchor.constraint(equalTo: margins.widthAnchor),
        ])
        stackView.spacing = 20.0
    }

    @objc private func authenticate() {
        defaults.set(true, forKey: "authenticated")
        defaults.set(websiteTextField.text, forKey: "website")
        defaults.set(apiTokenTextField.text, forKey: "apiToken")
        defaults.set(authTokenTextField.text, forKey: "authToken")
        
        if Reachability.isConnectedToNetwork() {
            showNextScreen()
        } else {
            let alert = UIAlertController(title: "No connection", message: "There seems to be a problem. Please check your internet connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func showNextScreen() {
        DispatchQueue.main.async {
            let newViewController = TabBarViewController()
            newViewController.modalPresentationStyle = .fullScreen
            self.present(newViewController, animated: true)
        }
    }
    
    /// Testing basic requests. Need it before I make a mock server and test everything properly
    private func testRequests() {
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
//        bluditAPI.listSettings()
//        let updatedSettings = ["title": "81371 (updated)",
//                               "github": "github.com/",
//                               "instagram": "instagram.com/",
//                               "itemsPerPage": 10] as [String : Any]
//
//        bluditAPI.editSettings(updatedSettings: updatedSettings)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            authenticate()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if websiteTextField.text == "" || apiTokenTextField.text == "" || authTokenTextField.text == "" {
            //Disable button
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
        } else {
            //Enable button
            loginButton.isEnabled = true
            loginButton.alpha = 1.0
        }
    }
}
