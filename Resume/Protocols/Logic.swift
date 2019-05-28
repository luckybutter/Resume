//
//  Logic.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation

/// Logic objects are meant to think, synthesize information and communicate outward.
protocol Logic {
    
}

protocol ViewControllerDelegateResponder {
    
}

/// Sets up the two 
protocol ViewControllerLogic: Logic, ViewControllerDelegateResponder {
    associatedtype ViewController
    associatedtype ViewControllerPresenter
    
    /// Do not forget to declare `weak`, for safety purposes
    var weakViewController:ViewController? { get }
    
    /// Do not forget to declare `weak`, for safety purposes
    var weakViewControllerPresenter:ViewControllerPresenter? { get }
}

extension ViewControllerDelegateResponder {
    func handleViewDidLoad() {}
    func handleViewWillAppear() {}
    func handleViewDidAppear() {}
    func handleViewWillDisappear() {}
    func handleViewDidDisappear() {}
}
