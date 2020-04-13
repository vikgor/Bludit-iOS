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
    private var indicator = UIActivityIndicatorView()

    let pagesTable: UITableView = {
        let pages = UITableView()
        pages.translatesAutoresizingMaskIntoConstraints = false
        return pages
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupActivityIndicator()
        indicator.startAnimating()
        setupNavigation()
        setupSearchbar()
        setupPagesTable()
        loadPages()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        pagesTable.refreshControl = refreshControl
    }
    
    //MARK: - Set up UI
    private func setupActivityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.style = .large
        view.addSubview(indicator)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor)
        ])
        
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "Pages"
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createPage))
        navigationItem.rightBarButtonItems = [add]
    }
    
    private func setupSearchbar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    private func setupPagesTable() {
        pagesTable.delegate = self
        pagesTable.dataSource = self
    }
    
    private func setupTableView() {
        pagesTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        view.addSubview(pagesTable)
        NSLayoutConstraint.activate([
            pagesTable.topAnchor.constraint(equalTo: self.view.topAnchor),
            pagesTable.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            pagesTable.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            pagesTable.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
    }
    
    @objc func refresh(sender: AnyObject) {
        loadPages()
        print("refreshed")
        pagesTable.reloadData()
        pagesTable.refreshControl?.endRefreshing()
    }
    
    @objc private func createPage() {
        DispatchQueue.main.async {
            let navController = UINavigationController(rootViewController: CreateNewPageViewController())
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
    }
    
    private func loadPages() {
        bluditAPI.listPages(pageNumber: 1) { listPagesResponse in
            self.pages = listPagesResponse?.data
            self.setupTableView()
            self.indicator.removeFromSuperview()
        }
    }
    
    
    
    // WORKING ON THIS - Scrolling down to get more pages
    
//    private func loadMore() {
//        print("trying to load more")
//        bluditAPI.listPages(pageNumber: 2) { listPagesResponse in
//            self.pages?.append(contentsOf: listPagesResponse!.data)
//            self.setupTableView()
//            self.pagesTable.reloadData()
//        }
//    }
    
    var isLoading = false
    var pageIndex = 2
    
    private func loadMore() {
        if !isLoading {
            isLoading = true
            DispatchQueue.global().async {
                self.bluditAPI.listPages(pageNumber: self.pageIndex) { listPagesResponse in
                    if let newPages = listPagesResponse?.data {
                        self.pages?.append(contentsOf: newPages)
                    }
                    self.pageIndex += 1
                    self.pagesTable.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
  
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let offsetY = scrollView.contentOffset.y
//            let contentHeight = scrollView.contentSize.height
//
//            if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
//                loadMore()
//            }
//        }

//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//
//        // UITableView only moves in one direction, y axis
//        let currentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//
//        if maximumOffset - currentOffset <= 10.0 {
//            let spinner = UIActivityIndicatorView(style: .medium)
//
//            if pages?.count != pages?.count {
//
//                //print("this is the last cell")
//
//                spinner.startAnimating()
//                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: pagesTable.bounds.width, height: CGFloat(44))
//                spinner.hidesWhenStopped = true
//                self.pagesTable.tableFooterView = spinner
//                self.pagesTable.tableFooterView?.isHidden = false
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                    //MARK: Loading more data
//                    self.loadMore()
//
//                }
//
//            }
//            else{
//                self.pagesTable.tableFooterView?.isHidden = true
//                spinner.stopAnimating()
//            }
//        }
//
//    }
    
    }


extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pages?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        cell.textLabel?.text = pages?[indexPath.row].title
        let content = pages?[indexPath.row].content.htmlAttributedString?.string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.detailTextLabel?.text = content
        cell.accessoryType = .disclosureIndicator
        
        // Check if the last row number is the same as the last current data element
        if indexPath.row == self.pages!.count - 1 {
            self.loadMore()
        }
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pagesTable.deselectRow(at: indexPath, animated: true)
        print("Page selected: \(String(describing: pages?[indexPath.row].title))")
        
        DispatchQueue.main.async {
            let destination = PageContentsViewController()
            destination.pageTitle = self.pages?[indexPath.row].title
            destination.pageTags = self.pages?[indexPath.row].tags
//            destination.pageContents = self.pages?[indexPath.row].contentRaw.htmlAttributedString?.string
            let content = self.pages?[indexPath.row].content.htmlAttributedString?.string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            destination.pageContents = content
            self.navigationController?.pushViewController(destination, animated: true)
        }
        
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
