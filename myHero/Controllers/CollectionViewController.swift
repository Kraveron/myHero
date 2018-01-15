//
//  CollectionViewController.swift
//  myHero
//
//  Created by Natan Kaspy on 25/10/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit
import Alamofire
import CCBottomRefreshControl
import CoreData

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var search: UISearchBar!
    var name : String?
    var offset : Int = 0
    let popular : [String] = ["1009610", // spiderman
        "1010338", // captain marvel
        "1009351", // hulk
        "1009664", // thor
        "1009368", // iron man
        "1009215", // luke cage
        "1009189", // black widow
        "1009262", // daredevil
        "1009220", // captain america
        "1009718"] // wolverine
    
    
    var collectionArray : [Heroes] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.backgroundColor = UIColor(patternImage: UIImage(named:"bg")!)
       
        
        search.delegate = self
        refresh()
        
        let BRC = UIRefreshControl()
        BRC.triggerVerticalOffset = 100
        BRC.addTarget(self, action: #selector(loadNextPage), for: .valueChanged)
        collectionView.bottomRefreshControl = BRC
        
    }
    
    @objc func loadNextPage(){
        offset += 20
        refresh()
    }
    
    func loadFavorites(){
        self.collectionArray = []
        self.collectionView.reloadData()
        var favArray: [String] = []
        let fetchRequest = NSFetchRequest<Hero>(entityName: "Hero")
        do{
        let searchResults = try DBManager.manager.persistentContainer.viewContext.fetch(fetchRequest)
            for result : Hero in searchResults{
                favArray.append(result.id!)
            }
        }
        catch{
            print(error)
        }
    
        
        
        for id in favArray{
            MarvelManager.manager.getHeroById(id, callback: { (heroes, err) in
                guard let heroes = heroes else{
                    return
                }
                self.collectionArray.append(contentsOf: heroes)
                self.collectionView.reloadData()
            })
        }
        
    }
    
    func loadPopular(){
        self.collectionArray = []
        self.collectionView.reloadData()
        for id in popular{
        MarvelManager.manager.getHeroById(id, callback: { (heroes, err) in
            guard let heroes = heroes else{
                return
            }
            self.collectionArray.append(contentsOf: heroes)
            self.collectionView.reloadData()
        })
        }
    }

    func refresh(){
        MarvelManager.manager.getHeros(name, offset) { (heroes, error) in
            self.collectionView.bottomRefreshControl?.endRefreshing()
            
            guard let heroes = heroes else{
                return
            }
            if self.offset == 0{
            self.collectionArray = heroes
            }
            else{
                self.collectionArray += heroes
            }
            self.collectionView.reloadData()
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CharacterCollectionViewCell
        
        let hero = collectionArray[indexPath.row]
        cell.configure(with: hero)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? HeroPageViewController,
            let indexPath = collectionView.indexPathsForSelectedItems{
            
            nextVC.hero = collectionArray[indexPath.first!.item]
        }
    }
    
    
}

extension CollectionViewController : UISearchBarDelegate{
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        self.name = nil
        offset = 0
        refresh()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        self.name = searchBar.text
        offset = 0
        refresh()
        search.resignFirstResponder()
    }
}
