//
//  Heroes.swift
//  myHero
//
//  Created by Natan Kaspy on 26/10/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit



class Heroes : NSObject {
    
    let id : Int
    let name : String?
    let desc : String?
    let thumbnail : URL?
    //let comics : Comics?
    //let favourite : Bool?
    
    init?(_ dict : [String:Any] ) {
        guard let id = dict["id"] as? Int else{
            return nil
        }
        self.id = id
        self.name = dict["name"] as? String
        self.desc = dict["description"] as? String
        
        
        self.thumbnail = URL(dict: dict["thumbnail"] as? [String:String])
        
        //self.comics = dict["comics"] as? Comics
        //self.favourite = dict["favourite"] as? Bool
        
        super.init()
    }
    
    
}

