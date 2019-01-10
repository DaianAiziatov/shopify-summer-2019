//
//  DetailsTableViewController.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {
    
    var collection: CustomCollection!
    
    private var products = [Product]()
    private var collects = [Collect]()
    
    private var client = APIClient()
    private let request = APIRequest()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        fetchCollects()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.hidesBarsOnSwipe = false
    }
    
    private func fetchCollects() {
        client.fetchCollects(with: request, collection: collection) { result in
            switch result {
            case .failure(let error):
                print(error.reason)
            case .success(let response):
                DispatchQueue.main.async {
                    self.collects.append(contentsOf: response.collects)
                    self.fetchProducts()
                }
            }
        }
    }
    
    private func fetchProducts() {
        client.fetchProducts(with: request, collects: collects) { result in
            switch result {
            case .failure(let error):
                print(error.reason)
            case .success(let response):
                DispatchQueue.main.async {
                    self.products.append(contentsOf: response.products)
                    self.tableView.reloadData()
                }
            }
        }
    }

}

// MARK: - Table view data source

extension DetailsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell")
        cell?.textLabel?.text = products[indexPath.row].name
        cell?.detailTextLabel?.text = "Quantity: \(products[indexPath.row].calculateTotalAvailable())"
        return cell!
    }
    
}
