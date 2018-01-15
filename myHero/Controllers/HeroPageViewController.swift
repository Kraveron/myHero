//
//  HeroPageViewController.swift
//  myHero
//
//  Created by Natan Kaspy on 30/10/2017.
//  Copyright © 2017 Natan Kaspy. All rights reserved.
//

import UIKit
import Toast
import CoreData

class HeroPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBAction func favorite(_ sender: UIBarButtonItem) {
        
        let h = Hero(context: DBManager.manager.persistentContainer.viewContext)
        let heroId = String(describing: hero?.id ?? 0)
        h.id = heroId
        DBManager.manager.saveContext()
        
        self.view.makeToast("ADDED TO FAVORITES 💪")
        
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var name : String?
    var offset : Int = 0
    var hero : Heroes?
    var tableArry : [Comics] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()	
        navigationItem.title = hero?.name
        textView.text = hero?.desc
        
        
        if let url = hero?.thumbnail{
            imageView.sd_setImage(with: url)
        }
        else {
            imageView.image = nil
            imageView.sd_cancelCurrentImageLoad()
        }
        
        refresh()
        
        // Do any additional setup after loading the view.
    }
    
    func refresh(){
        
        let id = String(describing: hero?.id ?? 0)
        
        MarvelManager.manager.getHeroComics(id) { (comics, error) in
             guard let comics = comics else{
                return
            }
            self.tableArry = comics
            self.tableView.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComicsTableViewCell
        
        let comics = tableArry[indexPath.row]
        cell.configure(with: comics)
        return cell
    }
    
    
    
    

}
