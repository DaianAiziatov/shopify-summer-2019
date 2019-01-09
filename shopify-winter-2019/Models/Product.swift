//
//  Product.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct Product: Decodable {
    
    private(set) var name: String
    private(set) var variants: [Variant]
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case variants
    }
    
    func calculateTotalAvailable() -> Int {
        var total = 0;
        for variant in variants {
            total += variant.quantity
        }
        return total
    }
}

