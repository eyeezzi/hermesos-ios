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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        decidePath()
    }
    
    fileprivate func decidePath() {
        guard let _ = AccessTokenManager.getToken() else {
            performSegue(withIdentifier: "gotoLogin", sender: nil)
            return
        }
        // todo: GET /me to verify token validity
        performSegue(withIdentifier: "gotoDashboard", sender: nil)
    }
}
