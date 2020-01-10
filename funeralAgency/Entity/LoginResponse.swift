//
//  LoginResponse.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

public struct LoginResponse: Codable {
    public let token: String
    public let employee: [String: String]
}
