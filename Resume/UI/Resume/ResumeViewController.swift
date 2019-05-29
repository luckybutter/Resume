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
    
    let logic = ResumeViewControllerLogic()
    let presenter = ResumeViewControllerPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        logic.weakViewController = self
        logic.weakViewControllerPresenter = presenter
        
        presenter.weakViewController = self
        presenter.weakViewControllerBrain = logic
        
        logic.handleViewDidLoad()
        presenter.handleViewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        logic.handleViewWillAppear()
        presenter.handleViewWillAppear()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        logic.handleViewDidAppear()
        presenter.handleViewDidAppear()
    }

}

