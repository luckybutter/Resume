//
//  JobCell.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell, OneTimeSetup {
    @IBOutlet weak var employerTitleLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var hasSetup: Bool = false
    
    func setup(withJob job:Job) {
        oneTimeCheckAndSetupIfPossible()
        
        employerTitleLabel.text = job.employerTitle
        jobTitleLabel.text = job.jobTitle
        
        setupDetailsText(fromTextArray: job.details)
        setupDateText(fromStartDate: job.startDate, endDate: job.endDate)
        
    }
    
    func setupDetailsText(fromTextArray textArray:[String]) {
        var combinedText = ""
        
        for text in textArray {
            combinedText += "💡 \(text)\n"
        }
        
        detailsLabel.text = combinedText
    }
    
    func setupDateText(fromStartDate startDate:Date?, endDate:Date?) {
        guard let startDate = startDate else {
            assertionFailure("Start Date must always be valid")
            return
        }
        
        var dateText = ""
        
        let formatter = DateFormatter.yyyyMM
        dateText += formatter.string(from: startDate)
        
        if let endDate = endDate {
            dateText += "-\(formatter.string(from: endDate))"
        } else {
            dateText += "Current"
        }
        
        dateLabel.text = dateText
    }
    
    func handleFirstTimeSetup() {
        employerTitleLabel.font = AppConstant.quickFont(family: .lato, weight: .black)
        jobTitleLabel.font = AppConstant.quickFont(family: .lato, weight: .bold)
        dateLabel.font = AppConstant.quickFont(family: .lato, weight: .bold)
        detailsLabel.font = AppConstant.quickFont(family: .lato, weight: .regular)
    }
}
