//
//  DataResponseError.swift
//  shopify-summer-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data "
        case .decoding:
            return "An error occurred while decoding data"
        }
    }
}
