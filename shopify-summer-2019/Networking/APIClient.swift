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
    
    //TODO: - Optimize functions
    
    mutating func fetchCustomCollections(completion: @escaping (Result<CustomCollectionsAPIResponse, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(APIRequest.customCollectionsPath))
        let parameters = ["access_token" : APIRequest.accessToken]
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
            guard let decodedResponse = try? JSONDecoder().decode(CustomCollectionsAPIResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
    mutating func fetchCollects(with collection: CustomCollection,
                                completion: @escaping (Result<CollectsAPIResponse, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(APIRequest.collectsPath))
        let parameters = ["access_token" : APIRequest.accessToken,
                          "collection_id" : "\(collection.id)"]
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
            guard let decodedResponse = try? JSONDecoder().decode(CollectsAPIResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
    mutating func fetchProducts(with collects: [Collect],
                                completion: @escaping (Result<ProductsAPIResponse, DataResponseError>) -> Void) {
        let urlRequest = URLRequest(url: baseURL.appendingPathComponent(APIRequest.productsPath))
        var ids = ""
        for collect in collects {
            ids += "\(collect.productID),"
        }
        ids = String(ids.dropLast())
        let parameters = ["access_token" : APIRequest.accessToken,
                          "ids" : ids]
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
            guard let decodedResponse = try? JSONDecoder().decode(ProductsAPIResponse.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            completion(Result.success(decodedResponse))
        }).resume()
    }
    
}
