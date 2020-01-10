//
//  Error+String.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

extension String: Error {
    public var localizedDescription: String {
        return self
    }
}
