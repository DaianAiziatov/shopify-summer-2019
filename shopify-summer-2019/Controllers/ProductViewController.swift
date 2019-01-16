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
            productImageView.downloaded(from: URL(string: product.imageURL)!, contentMode: .scaleToFill)
        }
    }
    @IBOutlet weak var descriptionView: UIView! {
        didSet {
            descriptionView.addShadows()
            descriptionView.makeBorders(with: 10.0)
        }
    }
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var product: Product!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: "VariantCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VariantCell")
        vendorLabel.text = "Vendor: \(product.vendor)"
        typeLabel.text = "Product Type: \(product.type)"
        totalLabel.text = "Total: \(product.totalAvailable ?? 0)"
        descriptionLabel.text = "Description: \(product.description)"
        totalLabel.sizeToFit()
        typeLabel.sizeToFit()
        vendorLabel.sizeToFit()
        descriptionLabel.sizeToFit()
    }
    
}
    

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

extension ProductViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VariantCell", for: indexPath) as! VariantCollectionViewCell
        cell.configure(with: product.variants[indexPath.item])
        return CGSize(width: cell.contentView.frame.width, height: cell.contentView.frame.height)
    }
    
}

