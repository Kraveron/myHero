//
//  ComicsTableViewCell.swift
//  myHero
//
//  Created by yakir on 15/11/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit
import SDWebImage

class ComicsTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var comicsImg: UIImageView!
    
    func configure(with comics : Comics ){
        
        label.text = comics.title
        
        
        if let url = comics.thumbnail{
            comicsImg.sd_setImage(with: url)
        }
        else {
            comicsImg.image = nil
            comicsImg.sd_cancelCurrentImageLoad()
        }
        
    }
}
