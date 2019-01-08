//
//  CustomCollection.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct CustomCollection {
    
    private(set) var id: Int
    private(set) var title: String
    private(set) var bodyHTML: String
    private(set) var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case bodyHTML = "body_html"
        case image
    }
    
    enum ImageKey: String, CodingKey {
        case imageURL = "src"
    }
}

extension CustomCollection: Decodable {
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        title = try values.decode(String.self, forKey: .title)
        bodyHTML = try values.decode(String.self, forKey: .bodyHTML)
        
        let image = try values.nestedContainer(keyedBy: ImageKey.self, forKey: .image)
        imageURL = try image.decode(String.self, forKey: .imageURL)
    }
    
}
