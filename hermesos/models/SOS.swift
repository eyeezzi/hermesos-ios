//
//  SOS.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-07.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SOS {
    var id: String
    var message: String
    var recipient_name: String
    var recipient_phone_number: String
    var recipient_country_code: String
    var scheduled_datetime: Date
}
extension SOS {
    init?(json: JSON) {
        guard
            let _id = json["id"].string,
            let _message = json["message"].string,
            let _recipient_name = json["recipient_name"].string,
            let _recipient_phone_number = json["recipient_phone_number"].string,
            let _recipient_country_code = json["recipient_country_code"].string,
            let _dt = json["datetime"].string,
            let _scheduled_datetime = ISO8601DateFormatter().date(from: _dt)
        else {
            debugPrint(json)
            return nil
        }
        
        self.init(id: _id,
                  message: _message,
                  recipient_name: _recipient_name,
                  recipient_phone_number: _recipient_phone_number,
                  recipient_country_code: _recipient_country_code,
                  scheduled_datetime: _scheduled_datetime)
    }
}
