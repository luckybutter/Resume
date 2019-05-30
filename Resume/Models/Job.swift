//
//  Job.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation
import Firebase


struct Job: FirestoreLoadable {
    static let collectionKey: String = "job"
    
    let jobTitle:String
    let employerTitle:String
    let startDate:Date
    let endDate:Date?
    let details:[String]
    let tags:[String]
    
    enum CodingKeys : String {
        case jobTitle
        case employerTitle
        case startDate
        case endDate
        case details
        case tags
    }
    
    init?(firestoreObjectPayload payload: [String : Any]) {
        self.jobTitle = (payload[CodingKeys.jobTitle.rawValue] as? String) ?? ""
        self.employerTitle = (payload[CodingKeys.employerTitle.rawValue] as? String) ?? ""
        self.details = (payload[CodingKeys.details.rawValue] as? [String]) ?? []
        self.tags = (payload[CodingKeys.tags.rawValue] as? [String]) ?? []
        
        if let startTimeStamp = (payload[CodingKeys.startDate.rawValue] as? Timestamp) {
            self.startDate = startTimeStamp.dateValue()
        } else {
            return nil
        }
        
        if let endTimeStamp = (payload[CodingKeys.endDate.rawValue] as? Timestamp) {
            self.endDate = endTimeStamp.dateValue()
        } else {
            self.endDate = nil
        }
        
    }
}
