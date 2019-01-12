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
        
        let loadingView = UIView(frame: UIApplication.shared.keyWindow!.bounds)
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
            UIView.animate(withDuration: 0.3, animations: {
                self.view.viewWithTag(100)?.alpha = 0
            }, completion: { _ in
                self.view.viewWithTag(100)?.removeFromSuperview()
            })
        }
    }
    
    func startLostConnectionView() {
        
        let lostConnectionView = UIView(frame: UIApplication.shared.keyWindow!.frame)
        lostConnectionView.tag = 404
        
        let logoImageView = UIImageView(image: UIImage(named: "no_internet"))
        logoImageView.center = UIApplication.shared.keyWindow!.center
        lostConnectionView.addSubview(logoImageView)
        
        DispatchQueue.main.async {
            self.view.addSubview(lostConnectionView)
        }
        
    }
    
    func dismissLostConnectionView() {
        DispatchQueue.main.async {
            self.view.viewWithTag(404)?.removeFromSuperview()
        }
    }
    
    func startDecodingErrorView() {
        
        let decodingErrorView = UIView(frame: UIApplication.shared.keyWindow!.frame)
        decodingErrorView.tag = 400
        
        let message = UILabel()
        message.text = "Error while decoding data. Please try again later"
        message.sizeToFit()
        message.numberOfLines = 0
        message.center = UIApplication.shared.keyWindow!.center
        
        decodingErrorView.addSubview(message)
        
        DispatchQueue.main.async {
            self.view.addSubview(decodingErrorView)
        }
        
    }
    
    func dismissDecodingErrorView() {
        DispatchQueue.main.async {
            self.view.viewWithTag(400)?.removeFromSuperview()
        }
    }
    
    
}
