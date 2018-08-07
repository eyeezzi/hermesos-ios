//
//  ProfileVC.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit

class ProfileVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signOut(_ sender: Any) {
        UserDefaults.standard.deleteToken()
        performSegue(withIdentifier: "dismissProfile", sender: nil)
    }
}

