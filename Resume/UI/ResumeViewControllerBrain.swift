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
    
    var isFetchingJobs = false
    
    var jobs:[Job] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.weakViewControllerPresenter?.refreshUI()
                self?.isFetchingJobs = false
            }
        }
    }
    
    
    func handleViewDidLoad() {
        fetchJobs()
    }
    
    func handleViewWillAppear() {
        
    }
    
    func handleViewDidAppear() {
        
    }
    
    func fetchJobs() {
        guard isFetchingJobs == false else {
            return
        }
        
        isFetchingJobs = true
        
        let worker = FirebaseWorker<Job>()
        worker.fetchArray().done { jobs in
            self.jobs = jobs.sorted(by: { (l, r) -> Bool in
                guard let startLeft = l.startDate, let startRight = r.startDate else {
                    return false
                }
                
                return startLeft > startRight
            })
        }.catch { [weak self] error in
            self?.weakViewControllerPresenter?.presentError(error)
            self?.isFetchingJobs = false
        }
    }
}
