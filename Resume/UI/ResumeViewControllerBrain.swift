//
//  ResumeViewControllerBrain.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation
import Firebase

class ResumeViewControllerBrain: ViewControllerBrain {
    typealias ViewController = ResumeViewController
    typealias ViewControllerPresenter = ResumeViewControllerPresenter
    
    weak var weakViewController: ResumeViewController?
    weak var weakViewControllerPresenter: ResumeViewControllerPresenter?
    
    var jobs:[Job] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.weakViewControllerPresenter?.refreshUI()
            }
        }
    }
    
    
    func handleViewDidLoad() {
        let db = Firestore.firestore()
        db.collection("job").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var extractedJobs:[Job] = []
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    
                    let job = Job(firestoreObjectPayload: document.data())
                    extractedJobs.append(job)
                }
                
                self.jobs = extractedJobs
            }
        }

    }
    
    func handleViewWillAppear() {
        
    }
    
    func handleViewDidAppear() {
        
    }
}
