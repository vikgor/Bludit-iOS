//
//  TabBarViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/3/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createTabBarChilds()
    }

    private func createTabBarChilds() {
        addChild(createNavController(vc: MainViewController(),
                                     title: NSLocalizedString("pages", comment: ""),
                                     image: UIImage(systemName: "list.dash")))
        addChild(createNavController(vc: DraftsViewController(),
                                     title: NSLocalizedString("drafts", comment: ""),
                                     image: UIImage(systemName: "pencil.tip")))
        addChild(createNavController(vc: ProfileViewController(),
                                     title: NSLocalizedString("profile", comment: ""),
                                     image: UIImage(systemName: "person")))
    }
    
    private func createNavController(vc: UIViewController,
                                     title: String,
                                     image: UIImage?) -> UINavigationController {
        let navController = UINavigationController(rootViewController: vc)
        navController.tabBarItem.title = title
        guard let image = image else { return navController }
        navController.tabBarItem.image = image
        navController.tabBarItem.accessibilityIdentifier = title
        
//        navController.title = "Title"
//        navController.navigationItem.title = "asd"
        
        return navController
    }

}
