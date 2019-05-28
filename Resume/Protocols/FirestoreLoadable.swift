//
//  FirestoreLoadable.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation
import Firebase
import PromiseKit

protocol FirestoreLoadable {
    init?(firestoreObjectPayload payload:[String:Any])
    static var collectionKey:String { get }
}

struct FirestoreWorker<T:FirestoreLoadable>: Worker {
    
    /// Fetch an array of `FirestoreLoadable` objects from Firestore based on the Fireloadable object's `collectionKey`
    ///
    /// - Returns: Promise that may produce an array of FirestoreLoadable objects
    func fetchArray() -> Promise<[T]> {
        return Promise<[T]> { seal in
            let db = Firestore.firestore()
            db.collection(T.collectionKey).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    seal.reject(err)
                } else {
                    var extractedLoadables:[T] = []
                    for document in querySnapshot!.documents {
                        if let loadable = T(firestoreObjectPayload: document.data()) {
                            extractedLoadables.append(loadable)
                        } else {
                            assertionFailure("Invalid object loaded")
                        }
                    }
                    
                    seal.fulfill(extractedLoadables)
                }
            }
        }
    }
}
