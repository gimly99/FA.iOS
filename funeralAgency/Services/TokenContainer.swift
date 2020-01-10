//
//  TokenContainer.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

public class TokenContainer {
    static private let containerID = "token_suka"
    
    static public var token: String? {
        get {
            return UserDefaults.standard.string(forKey: containerID)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: containerID)
        }
    }
    private init() {}
}
