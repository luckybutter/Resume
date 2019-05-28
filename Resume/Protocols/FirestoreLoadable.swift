//
//  FirestoreLoadable.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation

protocol FirestoreLoadable {
    init?(firestoreObjectPayload payload:[String:Any])
    var collectionKey:String { get }
}
