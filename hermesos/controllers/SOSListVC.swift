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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSOS()
    }
    
    func fetchSOS() {
        let headers: HTTPHeaders = [
            "x-access-token": AccessTokenManager.getToken() ?? ""
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SOSCell", for: indexPath) as! SOSCell
        cell.sos = sosList[indexPath.row]
        cell.delegate = self
        return cell;
    }
}

extension SOSListVC: SOSCellDelegate {
    /* @deprecated
    func deleteCell(_ cell: SOSCell) {
        let alertController = UIAlertController(title: "Delete SOS", message: "Are you sure about this?", preferredStyle: .alert)

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let delete = UIAlertAction(title: "Delete", style: .destructive, handler: {
            (action) in
            print("todo: delete from database and table")
        })

        alertController.addAction(delete)
        alertController.addAction(cancel)

        self.present(alertController, animated: true, completion: nil)
    }
    */
    func deleteCell(_ cell: SOSCell) {
        guard
            let sos = cell.sos,
            let indexPath = tableView.indexPath(for: cell) else { return }
        
        let headers: HTTPHeaders = [
            "x-access-token": AccessTokenManager.getToken() ?? ""
        ]
        
        let endpoint = Endpoints.SOS + "/" + sos.id
        Alamofire.request(endpoint, method: .delete, headers: headers)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(_):
                    self.sosList.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                case .failure(let error):
                    print(error.localizedDescription)
                    guard let data = response.data else { return }
                    print(JSON(data))
                }
        }
    }
}
