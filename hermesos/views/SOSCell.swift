//
//  SOSCell.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-09.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import UIKit

protocol SOSCellDelegate: class {
    func deleteCell(_ cell: SOSCell)
}
class SOSCell: UITableViewCell {
    
    weak var delegate: SOSCellDelegate?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var sos: SOS? {
        didSet {
            guard let sos = sos else { return }
            
            name.text = sos.to_name.localizedCapitalized
            message.text = sos.message
            phone.text = sos.to_phone_number
            time.text = DateFormatter.localizedString(from: sos.send_at, dateStyle: .none, timeStyle: .short)
        }
    }
    
    @IBAction func deleteSOS(_ sender: Any) {
        delegate?.deleteCell(self)
    }
    
}
