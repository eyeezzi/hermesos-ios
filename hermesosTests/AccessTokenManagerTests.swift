//
//  AccessTokenManagerTests.swift
//  hermesosTests
//
//  Created by Uzziah on 2018-12-30.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import XCTest
@testable import hermesos

class AccessTokenManagerTests: XCTestCase {
    
    func testTokenCanBeSavedAndRetrieved() {
        let token = "secret token"
        AccessTokenManager.saveToken(value: token)
        let saved = AccessTokenManager.getToken()
        XCTAssertEqual(saved, token)
    }
    
    func testDeletedTokenCannotBeRetrieved() {
        AccessTokenManager.saveToken(value: "secret token")
        AccessTokenManager.deleteToken()
        XCTAssertNil(AccessTokenManager.getToken())
    }
}
