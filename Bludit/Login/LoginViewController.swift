//
//  LoginViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let bluditAPI = BluditAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        bluditAPI.listPages()
//        bluditAPI.findPage(query: "find-me")
//        bluditAPI.listTags()
//        bluditAPI.listCategories()
//        bluditAPI.createPage(title: "delete me",
//                             content:  "This page will be deleted")
//        bluditAPI.editPage(query: "find-me",
//                           title: "Find me (edited)",
//                           content: "Page found and edited")
//        bluditAPI.deletePage(query: "find-me")
        loginButton.addTarget(self,
                              action: #selector(authenticate),
                              for: UIControl.Event.touchUpInside)
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
}

extension LoginViewController: UITextFieldDelegate {
}
