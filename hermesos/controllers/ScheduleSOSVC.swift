//
//  CreateSOS.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-07.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class ScheduleSOSVC : UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var time: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelScheduling(_ sender: Any) {
        performSegue(withIdentifier: "dismissScheduleSOS", sender: nil)
    }
    @IBAction func scheduleSOS(_ sender: Any) {
        guard
            let name = name.text,
            let phone = phone.text,
            let message = message.text
        else {
            return
        }

        let date = Date(timeIntervalSinceNow: self.time.countDownDuration)
        
        createSOS(message: message, name: name, phone: phone, countryCode: 1, date: date)
    }
    
    func createSOS(message: String, name: String, phone: String, countryCode: Int, date: Date) {
        let headers: HTTPHeaders = [
            "x-access-token": UserDefaults.standard.getToken() ?? ""
        ]
        let body: Parameters = [
            "message": message,
            "to_name": name,
            "to_phone_number": phone,
            "to_country_code": countryCode,
            "send_at": ISO8601DateFormatter().string(from: date),
        ]
        Alamofire.request(Endpoints.SOS, method: .post, parameters: body, encoding: JSONEncoding.default, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    self.performSegue(withIdentifier: "dismissScheduleSOS", sender: nil)
                case .failure(let error):
                    print(error.localizedDescription)
                    guard let data = response.data else { return }
                    print(JSON(data))
                }
        }
    }
}
