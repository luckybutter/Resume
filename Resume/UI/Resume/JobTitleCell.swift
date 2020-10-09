//
//  JobTitleCell.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

class JobTitleCell: UITableViewCell, OneTimeSetup {
    @IBOutlet weak var employerTitleLabel: UILabel!
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    
    var hasSetup: Bool = false
    
    func setup(withJob job:Job) {
        oneTimeCheckAndSetupIfPossible()
        
        employerTitleLabel.text = job.employerTitle
        jobTitleLabel.text = job.jobTitle
        
        setupTagsDisplay(tags: job.tags)
        setupDateText(fromStartDate: job.startDate, endDate: job.endDate)
    }
    
    func setupTagsDisplay(tags:[String]) {
        let sortedTags = tags.sorted(by: { $0 < $1 })
        
        var tagsText = ""
        for tag in sortedTags {
            tagsText += "\(tag)   "
        }
        
        tagsLabel.text = tagsText
    }
    
    func setupDateText(fromStartDate startDate:Date?, endDate:Date?) {
        guard let startDate = startDate else {
            assertionFailure("Start Date must always be valid")
            return
        }
        
        var dateText = ""
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        dateText += formatter.string(from: startDate)
        
        if let endDate = endDate {
            dateText += " - \(formatter.string(from: endDate))"
        } else {
            dateText += " - Current"
        }
        
        dateLabel.text = dateText
    }
    
    func handleFirstTimeSetup() {
        employerTitleLabel.font = AppConstant.quickFont(family: .lato, weight: .black).withSize(20)
        jobTitleLabel.font = AppConstant.quickFont(family: .lato, weight: .bold).withSize(17)
        dateLabel.font = AppConstant.quickFont(family: .lato, weight: .bold).withSize(12)
        tagsLabel.font = AppConstant.quickFont(family: .lato, weight: .italic).withSize(11)
    }
}
