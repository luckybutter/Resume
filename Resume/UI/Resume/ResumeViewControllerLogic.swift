//
//  ResumeViewControllerLogic.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation
import Firebase

enum ResumeDisplayInfo {
    ///Show: Base job information
    case title(Job)
    case detail(String)
    
    var cellIdentifier:String {
        switch self {
        case .title: return "JobTitleCell"
        case .detail: return "JobDetailCell"
        }
    }
}

class ResumeViewControllerLogic: ViewControllerLogic {
    typealias ViewController = ResumeViewController
    typealias ViewControllerPresenter = ResumeViewControllerPresenter
    
    weak var weakViewController: ResumeViewController?
    weak var weakViewControllerPresenter: ResumeViewControllerPresenter?
    
    var isFetchingJobs = false
    
    var currentDisplayInfos:[ResumeDisplayInfo] = []
    var jobs:[Job] = []
    
    func handleViewDidLoad() {
        fetchJobs()
    }
    
    /// Fetches for Job records from Firestore, but only if there isn't a fetch already going.
    func fetchJobs() {
        guard isFetchingJobs == false else {
            return
        }
        
        isFetchingJobs = true
        
        let worker = FirestoreWorker<Job>()
        worker.fetchArray().done { [weak self] jobs in
            self?.updateDisplayInfos(fromJobs: jobs)
        }.catch { [weak self] error in
            self?.weakViewControllerPresenter?.presentError(error)
            self?.isFetchingJobs = false
        }
    }
}

fileprivate extension ResumeViewControllerLogic {
    
    /// Sorts the Jobs according to their Start Dates and updates the DisplayInfos that depict the order of cells Displayed along with the information delivered
    ///
    /// - Parameter jobs: Unsorted Jobs
    func updateDisplayInfos(fromJobs jobs:[Job]) {
        self.jobs = jobs.sorted(by: { (l, r) -> Bool in
            return r.startDate < l.startDate
        })
        
        var updatedInfos:[ResumeDisplayInfo] = []
        
        for job in self.jobs {
            updatedInfos.append(ResumeDisplayInfo.title(job))
            
            for detail in job.details {
                updatedInfos.append(ResumeDisplayInfo.detail(detail))
            }
        }
        
        self.currentDisplayInfos = updatedInfos
        
        DispatchQueue.main.async { [weak self] in
            self?.weakViewControllerPresenter?.refreshUI()
            self?.isFetchingJobs = false
        }
    }
}
