//
//  SideMenuCell.swift
//  myHero
//
//  Created by Natan Kaspy on 06/11/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label : UILabel!
    
    func configure(with page : utils.Page){
        label.text = page.name
        img.image = page.getImg()
    }

}
