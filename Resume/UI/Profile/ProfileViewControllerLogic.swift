//
//  ProfileViewController.swift
//  Resume
//
//  Created by Matthew Canoy on 5/29/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation
import Firebase

class ProfileViewControllerLogic: ViewControllerLogic {
    typealias ViewController = ProfileViewController
    typealias ViewControllerPresenter = ProfileViewControllerPresenter
    
    weak var weakViewController: ProfileViewController?
    weak var weakViewControllerPresenter: ProfileViewControllerPresenter?
    
}
