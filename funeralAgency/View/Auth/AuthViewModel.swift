//
//  AuthViewModel.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

public protocol AuthViewModelProtocol {
    func auth(info: Login, completionHandler: @escaping (Result<LoginResponse, String>) -> Void)
}

public class AuthViewModel: AuthViewModelProtocol {
    public func auth(info: Login, completionHandler: @escaping (Result<LoginResponse, String>) -> Void) {
        
        let url = URL(string: "http://localhost:3200")!.appendingPathComponent("login")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.httpBody = try? encoder.encode(info)
        
        let task = URLSession.shared.dataTask(with: request) { (data, res, err) in
            if let data = data {
                
                if let decodedData = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                    completionHandler(.success(decodedData))
                } else {
                    let errString = String(data: data, encoding: .utf8) ?? ""
                    completionHandler(.failure(errString))
                }
                
            } else {
                completionHandler(.failure(""))
            }
        }
        task.resume()
    }
}
