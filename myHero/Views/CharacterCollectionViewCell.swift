//
//  CharacterCollectionViewCell.swift
//  myHero
//
//  Created by Natan Kaspy on 25/10/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterImage: UIImageView!
    
    func configure(with hero : Heroes){
        
        characterName.text = hero.name
        
        if let url = hero.thumbnail{
            characterImage.sd_setImage(with: url)
        }
        else {
            characterImage.image = nil
            characterImage.sd_cancelCurrentImageLoad()
        }
        
        
    }

    
}
