//
//  utils.swift
//  myHero
//
//  Created by Natan Kaspy on 26/10/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import Foundation
import UIKit

extension URL{
    init?(dict : [String:String]?){
        guard let dict = dict else{
            return nil
        }
        
        guard let path = dict["path"], let ext = dict["extension"] else {
            return nil
        }
        
        let str = path + "." + ext
        self.init(string: str)
    }
}

class utils : NSObject{
    
    
  enum Page : String{
    
    case home = "Home"
    case favourite = "Favourite"
    case popular = "Popular"
    
    static let all : [Page] = [.home, .favourite, .popular]
    
    var name : String{
        get{
            switch self{
            case .home: return "Home"
            case .favourite: return "Favourite"
            case .popular: return "Popular"
    
            }
        }
    }
    
    func getImg() -> UIImage{
            switch self{
            case .home: return #imageLiteral(resourceName: "icons8-home_page")
            case .favourite: return #imageLiteral(resourceName: "icons8-like")
            case.popular: return #imageLiteral(resourceName: "icons8-star")
            }
        }
  }
}
    


