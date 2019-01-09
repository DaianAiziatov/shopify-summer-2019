//
//  Variant.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct Variant: Decodable {
    
    private(set) var quantity: Int
    
    enum CodingKeys: String, CodingKey {
        case quantity = "inventory_quantity"
    }
}
