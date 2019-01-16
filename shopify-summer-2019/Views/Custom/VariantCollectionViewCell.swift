//
//  VariantCollectionViewCell.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 15/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class VariantCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    
    private var variant: Variant!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        nameLabel.sizeToFit()
        priceLabel.sizeToFit()
        quantityLabel.sizeToFit()
        containerView.makeBorders(with: 10.0)
        addShadows()
        backgroundColor = .clear
    }
    
    func configure(with variant: Variant) {
        self.variant = variant
        nameLabel.text = variant.title
        priceLabel.text = "Pride: $\(variant.price)"
        quantityLabel.text = "Quantity: \(variant.quantity)"
    }

}
