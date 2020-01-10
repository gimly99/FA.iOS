//
//  Order.swift
//  funeralAgency
//
//  Created by user on 20/12/2019.
//  Copyright © 2019 user. All rights reserved.
//

import Foundation

public struct Order: Decodable {
    public let nameCustomer: String
    public let phoneNumberCustomer: String
    public let dateee: Date?
}
