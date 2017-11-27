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
import Kingfisher


class CategoryTableViewCell: UITableViewCell{
    
    @IBOutlet weak var catTitle: UILabel!
    @IBOutlet weak var catDesc: UILabel!
    @IBOutlet weak var catImageView: UIImageView!
}

class CategoryTableViewController: UITableViewController {
    let category = try! Realm().objects(Category.self)
   

     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()


    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as! CategoryTableViewCell
        cell.catTitle?.text = category[indexPath.row].categoryName
        cell.catDesc?.text = category[indexPath.row].categoryDescription
        let prodImageUrl: String? = category[indexPath.row].image
        let url = URL(string: prodImageUrl!)
        cell.catImageView?.kf.setImage(with: url, placeholder:UIImage(named: "AppIcon"))
        
        return cell
    }
    
}


