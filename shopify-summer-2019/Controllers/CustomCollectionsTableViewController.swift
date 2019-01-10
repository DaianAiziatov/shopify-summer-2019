//
//  CustomCollectionsTableViewController.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class CustomCollectionsTableViewController: UITableViewController {

    private var collections = [CustomCollection]()
    private var client = APIClient()
    private let request = APIRequest()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        tableView.register(UINib(nibName: "CustomCollectionCell", bundle: nil), forCellReuseIdentifier: "CollectionCell")
        fetchCustomCollections()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.hidesBarsOnSwipe = true
    }

    
    private func fetchCustomCollections() {
        client.fetchCustomCollections(with: request) { result in
            switch result {
            case .failure(let error):
                print(error.reason)
            case .success(let response):
                DispatchQueue.main.async {
                    self.collections.append(contentsOf: response.collections)
                    self.tableView.reloadData()
                }
            }
        }
    }

}


// MARK: - Table view data source

extension CustomCollectionsTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collections.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell") as! CustomCollectionCell
        cell.configure(with: collections[indexPath.row])
        return cell
    }
    
}

// MARK: - Table view delegate

extension CustomCollectionsTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let detailsVC = sb.instantiateViewController(withIdentifier: "detailsVC") as! DetailsTableViewController
        detailsVC.collection = collections[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}
