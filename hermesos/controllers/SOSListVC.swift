//
//  SOSListVC.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class SOSListVC : UITableViewController {
    var sosList: [SOS] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSOS()
    }
    
    func fetchSOS() {
        let headers: HTTPHeaders = [
            "x-access-token": UserDefaults.standard.getToken() ?? ""
        ]
        Alamofire.request(Endpoints.SOS, method: .get, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    guard let list = JSON(value).array else { return }
                    self.sosList = list.compactMap({ SOS.init(json: $0) })
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                    guard let data = response.data else { return }
                    print(JSON(data))
                }
            }
    }
    
    @IBAction func openSOSCreationForm(_ sender: Any) {
        performSegue(withIdentifier: "gotoCreateSOS", sender: nil)
    }
}

extension SOSListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sosList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SOSCell", for: indexPath)
        // todo: customize cell
        return cell;
    }
}
