//
//  SideMenuViewController.swift
//  myHero
//
//  Created by Natan Kaspy on 06/11/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var heightLayout : NSLayoutConstraint!
    
    
    let tableArrray = utils.Page.all
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArrray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tcell", for: indexPath) as! SideMenuCell
        
        cell.configure(with: tableArrray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let nav = self.sideMenuViewController.contentViewController as? UINavigationController
        let center = nav?.viewControllers.first as? CollectionViewController
        
        switch indexPath.row{
            
        case 0:
            center?.offset = 0
            center?.name = nil
            center?.refresh()
            
        case 1:
            center?.loadFavorites()
            
        case 2:
            center?.loadPopular()
            
        default:
            self.sideMenuViewController.hideViewController()
        }
    
            self.sideMenuViewController.hideViewController()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }
}
