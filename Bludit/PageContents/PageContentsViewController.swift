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
    var coverImage: String = "logo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupContentView()
    }
    
    //MARK: - Set up UI
    private func setupNavigation() {
        view.backgroundColor = UIColor.systemBackground
        self.navigationItem.title = pageTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
        
    private func setupContentView() {
        
        ///Page cover image
        ///If  cover image is not set up for the page, don't show the view. Otherwise take the URL from the page details
        let coverImageView = UIImageView()
        if coverImage != "" {
            coverImageView.image = UIImage(named: coverImage)
            coverImageView.backgroundColor = UIColor.systemBackground
            coverImageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
            coverImageView.contentMode = .scaleAspectFill
            coverImageView.clipsToBounds = true
        }
        
        ///Page contents
        let pageContentsTextView = UITextView()
        pageContentsTextView.isScrollEnabled = false
        pageContentsTextView.font = UIFont.systemFont(ofSize: 16)
        pageContentsTextView.isEditable = false
        pageContentsTextView.isSelectable = true
        pageContentsTextView.text = pageContents
        
        ///Page tags
        let tagsLabel = UILabel()
        if pageTags != "" {
            tagsLabel.text  = "Tags: \(pageTags!)"
        }
        
        ///Stack View
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16.0
//        stackView.setCustomSpacing(30.0, after: tagsLabel)
        stackView.addArrangedSubview(coverImageView)
        stackView.addArrangedSubview(pageContentsTextView)
        stackView.addArrangedSubview(tagsLabel)
        
        ///Scroll View
        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)
        view.addSubview(scrollView)
        
        ///Constraints
        let margins = view.layoutMarginsGuide
        
        ///Stack view constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
                
        ///Scroll view constraints
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: margins.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor)
        ])
    }

}
