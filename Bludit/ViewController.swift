//
//  ViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/2/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var websiteTextField: UITextField!
    @IBOutlet weak var tokenTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let bluditAPI = BluditAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Pages:")
        getPages()
        print("Tags:")
        getTags()
    }

    
    func getPages() {
        let username = ""
        let password = ""
        bluditAPI.listPages(username: username,
                            password: password)
    }
    
    func getTags() {
        let username = ""
        let password = ""
        bluditAPI.listTags(username: username,
                           password: password)
    }
    
}

