//
//  CreateSOS.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-07.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit

class ScheduleSOSVC : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelScheduling(_ sender: Any) {
        performSegue(withIdentifier: "dismissScheduleSOS", sender: nil)
    }
    @IBAction func scheduleSOS(_ sender: Any) {
        // todo: validation and network call
        performSegue(withIdentifier: "dismissScheduleSOS", sender: nil)
    }
}
