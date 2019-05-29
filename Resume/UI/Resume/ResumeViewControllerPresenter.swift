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
    typealias ViewControllerBrain = ResumeViewControllerLogic
    
    weak var weakViewController: ResumeViewController?
    weak var weakViewControllerBrain: ResumeViewControllerLogic?
    
    let control = UIRefreshControl()
    
    func handleViewDidLoad() {
        let tableView = weakViewController?.jobsTableView
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.estimatedRowHeight = UITableView.automaticDimension
        tableView?.refreshControl = control
        
        control.attributedTitle = NSAttributedString(string: "")
        control.addTarget(self, action: #selector(spinnerRefresh(sender:)), for: UIControl.Event.valueChanged)
        tableView?.addSubview(control)
    }
    
    func handleViewWillAppear() {
        refreshUI()
    }
    
    @objc func spinnerRefresh(sender: UIRefreshControl) {
        weakViewControllerBrain?.fetchJobs()
    }
    
    func refreshUI() {
        weakViewController?.jobsTableView.reloadData()
        control.endRefreshing()
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
        return weakViewControllerBrain?.currentDisplayInfos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let infos = weakViewControllerBrain?.currentDisplayInfos else {
            assertionFailure("infos should exist")
            return UITableViewCell()
        }
        
        let info = infos[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: info.cellIdentifier, for: indexPath)
        
        switch info {
        case .title(let job):
            guard let jobTitleCell = cell as? JobTitleCell else {
                assertionFailure("The only cell in the application isn't returning")
                return cell
            }
            
            jobTitleCell.setup(withJob: job)
            
        case .detail(let text):
            guard let jobDetailCell = cell as? JobDetailCell else {
                assertionFailure("The only cell in the application isn't returning")
                return cell
            }
            
            jobDetailCell.setup(withDetailText: text)
        }
        
        return cell
    }
    
}
