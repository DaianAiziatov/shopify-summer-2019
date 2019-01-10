//
//  UIView.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 09/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

extension UIView {
    
    func makeBorders(with radius: CGFloat) {
        layer.masksToBounds = true
        clipsToBounds = true
        layer.cornerRadius = radius
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds

        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func addShadows() {
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 6
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
    
}
