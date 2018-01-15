//
//  UIViewController+Utils.swift
//  myHero
//
//  Created by Natan Kaspy on 06/11/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit
import RESideMenu

extension UIViewController{
    
    @IBAction func showMenu(){
        
        self.sideMenuViewController.presentLeftMenuViewController()
        
    }
    
}
