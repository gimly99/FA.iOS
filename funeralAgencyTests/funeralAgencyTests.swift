//
//  funeralAgencyTests.swift
//  funeralAgencyTests
//
//  Created by user on 19/01/2020.
//  Copyright © 2020 user. All rights reserved.
//

import XCTest
@testable import funeralAgency

class funeralAgencyTests: XCTestCase {

    var appUnderTest: AuthView!
    
    func testAuth() {
        measure {
            let exp = XCTestExpectation()
            
            let viewModel = AuthViewModel()
            viewModel.auth(info: Login(eMail: "gimly99@mail.ru", password: "Zaq12wsxcde3"))
            { (result) in
                if case Result<LoginResponse, String>.failure(let error) = result {
                    XCTAssert(false, error)
                }
                exp.fulfill()
            }
            wait(for: [exp], timeout: 15)
        }
    }
    
    override func setUp() {
        appUnderTest = AuthView()
        //appUnderTest.signIn()
    }

    override func tearDown() {

        appUnderTest = nil
    }

    func testLogIn() {

        
        //XCTAssertEqual(appUnderTest.)
    }



}
