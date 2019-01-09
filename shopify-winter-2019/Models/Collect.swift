//
//  Collect.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct Collect: Decodable {
    
    private(set) var productID: Int
    
    enum CodingKeys: String, CodingKey {
        case productID = "product_id"
    }
}
