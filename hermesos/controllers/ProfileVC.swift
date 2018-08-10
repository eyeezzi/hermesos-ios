//
//  ProfileVC.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class ProfileVC : UIViewController {
    
    @IBOutlet weak var smsRemaining: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfile()
    }
    func refereshUI() {
        guard let user = user else { return }
        smsRemaining.text = String(user.sms_remaining)
        name.text = user.name
        phoneNumber.text = user.phone_number
    }
    func fetchProfile() {
        let headers: HTTPHeaders = [
            "x-access-token": UserDefaults.standard.getToken() ?? ""
        ]
        Alamofire.request(Endpoints.PROFILE, method: .get, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    self.user = User.init(json: json)
                    self.refereshUI()
                case .failure(let error):
                    print(error.localizedDescription)
                    guard let data = response.data else { return }
                    print(JSON(data))
                }
        }
    }
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.deleteToken()
        performSegue(withIdentifier: "dismissProfile", sender: nil)
    }
    @IBAction func deleteAccount(_ sender: Any) {
        // todo: DELETE /me
        UserDefaults.standard.deleteToken()
        performSegue(withIdentifier: "dismissProfile", sender: nil)
    }
}

