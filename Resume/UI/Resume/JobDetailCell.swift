//
//  JobDetailCell.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

class JobDetailCell: UITableViewCell, OneTimeSetup {
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var hasSetup: Bool = false
    
    func setup(withDetailText text:String) {
        oneTimeCheckAndSetupIfPossible()
        
        self.detailLabel.text = "💡 " + text
    }
    
    func handleFirstTimeSetup() {
        self.detailLabel.font = AppConstant.quickFont(family: .lato, weight: .regular).withSize(14)
    }
}
