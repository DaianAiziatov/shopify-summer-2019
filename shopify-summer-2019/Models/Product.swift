//
//  Product.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct Product {
    
    private(set) var name: String
    private(set) var description: String
    private(set) var vendor: String
    private(set) var type: String
    private(set) var variants: [Variant]
    private(set) var imageURL: String
    private(set) var totalAvailable: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "title"
        case description = "body_html"
        case vendor
        case type = "product_type"
        case variants
        case image
    }
    
    enum ImageKey: String, CodingKey {
        case imageURL = "src"
    }
    
    private mutating func calculateTotalAvailable() {
        var total = 0
        for variant in variants {
            total += variant.quantity
        }
        self.totalAvailable = total
    }
}

extension Product: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        description = try values.decode(String.self, forKey: .description)
        vendor = try values.decode(String.self, forKey: .vendor)
        type = try values.decode(String.self, forKey: .type)
        variants = try values.decode([Variant].self, forKey: .variants)
        
        let image = try values.nestedContainer(keyedBy: ImageKey.self, forKey: .image)
        imageURL = try image.decode(String.self, forKey: .imageURL)
        
        self.calculateTotalAvailable()
    }
    
}

