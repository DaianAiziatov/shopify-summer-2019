//
//  DetailsTableViewController.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController, AlertDisplayable {
    
    var collection: CustomCollection!
    
    private var products = [Product]()
    private var collects = [Collect]()
    
    private var client = APIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoadingView()
        self.clearsSelectionOnViewWillAppear = false
        self.title = "Products"
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        fetchCollects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.hidesBarsOnSwipe = false
    }
    
    // MARK: - Retrieving the list of collects in a specific collection first
    private func fetchCollects() {
        client.fetchCollects(with: collection) { result in
            switch result {
            case .failure(let error):
                self.onFetchFailed(with: error.reason)
            case .success(let response):
                self.collects.append(contentsOf: response.collects)
                self.fetchProducts()
            }
        }
    }
    
    // MARK: - Finally fetching the products from specific collection
    private func fetchProducts() {
        client.fetchProducts(with: collects) { result in
            switch result {
            case .failure(let error):
                self.onFetchFailed(with: error.reason)
            case .success(let response):
                self.products.append(contentsOf: response.products)
                self.onFetchCompleted()
            }
        }
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
        }
    }

}

// MARK: - Table view data source

extension DetailsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
        cell.configure(with: products[indexPath.row])
        return cell
    }
    
}

// MARK: - Table view delegate

extension DetailsTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: CustomCollectionCell = .fromNib()
        header.configure(with: collection)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let header: CustomCollectionCell = .fromNib()
        header.configure(with: collection)
        return header.bounds.height
    }
    
}
