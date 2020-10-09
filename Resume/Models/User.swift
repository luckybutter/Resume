//
//  User.swift
//  Resume
//
//  Created by Matthew Canoy on 5/29/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation
import Firebase

struct User: FirestoreLoadable {
    static let collectionKey: String = "user"
    
    let name:String
    let imageUrl:String
    let blurb:String
    
    enum CodingKeys : String {
        case name
        case imageUrl
        case blurb
    }
    
    init?(firestoreObjectPayload payload: [String : Any]) {
        self.name = (payload[CodingKeys.name.rawValue] as? String) ?? ""
        self.imageUrl = (payload[CodingKeys.imageUrl.rawValue] as? String) ?? ""
        self.blurb = (payload[CodingKeys.blurb.rawValue] as? String) ?? ""
    }
}
