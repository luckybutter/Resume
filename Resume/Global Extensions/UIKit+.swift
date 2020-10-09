//
//  UIKit+.swift
//  Resume
//
//  Created by Matthew Canoy on 5/29/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func quickAlert(withTitle title:String, message:String = "", fromViewController viewController:UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        viewController.present(alert, animated: true)
    }
}

extension UIViewController {
    func showQuickAlert(withTitle title:String, message:String = "") {
        UIAlertController.quickAlert(withTitle: title, message: message, fromViewController: self)
    }
}
