//
//  DetailsTableViewController.swift
//  shopify-summer-2019
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
        setupPullToRefresh()
        self.title = "Products"
        tableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        fetchCollects()
    }
    
    // MARK: - Retrieving the list of collects in a specific collection first
    private func fetchCollects() {
        startLoadingView()
        client.fetchCollects(with: collection) { result in
            switch result {
            case .failure(let error):
                self.onFetchFailed(with: error)
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
                self.onFetchFailed(with: error)
            case .success(let response):
                self.products.append(contentsOf: response.products)
                self.onFetchCompleted()
            }
        }
    }
    
    @objc
    private func reloadData() {
        collects.removeAll()
        products.removeAll()
        fetchCollects()
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
            self.dismissDecodingErrorView()
            self.dismissLostConnectionView()
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
        let cell: ProductCell = .fromNib()
        if !(self.tableView.refreshControl?.isRefreshing)! {
            cell.configure(with: products[indexPath.row])
        }
        return cell
    }
    
}

// MARK: - Table view delegate

extension DetailsTableViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: CustomCollectionCell = .fromNib()
        header.configure(with: collection)
        header.containerView.backgroundColor = #colorLiteral(red: 0.3671783805, green: 0.5572823882, blue: 0.2414824367, alpha: 0.5)
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let header: CustomCollectionCell = .fromNib()
        header.configure(with: collection)
        return header.bounds.height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let productVC = sb.instantiateViewController(withIdentifier: "productVC") as! ProductViewController
        productVC.product = products[indexPath.row]
        self.navigationController?.pushViewController(productVC, animated: true)
    }
    
}
