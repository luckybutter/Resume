//
//  Presenter.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation

//Presents Things. Pretty Straight Forward here.
protocol Presenter {
    
}

/// Added the "weak" on the variable name to reinforce that it should be weakly linked.
protocol ViewControllerPresenter: Presenter, ViewControllerDelegateResponder {
    associatedtype ViewController
    associatedtype ViewControllerBrain
    var weakViewController:ViewController? { get }
    var weakViewControllerBrain:ViewControllerBrain? { get }
}
