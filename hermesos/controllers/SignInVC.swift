//
//  SignInVC.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit

class SignInVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signIn(_ sender: Any) {
        UserDefaults.standard.saveToken(value: "test")
        performSegue(withIdentifier: "dismissSignIn", sender: nil)
    }
}
