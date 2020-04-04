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
        
        setupNavigation()
        setupSearchbar()
        setupPagesTable()
    }
    
    //MARK: - Set up UI
    func setupNavigation() {
        self.navigationItem.title = "Pages"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPage))
        navigationItem.rightBarButtonItems = [add]
    }
    
    func setupSearchbar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    func setupPagesTable() {
        pagesTable.delegate = self
        pagesTable.dataSource = self
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    func setupTableView() {
        pagesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
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
    
    @objc func createPage() {
        DispatchQueue.main.async {
            let navController = UINavigationController(rootViewController: CreateNewPageViewController())
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
    }

}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = pages?[indexPath.row].title
        cell.detailTextLabel?.text = pages?[indexPath.row].contentRaw
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pagesTable.deselectRow(at: indexPath, animated: true)
        print("Page selected: \(String(describing: pages?[indexPath.row].title))")
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("Tapped accessory button at row \(indexPath.row)")
    }
    
    /// Editing the table view. Swipe to delete or adit a page.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, completion) in
            print("Deleted")
            if let query = self.pages?[indexPath.row].key {
                self.bluditAPI.deletePage(query: query)
                self.pages?.remove(at: indexPath.row)
            }
            
            completion(true)
            tableView.reloadData()
        }
        
        let editItem = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, completion) in
            print("Edited")
        }
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, editItem])
        
        return swipeActions
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            bluditAPI.findPage(query: text) { foundPageResponse in
                self.pages = Array(arrayLiteral: foundPageResponse!.data)
                self.setupTableView()
                self.pagesTable.reloadData()
            }
        }
        else {
            loadPages()
        }
        self.pagesTable.reloadData()
    }
}
