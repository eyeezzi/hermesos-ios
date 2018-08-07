//
//  User.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-07.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var id: String
    var name: String
    var phone_number: String
    var country_code: String
    var sms_remaining: UInt
}
extension User {
    init?(json: JSON) {
        guard
            let _id = json["id"].string,
            let _name = json["name"].string,
            let _phone_number = json["phone_number"].string,
            let _country_code = json["country_code"].string,
            let _sms_remaining = json["sms_remaining"].uInt
        else {
            debugPrint(json)
            return nil
        }
        
        self.init(id: _id,
                  name: _name,
                  phone_number: _phone_number,
                  country_code: _country_code,
                  sms_remaining: _sms_remaining)
    }
}
