//
//  ResumeViewController.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

class ResumeViewController: UIViewController {
    @IBOutlet weak var jobsTableView: UITableView!
    
    let brain = ResumeViewControllerBrain()
    let presenter = ResumeViewControllerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        brain.weakViewController = self
        brain.weakViewControllerPresenter = presenter
        
        presenter.weakViewController = self
        presenter.weakViewControllerBrain = brain
        
        brain.handleViewDidLoad()
        presenter.handleViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        brain.handleViewWillAppear()
        presenter.handleViewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        brain.handleViewDidAppear()
        presenter.handleViewDidAppear()
    }

}

