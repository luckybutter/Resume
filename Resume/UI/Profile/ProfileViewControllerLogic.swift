//
//  ProfileViewController.swift
//  Resume
//
//  Created by Matthew Canoy on 5/29/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation
import Firebase

/// Shows a rough percentage of total time in the working career with the tag
struct TagHeatDisplayInfo {
    let tag:String
    let ratio:Float
}

class ProfileViewControllerLogic: ViewControllerLogic {
    typealias ViewController = ProfileViewController
    typealias ViewControllerPresenter = ProfileViewControllerPresenter
    
    weak var weakViewController: ProfileViewController?
    weak var weakViewControllerPresenter: ProfileViewControllerPresenter?
    
    func handleViewDidLoad() {
        
    }
    
    func handleViewWillAppear() {
        fetchMe()
        fetchTags()
    }
    
    func fetchMe() {
        let worker = FirestoreWorker<User>()
        worker.fetch(byId: "me").done { [weak self] (user) in
            self?.weakViewControllerPresenter?.load(withUser: user)
        }.catch { [weak self] error in
            switch error {
            case FirestoreError.failedObjectLoad(let payload):
                print(payload)
                self?.weakViewController?.showQuickAlert(withTitle: "SORRY", message: "Matt made a model related bug.")
                
            case FirestoreError.retrievalFailed(let errorMessage):
                print(errorMessage)
                self?.weakViewController?.showQuickAlert(withTitle: "SORRY", message: "Retrieving data failed. Please try again ^_^.")
                
            default:
                assertionFailure("the only error messages should be from FireStoreError")
                self?.weakViewController?.showQuickAlert(withTitle: "SORRY", message: "Matt isn't handling his errors properly. Tsk tsk.")
                
                print(error)
            }
        }
    }
    
    func fetchTags() {
        let worker = FirestoreWorker<Job>()
        worker.fetchArray().done { [weak self] (jobs) in
            self?.updateTagHeatDisplayInfo(fromJobs: jobs)
        }.catch { [weak self] error in
                
        }
    }
}

fileprivate extension ProfileViewControllerLogic {
    
    /// "Heat" is determined from a ratio of length a "tag" has been in the work career
    /// X Months of Tag / X Months of Total Work
    /// The calculation isn't meant to be accurate to the month but show a general ratio
    /// - Parameter jobs: Jobs retrieved from Firestore
    func updateTagHeatDisplayInfo(fromJobs jobs:[Job]) {
        var totalMonths = 0
        var tagToMonths:[String:Int] = [:]
        
        for job in jobs {
            let startDate = job.startDate
        }
    }
}
