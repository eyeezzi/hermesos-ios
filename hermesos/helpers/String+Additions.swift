//
//  String+Additions.swift
//  hermesos
//
//  Created by Uzziah on 2018-12-30.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import Foundation

extension String {
    func isPhoneNumber() -> Bool {
        let PHONE_REGEX = "^\\+?[1-9]\\d{1,14}$"
        return self.range(of: PHONE_REGEX, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
