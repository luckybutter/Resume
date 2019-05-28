//
//  Brain.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation

/// Brains are meant to think, synthesize information and communicate outward.
protocol Brain {
    
}

protocol ViewControllerDelegateResponder {
    
}

protocol ViewControllerBrain: Brain, ViewControllerDelegateResponder {
    associatedtype ViewController
    associatedtype ViewControllerPresenter
    
    var weakViewController:ViewController? { get }
    var weakViewControllerPresenter:ViewControllerPresenter? { get }
    
}

extension ViewControllerDelegateResponder {
    func handleViewDidLoad() {}
    func handleViewWillAppear() {}
    func handleViewDidAppear() {}
    func handleViewWillDisappear() {}
    func handleViewDidDisappear() {}
}
