//
//  ProfileViewController.swift
//  Resume
//
//  Created by Matthew Canoy on 5/29/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

class ProfileViewControllerPresenter: NSObject, ViewControllerPresenter {
    typealias ViewController = ProfileViewController
    typealias ViewControllerBrain = ProfileViewControllerLogic
    
    weak var weakViewController: ProfileViewController?
    weak var weakViewControllerBrain: ProfileViewControllerLogic?
    
    
}
