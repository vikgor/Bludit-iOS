//
//  MainViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/3/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate,  UITableViewDataSource {

    let bluditAPI = BluditAPI()
    var pages: [PageDetails]?
    
    let pagesTable: UITableView = {
        let pages = UITableView()
        pages.backgroundColor = UIColor.white
        pages.translatesAutoresizingMaskIntoConstraints = false
        return pages
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPages()
        pagesTable.delegate = self
        pagesTable.dataSource = self
        pagesTable.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func loadPages() {
        bluditAPI.listPages() { listPagesResponse in
            self.pages = listPagesResponse?.data
            self.setupTableView()
        }
    }
    
    func setupTableView() {
        pagesTable.register(PagesListCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(pagesTable)
        NSLayoutConstraint.activate([
            pagesTable.topAnchor.constraint(equalTo: self.view.topAnchor),
            pagesTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            pagesTable.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            pagesTable.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pagesTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PagesListCell
//        cell.textLabel?.text = "test"
        cell.pageTitle.text = pages?[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //FIXME: Make refresh work
    @objc func refresh(sender: AnyObject) {
        loadPages()
        print("refreshed")
        pagesTable.reloadData()
        pagesTable.refreshControl?.endRefreshing()
    }

}
