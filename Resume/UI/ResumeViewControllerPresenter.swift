//
//  ViewControllerPresenter.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

class ResumeViewControllerPresenter: NSObject, ViewControllerPresenter {
    typealias ViewController = ResumeViewController
    typealias ViewControllerBrain = ResumeViewControllerBrain
    
    weak var weakViewController: ResumeViewController?
    weak var weakViewControllerBrain: ResumeViewControllerBrain?
    
    func handleViewDidLoad() {
        weakViewController?.jobsTableView.delegate = self
        weakViewController?.jobsTableView.dataSource = self
        weakViewController?.jobsTableView.rowHeight = UITableView.automaticDimension
        weakViewController?.jobsTableView.estimatedRowHeight = 400
    }
    
    func handleViewWillAppear() {
        refreshUI()
    }
    
    func handleViewDidAppear() {
        
    }
}

extension ResumeViewControllerPresenter {
    func refreshUI() {
        weakViewController?.jobsTableView.reloadData()
    }
}

extension ResumeViewControllerPresenter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weakViewControllerBrain?.jobs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "JobCell", for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? JobCell else {
            assertionFailure("The only cell in the application isn't returning")
            return
        }
        
        guard let jobs = weakViewControllerBrain?.jobs else {
            assertionFailure("brain is nil")
            return
        }
        
        cell.setup(withJob: jobs[indexPath.row])
    }
}
