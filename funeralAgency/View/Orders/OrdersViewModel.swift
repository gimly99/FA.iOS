//
//  OrdersViewModel.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

public protocol OrdersViewModelProtocol {
    func getAll(completionHandler: @escaping (Result<[Order], String>) -> Void)
}

public class OrdersViewModel: OrdersViewModelProtocol {
    public func getAll(completionHandler: @escaping (Result<[Order], String>) -> Void) {
        
        let url = URL(string: "http://localhost:3200")!.appendingPathComponent("all")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let decodedData = try? decoder.decode([Order].self, from: data) {
                    completionHandler(.success(decodedData))
                } else {
                    let errString = String(data: data, encoding: .utf8) ?? ""
                    completionHandler(.failure(errString))
                }
                
            } else {
                completionHandler(.failure(""))
            }
        }.resume()
    }
}
