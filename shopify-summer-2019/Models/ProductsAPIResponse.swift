//
//  PriductsAPIResponse.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct ProductsAPIResponse: Decodable {
    
    private(set) var products: [Product]
    
    enum CodingKeys: String, CodingKey {
        case products
    }
}
