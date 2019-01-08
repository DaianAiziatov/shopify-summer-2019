//
//  CustomCollectionsAPIResponse.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct CustomCollectionsAPIResponse: Decodable {
    
    private(set) var collections: [CustomCollection]
    
    enum CodingKeys: String, CodingKey {
        case collections = "custom_collections"
    }
}
