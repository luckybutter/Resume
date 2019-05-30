//
//  ProfileViewController.swift
//  Resume
//
//  Created by Matthew Canoy on 5/29/19.
//  Copyright © 2019 luckybutter. All rights reserved.
//

import UIKit
import SDWebImage

class ProfileViewControllerPresenter: NSObject, ViewControllerPresenter {
    typealias ViewController = ProfileViewController
    typealias ViewControllerBrain = ProfileViewControllerLogic
    
    weak var weakViewController: ProfileViewController?
    weak var weakViewControllerBrain: ProfileViewControllerLogic?
    
    var currentUser:User?
    var currentTags:[String]?
    
    func handleViewWillAppear() {
        guard let vc = weakViewController else {
            assertionFailure("view controller should exist")
            return
        }
        
        weakViewController?.myImageView.alpha = 0
        
        vc.nameLabel.font = AppConstant.quickFont(family: .lato, weight: .black).withSize(42)
        vc.blurbLabel.font = AppConstant.quickFont(family: .lato, weight: .boldItalic).withSize(28)
        
        vc.myImageView.layer.cornerRadius = vc.myImageView.frame.height/2
        vc.imageContainerView.layer.cornerRadius = vc.imageContainerView.frame.height/2
        vc.imageContainerView.layer.borderColor = UIColor.white.cgColor
        vc.imageContainerView.layer.borderWidth = 2
        
        let shadowColor = UIColor.black.cgColor
        vc.imageContainerView.layer.shadowColor = shadowColor
        vc.imageContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        vc.imageContainerView.layer.shadowPath = UIBezierPath(roundedRect: vc.imageContainerView.bounds, cornerRadius: vc.imageContainerView.layer.cornerRadius).cgPath
        vc.imageContainerView.layer.masksToBounds = false
        vc.imageContainerView.layer.shadowRadius = 2
        vc.imageContainerView.layer.shadowOpacity = 1
    }
    
    func load(withUser user:User) {
        DispatchQueue.main.async {
            self.currentUser = user
            self.reloadUserElements()
        }
    }
    
    func load(withTags tags:[String]) {
        DispatchQueue.main.async {
            self.currentTags = tags
            self.reloadTagElement()
        }
    }
    
    func reloadUserElements() {
        guard let user = currentUser else {
            return
        }
        
        weakViewController?.blurbLabel.text = user.blurb
        
        let url = URL(string: user.imageUrl)
        
        weakViewController?.myImageView.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached, completed: { (image, error, cacheType, imageUrl) in
            guard image != nil else {
                return
            }
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.35, animations: { [weak self] in
                    self?.weakViewController?.myImageView.alpha = 1
                }, completion: nil)
            }
        })
        
        
    }
    
    func reloadTagElement() {
        
    }
}

fileprivate extension ProfileViewControllerPresenter {
    
}
