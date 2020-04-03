//
//  MainViewController.swift
//  Bludit
//
//  Created by Viktor Gordienko on 4/3/20.
//  Copyright © 2020 Viktor Gordienko. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    private let bluditAPI = BluditAPI()
    private var pages: [PageDetails]?
    private let refreshControl = UIRefreshControl()

    let pagesTable: UITableView = {
        let pages = UITableView()
        pages.translatesAutoresizingMaskIntoConstraints = false
        return pages
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPages()
        
        setUpNavigation()
        setUpSearchbar()
        setUpTableView()
    }
    
    //MARK: - Set up UI
    func setUpNavigation() {
        self.navigationItem.title = "Pages"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpSearchbar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    func setUpTableView() {
        pagesTable.delegate = self
        pagesTable.dataSource = self
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
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
        pagesTable.refreshControl = refreshControl
    }
    
    @objc func refresh(sender: AnyObject) {
        loadPages()
        print("refreshed")
        pagesTable.reloadData()
        pagesTable.refreshControl?.endRefreshing()
    }
    
    func loadPages() {
        bluditAPI.listPages() { listPagesResponse in
            self.pages = listPagesResponse?.data
            self.setupTableView()
        }
    }

}

extension MainViewController: UITableViewDataSource {
    
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
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            bluditAPI.findPage(query: text) { foundPageResponse in
                self.pages = Array(arrayLiteral: foundPageResponse!.data)
                self.setupTableView()
            }
        }
        else {
            loadPages()
        }
        self.pagesTable.reloadData()
    }
}
