//
//  PageContentsViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/5/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class PageContentsViewController: UIViewController {
    
    var pageTitle: String? = "title"
    var pageTags: String? = "tags"
    var pageContents: String? = "contents"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupStackView()
    }
    
    //MARK: - Set up UI
    private func setupNavigation() {
        view.backgroundColor = UIColor.systemBackground
        self.navigationItem.title = pageTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
        
    private func setupStackView() {
        
        ///Page cover image
        let coverImage = UIImageView()
        coverImage.backgroundColor = UIColor.lightGray
        coverImage.heightAnchor.constraint(equalToConstant: 120.0).isActive = true
        coverImage.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        coverImage.image = UIImage(named: "imageName")
        
        ///Page tags
        let tagsLabel = UILabel()
        if pageTags != "" {
            tagsLabel.text  = "Tags: \(pageTags!)"
        }
        
        ///Page contents
        let pageContentsTextView = UITextView()
        pageContentsTextView.isScrollEnabled = true
        pageContentsTextView.font = UIFont.systemFont(ofSize: 16)
        pageContentsTextView.isEditable = false
        pageContentsTextView.isSelectable = true
        pageContentsTextView.text = pageContents
        
        ///Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.spacing = 16.0
        stackView.addArrangedSubview(coverImage)
        stackView.addArrangedSubview(tagsLabel)
        stackView.addArrangedSubview(pageContentsTextView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(stackView)
        
        ///Constraints
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: margins.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            tagsLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            tagsLabel.heightAnchor.constraint(equalToConstant: 20.0),
            pageContentsTextView.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor),
            pageContentsTextView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }

}
