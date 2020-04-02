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
        
//        bluditAPI.listPages()
//        bluditAPI.findPage(query: "find-me")
//        bluditAPI.listTags()
//        bluditAPI.createPage(title: "delete me",
//                             content:  "This page will be deleted")
        
//        bluditAPI.editPage(query: "find-me",
//                           title: "Find me (edited)",
//                           content: "Page found and edited")
        
        bluditAPI.deletePage(query: "delete-me")
    }

}

