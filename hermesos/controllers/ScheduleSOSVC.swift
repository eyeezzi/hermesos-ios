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
        name.delegate = self
        phone.delegate = self
        message.delegate = self
    }
    
    @IBAction func cancelScheduling(_ sender: Any) {
        performSegue(withIdentifier: "dismissScheduleSOS", sender: nil)
    }
    @IBAction func scheduleSOS(_ sender: Any) {
        guard
            let name = name.text, !name.isEmpty,
            let phone = phone.text, phone.isPhoneNumber(),
            let message = message.text, !message.isEmpty
        else {
            return
        }
        
        let date = Date(timeIntervalSinceNow: self.time.countDownDuration)
        
        createSOS(message: message, name: name, phone: phone, countryCode: 1, date: date)
    }
    
    func createSOS(message: String, name: String, phone: String, countryCode: Int, date: Date) {
        let headers: HTTPHeaders = [
            "x-access-token": AccessTokenManager.getToken() ?? ""
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
extension ScheduleSOSVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // If textfield is empty, add red border.
        if let txt = textField.text, txt.count <= 1, string.isEmpty {
            textField.layer.borderColor = UIColor.red.cgColor
            textField.layer.borderWidth = 1.0
        } else {
            textField.layer.borderWidth = 0
        }
        return true
    }
}
extension ScheduleSOSVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if let txt = textView.text, txt.isEmpty {
            textView.layer.borderColor = UIColor.red.cgColor
            textView.layer.borderWidth = 1.0
            return
        }
        textView.layer.borderWidth = 0
    }
}
