//
//  CategoryViewController.swift
//  Oloh
//
//  Created by mickael on 08/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper


class CategoryTableViewCell: UITableViewCell{
    
    @IBOutlet weak var catTitle: UILabel!
    @IBOutlet weak var catDesc: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
}

class CategoryTableViewController: UITableViewController {
    let realm = try! Realm()
    var cat = ["Cat1", "Cat2", "Cat3"]
    
    var category: Results<Category>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.category = self.realm.objects(Category.self)
        print(self.category?.count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cat.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! CategoryTableViewCell
                
        let catName = cat[indexPath.row]
        cell.catTitle?.text = catName
        cell.catDesc?.text = "Great!"
        cell.catImageView?.image = UIImage(named: "AppIcon")
        
        return cell
    }
}
