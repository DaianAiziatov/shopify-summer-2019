//
//  CustomCollectionCell.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

class CustomCollectionCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var collectionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    private var collection: CustomCollection!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func configure(with collection: CustomCollection) {
        self.collection = collection
        containerView.isHidden = false
        titleLabel.text = collection.title
        descriptionLabel.text = collection.description
        collectionImageView.downloaded(from: URL(string: collection.imageURL)!, contentMode: .scaleToFill)
    }
    
    private func setup() {
        containerView.makeBorders(with: 10.0)
        addShadows()
        backgroundColor = .clear
        titleLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        descriptionLabel.sizeToFit()
    }
    
}
