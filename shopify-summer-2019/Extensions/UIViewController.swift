//
//  UIViewController.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 10/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func startLoadingView() {
        
        let loadingView = UIView(frame: self.view.frame)
        loadingView.tag = 100
        loadingView.addBlurEffect()
    
        let loadingIndicator = UIActivityIndicatorView()
        loadingIndicator.center = UIApplication.shared.keyWindow!.center
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        loadingView.addSubview(loadingIndicator)
        
        DispatchQueue.main.async {
            self.view.addSubview(loadingView)
        }
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.view.viewWithTag(100)?.removeFromSuperview()
        }
    }
    
    
}
