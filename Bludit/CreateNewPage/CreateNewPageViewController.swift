//
//  CreateNewPageViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/4/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class CreateNewPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigation()
    }
        
    //MARK: - Set up UI
    func setUpNavigation() {
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
        print("Page created")
        self.dismiss(animated: true, completion: nil)
    }
    
}
