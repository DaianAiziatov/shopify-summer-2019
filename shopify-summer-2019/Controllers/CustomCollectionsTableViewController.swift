//
//  CustomCollectionsTableViewController.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class CustomCollectionsTableViewController: UITableViewController, AlertDisplayable {

    private var collections = [CustomCollection]()
    private var fileteredCollections = [CustomCollection]()
    private var client = APIClient()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegistration()
        setupSearchController()
        setupPullToRefresh()
        fetchCustomCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    @objc
    private func reloadData() {
        collections.removeAll()
        fetchCustomCollections()
    }
    
    private func fetchCustomCollections() {
        startLoadingView()
        client.fetchCustomCollections() { result in
            switch result {
            case .failure(let error):
                self.onFetchFailed(with: error)
            case .success(let response):
                self.collections.append(contentsOf: response.collections)
                self.onFetchCompleted()
            }
        }
    }
    
    private func setupSearchController() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        definesPresentationContext = true
        self.navigationItem.searchController = self.searchController
    }
    
    private func cellRegistration() {
        tableView.register(UINib(nibName: "CustomCollectionCell", bundle: nil), forCellReuseIdentifier: "CollectionCell")
    }
    
    private func setupPullToRefresh() {
        self.tableView.refreshControl = .init()
        self.tableView.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.tableView.refreshControl!.addTarget(self, action: #selector(reloadData), for: .valueChanged)
    }
    
    private func onFetchFailed(with error: DataResponseError) {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.dismissLoadingView()
            self.tableView.reloadData()
            let title = "Warning"
            let action = UIAlertAction(title: "Ok", style: .default)
            self.displayAlert(with: title , message: error.reason, actions: [action])
            switch error {
            case .network: self.startLostConnectionView()
            case .decoding: self.startDecodingErrorView()
            }
        }
    }
    
    private func onFetchCompleted() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
            self.dismissLoadingView()
            self.dismissLostConnectionView()
            self.dismissDecodingErrorView()
            self.tableView.reloadData()
        }
    }

}


// MARK: - Table view data source

extension CustomCollectionsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive == true && searchController.searchBar.text != "" {
            return fileteredCollections.count
        } else {
            return collections.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as! CustomCollectionCell
        if !(self.tableView.refreshControl?.isRefreshing)! {
            if searchController.isActive == true && searchController.searchBar.text != "" {
                cell.configure(with: fileteredCollections[indexPath.row])
            } else {
                cell.configure(with: collections[indexPath.row])
            }
        }
        return cell
    }
    
}

// MARK: - Table view delegate

extension CustomCollectionsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = sb.instantiateViewController(withIdentifier: "detailsVC") as! DetailsTableViewController
        if searchController.isActive == true && searchController.searchBar.text != "" {
            detailsVC.collection = fileteredCollections[indexPath.row]
        } else {
            detailsVC.collection = collections[indexPath.row]
        }
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

// MARK: - Search Bar delegate

extension CustomCollectionsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchString = searchController.searchBar.text
        fileteredCollections = collections.filter({ (item) -> Bool in
            let title: NSString = item.title as NSString
            let description: NSString = item.description as NSString
            let filteredResults = (title.range(of: searchString!, options: .caseInsensitive).location != NSNotFound) ||
                (description.range(of: searchString!, options: .caseInsensitive).location != NSNotFound)
            return filteredResults
        })
        self.tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        self.tableView.reloadData()
    }
    
}
