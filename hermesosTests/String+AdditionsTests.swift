//
//  String+AdditionsTests.swift
//  hermesosTests
//
//  Created by Uzziah on 2018-12-30.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import XCTest
@testable import hermesos

class StringAdditionsTests: XCTestCase {
    
    func testIsPhoneNumberWithShortValidPhone() {
        XCTAssertTrue(Mock.validPhoneShort.isPhoneNumber())
    }
    
    func testIsPhoneNumberWithLongValidPhone() {
        XCTAssertTrue(Mock.validPhoneLong.isPhoneNumber())
    }
    
    func testIsPhoneNumberWithShortInvalidPhone() {
        XCTAssertFalse(Mock.invalidPhoneShort.isPhoneNumber())
    }
    
    func testIsPhoneNumberWithAlphanumInvalidPhone() {
        XCTAssertFalse(Mock.invalidPhoneAlphanum.isPhoneNumber())
    }
}

extension StringAdditionsTests {
    private enum Mock {
        static let validPhoneLong = "1112223333"
        static let validPhoneShort = "11"
        static let invalidPhoneShort = "1"
        static let invalidPhoneAlphanum = "111XXX333"
    }
}
