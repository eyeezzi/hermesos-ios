//
//  CreateAccountVC.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class CreateAccountVC : UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var verificationCode: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        verificationCode.isEnabled = false
        createBtn.isEnabled = false
    }
    
    func toggleUIMode() {
        name.isEnabled = !name.isEnabled
        phoneNumber.isEnabled = !phoneNumber.isEnabled
        requestBtn.isEnabled = !requestBtn.isEnabled
        verificationCode.isEnabled = !verificationCode.isEnabled
        createBtn.isEnabled = !createBtn.isEnabled
    }
    
    @IBAction func doRequestSMS(_ sender: Any) {
        guard
            let name = name.text,
            let phoneNumber = phoneNumber.text, phoneNumber.isPhoneNumber() else {
                return
        }
        requestSMS(name: name, phoneNumber: phoneNumber, countryCode: 1)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        guard let code = verificationCode.text else {
            return
        }
        verifyCode(code: code)
    }
    
    func requestSMS(name: String, phoneNumber: String, countryCode: Int) {
        
        let body: Parameters = [
            "name": name,
            "phone_number": phoneNumber,
            "country_code": countryCode
        ]
        
        Alamofire.request(Endpoints.SIGNUP_REQUEST_SMS, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    self.toggleUIMode()
                case .failure(_):
                    guard let data = response.data else { return }
                    print(JSON(data))
                }
        }
    }
    
    func verifyCode(code: String) {
        let body: Parameters = [
            "verification_code": code
        ]
        
        Alamofire.request(Endpoints.SIGNUP_VERIFY_CODE, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    guard let jwt = json["jwt"].string else { return }
                    UserDefaults.standard.saveToken(value: jwt)
                    self.performSegue(withIdentifier: "dismissCreateAccount", sender: nil)
                case .failure(let error):
                    print(error)
                    guard let data = response.data else { return }
                    print(JSON(data))
                }
        }
    }
}
