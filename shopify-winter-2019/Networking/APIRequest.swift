//
//  APIRequest.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct APIRequest {

    var accessToken: String {
        return "c32313df0d0ef512ca64d5b336a0d7c6"
    }
    
    var customCollectionsPath: String {
        return "admin/custom_collections.json"
    }
    
    var collectsPath: String {
        return "admin/collects.json"
    }
    
    var productsPath: String {
        return "admin/products.json"
    }
    
}
