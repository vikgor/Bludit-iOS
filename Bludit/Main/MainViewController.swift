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
    private var currentPage = 1
    private let refreshControl = UIRefreshControl()
    private var indicator = UIActivityIndicatorView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredPages: [PageDetails]?
    private var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    private var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
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
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        pagesTable.refreshControl = refreshControl
        loadSettings()
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
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pages"
        self.navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupPagesTable() {
        pagesTable.delegate = self
        pagesTable.dataSource = self
        loadPages()
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
        pagesTable.refreshControl?.endRefreshing()
    }
    
    @objc private func createPage() {
        DispatchQueue.main.async {
            let destination = CreateNewPageViewController()
            let navController = UINavigationController(rootViewController: destination)
            self.navigationController?.present(navController, animated: true, completion: nil)
        }
    }
    
    private func loadPages() {
        bluditAPI.listPages(pageNumber: currentPage) { listPagesResponse in
            self.pages = listPagesResponse?.data
            self.setupTableView()
            self.pagesTable.reloadData()
            self.indicator.removeFromSuperview()
        }
    }
    
    private func loadSettings() {
        /// Fetching the settings and saving them for later
        bluditAPI.listSettings() { currentSettings in
            if let currentSettings = try? JSONEncoder().encode(currentSettings) {
                UserDefaults.standard.set(currentSettings, forKey: "settings")
            }
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
    
//    var isLoading = false
//    var pageIndex = 2
//
//    private func loadMore() {
//        if !isLoading {
//            isLoading = true
//            DispatchQueue.global().async {
//                self.bluditAPI.listPages(pageNumber: self.pageIndex) { listPagesResponse in
//                    if let newPages = listPagesResponse?.data {
//                        self.pages?.append(contentsOf: newPages)
//                    }
//                    self.pageIndex += 1
//                    self.pagesTable.reloadData()
//                    self.isLoading = false
//                }
//            }
//        }
//    }
  
    
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
    private func filterContentForSearchText(_ searchText: String,
                                            type: PageDetails.Type? = nil) {
        if let pages = self.pages {
            filteredPages = pages.filter { (page: PageDetails) -> Bool in
                return page.title.lowercased().contains(searchText.lowercased())
            }
            pagesTable.reloadData()
        }
    }
}


extension MainViewController: UITableViewDataSource {
    
    /// Count the number of pages
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredPages?.count ?? 0
        }
        return pages?.count ?? 0
    }
    
    /// Set up cells with a label and detailedText
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        /// Check if the pages array is changed because of searching
        let page: PageDetails?
        if isFiltering {
            page = filteredPages?[indexPath.row]
        } else {
            page = pages?[indexPath.row]
        }
        
        /// Set up cells
        cell.textLabel?.text = page?.title
        let content = page?.content.htmlAttributedString(color: nil)?.string.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        cell.detailTextLabel?.text = content
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    
    /// Tapping on a cell and going to the Page contents
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pagesTable.deselectRow(at: indexPath, animated: true)
        DispatchQueue.main.async {
            let destination = PageContentsViewController()
            
            /// Check if the pages array is changed because of searching
            let page: PageDetails?
            if self.isFiltering {
                page = self.filteredPages?[indexPath.row]
            } else {
                page = self.pages?[indexPath.row]
            }
            
            /// Send the page details
            destination.pageTitle = page?.title
            destination.pageTags = page?.tags
            let content = page?.content
            destination.pageContents = content
            destination.coverImage = page?.coverImage.value
            self.navigationController?.pushViewController(destination, animated: true)
        }
    }
    
    /// Editing the table view. Swipe to delete or adit a page.
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        /// Check if the pages array is changed because of searching
        let page: PageDetails?
        if self.isFiltering {
            page = self.filteredPages?[indexPath.row]
        } else {
            page = self.pages?[indexPath.row]
        }
        
        /// Delete page
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, completion) in
            print("Deleted")
            if let query = page?.key {
                self.bluditAPI.deletePage(query: query)
                self.pages?.remove(at: indexPath.row)
            }
            completion(true)
            tableView.reloadData()
        }
        
        /// Edit page
        let editItem = UIContextualAction(style: .normal, title: "Edit") {  (contextualAction, view, completion) in
            print("Edited")
            DispatchQueue.main.async {
                let destination = EditPageViewController()
                if let pageTitle = page?.title {
                    destination.initialPageTitle = pageTitle
                }
                if let pageTags = page?.tags {
                    destination.initialPageTags = pageTags
                }
                if let pageContents = page?.content {
                    destination.initialPageContents = pageContents
                }
                if let pageKey = page?.key {
                    destination.pageKey = pageKey
                }
                let navController = UINavigationController(rootViewController: destination)
                self.navigationController?.present(navController, animated: true, completion: nil)
            }
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, editItem])
        return swipeActions
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!)
    }
    
    /// This is what the API search looks like, it can only find the page with the exact keyword
    /// I will delete it later
    func updateSearchResults2(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            bluditAPI.findPage(query: text) { foundPageResponse in
                if let response = foundPageResponse {
                    if let data = response.data {
                        self.pages = Array(arrayLiteral: data)
                    }
                }
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
