//
//  ProductCell.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 09/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var vendorLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    private var product: Product!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func configure(with product: Product) {
        self.product = product
        nameLabel.text = product.name
        vendorLabel.text = product.vendor
        totalLabel.text = "Total: \(product.totalAvailable ?? 0)"
        productImageView.downloaded(from: URL(string: product.imageURL)!,
                                    contentMode: .scaleToFill)
    }
    
    private func setup() {
        containerView.makeBorders(with: 10.0)
        addShadows()
        backgroundColor = .clear
        nameLabel.sizeToFit()
        nameLabel.numberOfLines = 0
        vendorLabel.sizeToFit()
        totalLabel.sizeToFit()
    }
    
}
