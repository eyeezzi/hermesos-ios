//
//  SOSListVC.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit

class SOSListVC : UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func openSOSCreationForm(_ sender: Any) {
        performSegue(withIdentifier: "gotoCreateSOS", sender: nil)
    }
    
}

