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
    var to_name: String
    var to_phone_number: String
    var to_country_code: Int
    var send_at: Date
}
extension SOS {
    init?(json: JSON) {
        guard
            let _id = json["_id"].string,
            let _message = json["message"].string,
            let _to_name = json["to_name"].string,
            let _to_phone_number = json["to_phone_number"].string,
            let _to_country_code = json["to_country_code"].int,
            let _dt = json["send_at"].string
        else {
            debugPrint("Error parsing SOS json")
            return nil
        }
//        let _message = json["message"].string,
        
        // Workaround for ISO8601DateFormatter not supporting fractional secconds.
        let trimmedIsoString = _dt.replacingOccurrences(of: "\\.\\d+", with: "", options: .regularExpression)
        guard let _send_at = ISO8601DateFormatter().date(from: trimmedIsoString) else { return nil }

        self.init(id: _id,
                  message: _message,
                  to_name: _to_name,
                  to_phone_number: _to_phone_number,
                  to_country_code: _to_country_code,
                  send_at: _send_at)
    }
}
