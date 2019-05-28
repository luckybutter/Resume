//
//  OneTimeSetup.swift
//  Resume
//
//  Created by Matthew Canoy on 5/27/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import Foundation

/// Sometimes forcing a little bit of protocol conformance is a good thing for establishing processes
protocol OneTimeSetup: class {
    var hasSetup:Bool { get set }
    func handleFirstTimeSetup()
}

extension OneTimeSetup {
    func oneTimeCheckAndSetupIfPossible() {
        guard hasSetup == false else {
            return
        }
        
        hasSetup = true
        
        handleFirstTimeSetup()
    }
}
