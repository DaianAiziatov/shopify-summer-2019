//
//  ProductCell.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 09/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    private var product: Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.makeBorders(with: 10.0)
        addShadows()
        backgroundColor = .clear
        nameLabel.sizeToFit()
        nameLabel.numberOfLines = 0
        vendorLabel.sizeToFit()
        totalLabel.sizeToFit()
        activityIndicator.hidesWhenStopped = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }

    func configure(with product: Product?) {
        if let product = product {
            self.product = product
            containerView.isHidden = false
            nameLabel.text = product.name
            vendorLabel.text = product.vendor
            totalLabel.text = "Total: \(product.totalAvailable ?? 0)"
            productImageView.downloaded(from: URL(string: product.imageURL)!,
                                        contentMode: .scaleToFill)
            activityIndicator.stopAnimating()
        } else {
            containerView.isHidden = true
            activityIndicator.startAnimating()
        }
    }
    
}
