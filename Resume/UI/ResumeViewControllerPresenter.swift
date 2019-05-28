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
        let tableView = weakViewController?.jobsTableView
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        
        let control = UIRefreshControl()
        tableView?.refreshControl = control
        
        control.attributedTitle = NSAttributedString(string: "")
        control.addTarget(self, action: #selector(spinnerRefresh(sender:)), for: UIControl.Event.valueChanged)
        tableView?.addSubview(control)
    }
    
    func handleViewWillAppear() {
        refreshUI()
    }
    
    func handleViewDidAppear() {
        
    }
    
    @objc func spinnerRefresh(sender: UIRefreshControl) {
        weakViewControllerBrain?.fetchJobs()
    }
}

extension ResumeViewControllerPresenter {
    func refreshUI() {
        weakViewController?.jobsTableView.reloadData()
    }
    
    func presentError(_ error:Error) {
        let alert = UIAlertController(title: "I'm Sorry", message: "Here's the error: \(error)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        
        DispatchQueue.main.async { [weak self] in
            guard let vc = self?.weakViewController else {
                return
            }
            
            vc.present(alert, animated: true, completion: {
                
            })
        }
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
        cell.layoutIfNeeded()
    }
}
