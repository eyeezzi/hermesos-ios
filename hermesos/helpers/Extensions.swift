//
//  Extensions.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case ACCESS_TOKEN
    }
    
    func saveToken(value: String) {
        set(value, forKey: UserDefaultsKeys.ACCESS_TOKEN.rawValue)
    }
    
    func getToken() -> String? {
        return string(forKey: UserDefaultsKeys.ACCESS_TOKEN.rawValue)
    }
    
    func deleteToken() {
        removeObject(forKey: UserDefaultsKeys.ACCESS_TOKEN.rawValue)
    }
}

extension String {
    func isPhoneNumber() -> Bool {
        let PHONE_REGEX = "^\\+?[1-9]\\d{1,14}$"
        return self.range(of: PHONE_REGEX, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
