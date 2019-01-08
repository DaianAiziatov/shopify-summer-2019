//
//  Result.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
