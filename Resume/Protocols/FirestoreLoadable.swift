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

enum FirestoreError: Swift.Error {
    case retrievalFailed(errorMessage:String)
    case failedObjectLoad(payload:[String:Any])
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
                            seal.reject(FirestoreError.failedObjectLoad(payload: document.data()))
                        }
                    }
                    
                    seal.fulfill(extractedLoadables)
                }
            }
        }
    }
    
    func fetch(byId id:String) -> Promise<T> {
        return Promise<T> { seal in
            let db = Firestore.firestore()
            db.collection(T.collectionKey).document(id).getDocument(completion: { (document, error) in
                if let document = document, let data = document.data() {
                    if let loadable:T = T(firestoreObjectPayload: data) {
                        seal.fulfill(loadable)
                    } else {
                        seal.reject(FirestoreError.failedObjectLoad(payload: data))
                    }
                } else {
                    seal.reject(FirestoreError.retrievalFailed(errorMessage: error?.localizedDescription ?? ""))
                }
            })
        }
    }
}
