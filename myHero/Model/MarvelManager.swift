//
//  MarvelManager.swift
//  myHero
//
//  Created by Natan Kaspy on 26/10/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit
import CryptoSwift
import Alamofire

class MarvelManager: NSObject {
    static let manager = MarvelManager()
    
    private let baseURL = "http://gateway.marvel.com/v1/public/"
    
    private func addDefaultParmas(to dict : [String:Any]) -> [String:Any]{
        
        let publicKey = "1ce7b753f242760c9027cd008c268e71"
        let privateKey = "7a2a71a2bf0f507f14527504b8672eed3f5a21fd"
        let now = Int64(Date().timeIntervalSince1970).description
        
        let stringToHash = now + privateKey + publicKey
        
        var dict = dict
        
        dict["apikey"] = publicKey
        dict["ts"] = now
        dict["hash"] = stringToHash.md5()
        
        return dict
        
    }
    private func sendRequest(to endpoint : String, with params : [String:Any], callback : @escaping (_ json : [String:Any]?, _ error : Error?)->Void){
        
        let url = baseURL + endpoint
        let params = addDefaultParmas(to: params)
        
        Alamofire.request(url, method: .get, parameters: params).responseJSON { (res) in
            guard let json = res.result.value as? [String:Any] else{
                callback(nil, res.result.error)
                return
            }
            
            guard let code = json["code"] as? Int, code == 200 else{
                let msg = json["message"] as? String ?? "unkown error"
                let err = NSError(domain: "marvel", code: 1, userInfo: [NSLocalizedDescriptionKey:msg])
                callback(nil,err as Error)
                return
            }
            
            let data = json["data"] as? [String:Any] ?? [:]
            callback(data,nil)
            
        }
        
    }

    //MARK: - Public
    
    func getHeros(_ nameStartsWith : String?,_ offset : Int, callback : @escaping (_ arr : [Heroes]?, _ err : Error?) -> Void){
        let endpoint = "characters"
        var params : [String:Any] = ["offset":offset]
            
        if let name = nameStartsWith{
            params["nameStartsWith"] = name
        }
        
        self.sendRequest(to: endpoint, with: params) { (json, error) in
            let results = json?["results"] as? [[String:Any]]
            let arr = results?.flatMap{ Heroes($0)}
            
            callback(arr,error)
        }
    }
    
    func getHeroById(_ characterId : String?, callback : @escaping (_ arr : [Heroes]?, _ err : Error?) -> Void){
        
        var endpoint = "characters/"
        if let id = characterId{
              endpoint += id
        }
        let params : [String:Any] = [:]
        
        
        self.sendRequest(to: endpoint, with: params) { (json, error) in
            let results = json?["results"] as? [[String:Any]]
            let arr = results?.flatMap{ Heroes($0)}
            
            callback(arr,error)
        }
    }
    
    func getHeroComics(_ characterId : String?, callback : @escaping (_ arr : [Comics]?, _ err : Error?) -> Void){
        var endpoint = "characters/"
        let comics = "/comics"
        if let id = characterId{
            endpoint += id + comics
        }
        let params : [String:Any] = [:]
        
        
        self.sendRequest(to: endpoint, with: params) { (json, error) in
            let results = json?["results"] as? [[String:Any]]
            let arr = results?.flatMap{ Comics($0)}
            
            callback(arr,error)
        }
    }
    
    
}
