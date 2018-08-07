//
//  SplashVC.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit

class SplashVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.saveToken(value: "test-token")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        decidePath()
    }
    
    fileprivate func decidePath() {
        guard let _ = UserDefaults.standard.getToken() else {
            performSegue(withIdentifier: "gotoLogin", sender: nil)
            return
        }
        
        performSegue(withIdentifier: "gotoDashboard", sender: nil)
    }
}
