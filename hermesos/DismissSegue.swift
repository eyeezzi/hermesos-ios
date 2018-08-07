//
//  DismissSegue.swift
//  hermesos
//
//  Created by Uzziah on 2018-08-06.
//  Copyright © 2018 eyeezzi. All rights reserved.
//

import Foundation
import UIKit

class DismissSegue: UIStoryboardSegue {
    override func perform() {
        if let vc = source.presentingViewController {
            vc.dismiss(animated: true, completion: nil)
        }
    }
}
