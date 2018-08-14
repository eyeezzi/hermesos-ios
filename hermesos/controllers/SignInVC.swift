//
//  SignInVC.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class SignInVC : UIViewController {
    
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var verificationCode: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func requestSMS(_ sender: Any) {
        guard let phoneNumber = phoneNumber.text, phoneNumber.isPhoneNumber() else {
            return
        }
        
        requestSM(phoneNumber: phoneNumber, countryCode: 1)
    }
    
    @IBAction func signIn(_ sender: Any) {
        guard let code = verificationCode.text else {
            return
        }
        verifyCode(code: code)
    }
    
    func requestSM(phoneNumber: String, countryCode: Int) {
        
        let body: Parameters = [
            "phone_number": phoneNumber,
            "country_code": 1
        ]
        
        Alamofire.request(Endpoints.SIGNIN_REQUEST_SMS, method: .post, parameters: body, encoding: JSONEncoding.default, headers: nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                case .failure(let error):
                    print(error.localizedDescription)
                    guard let data = response.data else { return }
                    print(JSON(data))
                }
        }
    }
    
    func verifyCode(code: String) {
        let body: Parameters = [
            "verification_code": code
        ]
        
        Alamofire.request(Endpoints.SIGNIN_VERIFY_CODE, method: .post, parameters: body, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    guard let jwt = json["jwt"].string else { return }
                    UserDefaults.standard.saveToken(value: jwt)
                    self.performSegue(withIdentifier: "dismissSignIn", sender: nil)
                case .failure(let error):
                    print(error)
                    guard let data = response.data else { return }
                    print(JSON(data))
                }
        }
    }
}
