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
        fetchSOS()
    }
    
    func fetchSOS() {
        // todo: make network call
        // save result & reload table
        // handle errors
    }
    
    @IBAction func openSOSCreationForm(_ sender: Any) {
        performSegue(withIdentifier: "gotoCreateSOS", sender: nil)
    }
}

extension SOSListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // todo: use count of internal array
        return 2
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SOSCell", for: indexPath)
        // todo: customize cell
        return cell;
    }
}
