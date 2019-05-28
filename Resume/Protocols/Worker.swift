//
//  Worker.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation
import Firebase
import PromiseKit

protocol Worker {
    
}


struct FirebaseWorker<T:FirestoreLoadable> {
    
    func fetchArray() -> Promise<[T]> {
        return Promise<[T]> { seal in
            let db = Firestore.firestore()
            db.collection("job").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                    seal.reject(err)
                } else {
                    var extractedLoadables:[T] = []
                    for document in querySnapshot!.documents {
                        print("\(document.documentID) => \(document.data())")
                        
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
