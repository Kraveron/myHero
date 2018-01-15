//
//  Comics.swift
//  myHero
//
//  Created by yakir on 19/11/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit

class Comics: NSObject {
    
    let id : Int
    let title : String?
    let desc : String?
    let thumbnail : URL?
    
    init?(_ dict : [String:Any] ) {
        
        guard let id = dict["id"] as? Int else{
            return nil
        }
        self.id = id
        self.title = dict["title"] as? String
        self.desc = dict["description"] as? String
        
        self.thumbnail = URL(dict: dict["thumbnail"] as? [String:String])
      
        
        super.init()
    }
}
