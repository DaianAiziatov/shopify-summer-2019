//
//  APIClient.swift
//  shopify-winter-2019
//
//  Created by Daian Aiziatov on 08/01/2019.
//  Copyright © 2019 Daian Aiziatov. All rights reserved.
//

import Foundation

struct APIClient {
    
    private lazy var baseURL: URL = {
        return URL(string: "https://shopicruit.myshopify.com/")!
    }()
    
    private(set) lazy var session: URLSession = {
        return URLSession.shared
    }()
    
    mutating func fetchCustomCollections(with request: APIRequest, completion: @escaping (Result<CustomCollection, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(request.customCollectionsPath))
        let parameters = ["access_token" : request.accessToken]
        var encodedURLRequest = urlRequest.encode(with: parameters)
        encodedURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: encodedURLRequest, completionHandler: { data, response, error in
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            guard let decodedResponse = try? JSONDecoder().decode(CustomCollection.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
}
