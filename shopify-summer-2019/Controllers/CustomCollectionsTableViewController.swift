//
//  CustomCollectionsTableViewController.swift
//  shopify-winter-2019
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
        self.addBlurEffect()
        startLoadingView()
        cellRegistration()
        searchControllerSetup()
        fetchCustomCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnSwipe = true
    }

    
    private func fetchCustomCollections() {
        client.fetchCustomCollections() { result in
            switch result {
            case .failure(let error):
                self.onFetchFailed(with: error.reason)
            case .success(let response):
                self.collections.append(contentsOf: response.collections)
                self.onFetchCompleted()
            }
        }
    }
    
    private func searchControllerSetup() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .minimal
        definesPresentationContext = true
        self.navigationItem.titleView = self.searchController.searchBar;
        self.navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    private func cellRegistration() {
        tableView.register(UINib(nibName: "CustomCollectionCell", bundle: nil), forCellReuseIdentifier: "CollectionCell")
    }
    
    private func onFetchFailed(with reason: String) {
        self.dismissLoadingView()
        let title = "Warning"
        let action = UIAlertAction(title: "OK", style: .default)
        self.displayAlert(with: title , message: reason, actions: [action])
    }
    
    private func onFetchCompleted() {
        DispatchQueue.main.async {
            self.dismissLoadingView()
            self.tableView.reloadData()
            self.removeBlurEffect()
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
        if searchController.isActive == true && searchController.searchBar.text != "" {
            cell.configure(with: fileteredCollections[indexPath.row])
        } else {
            cell.configure(with: collections[indexPath.row])
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
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController.searchBar.text = ""
        tableView.reloadData()
    }
    
}
