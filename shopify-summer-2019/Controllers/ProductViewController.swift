//
//  ProductViewController.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 14/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.text = product.name
            nameLabel.sizeToFit()
        }
    }
    @IBOutlet weak var productImageView: UIImageView! {
        didSet {
            productImageView.downloaded(from: URL(string: product.imageURL)!, contentMode: .scaleAspectFill)
        }
    }
    @IBOutlet weak var descriptionView: UIView! {
        didSet {
            descriptionView.makeBorders(with: 10.0)
        }
    }
    @IBOutlet weak var vendorLabel: UILabel! {
        didSet {
            vendorLabel.text = "Vendor: \(product.vendor)"
            vendorLabel.sizeToFit()
        }
    }
    @IBOutlet weak var typeLabel: UILabel! {
        didSet {
            typeLabel.text = "Product Type: \(product.type)"
            typeLabel.sizeToFit()
        }
    }
    @IBOutlet weak var totalLabel: UILabel! {
        didSet {
            totalLabel.text = "Total: \(product.totalAvailable ?? 0)"
            totalLabel.sizeToFit()
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.text = "Description: \(product.description)"
            descriptionLabel.sizeToFit()
        }
    }
    
    var product: Product!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "VariantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VariantCell")
    }
    
}

// MARK: - Collection View Data Source

extension ProductViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return product.variants.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VariantCell", for: indexPath) as! VariantCollectionViewCell
        cell.configure(with: product.variants[indexPath.item])
        return cell
    }
    
}

// MARK: - Collection View Delegate Flow Layout

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VariantCell", for: indexPath) as! VariantCollectionViewCell
        cell.configure(with: product.variants[indexPath.item])
        return CGSize(width: cell.contentView.frame.width, height: cell.contentView.frame.height)
    }
    
}

