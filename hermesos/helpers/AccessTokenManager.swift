//
//  AccessTokenManager.swift
//  hermesos
//
//  Created by Uzziah on 2018-12-30.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

struct AccessTokenManager {
    
    enum Keys: String {
        case ACCESS_TOKEN
    }
    
    static func saveToken(value: String) {
        KeychainWrapper.standard.set(value, forKey: Keys.ACCESS_TOKEN.rawValue)
    }
    
    static func getToken() -> String? {
        return KeychainWrapper.standard.string(forKey: Keys.ACCESS_TOKEN.rawValue)
    }
    
    static func deleteToken() {
        KeychainWrapper.standard.removeObject(forKey: Keys.ACCESS_TOKEN.rawValue)
    }
}
