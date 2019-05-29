//
//  ProfileViewController.swift
//  Resume
//
//  Created by Matthew Canoy on 5/29/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    let logic = ProfileViewControllerLogic()
    let presenter = ProfileViewControllerPresenter()
    
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
