//
//  CategoryViewController.swift
//  Oloh
//
//  Created by mickael on 08/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit


class CategoryTableViewCell: UITableViewCell{
    
    @IBOutlet weak var catTitle: UITextField!
    @IBOutlet weak var catDesc: UITextField!
    @IBOutlet weak var catImageView: UIImageView!
}



class CategoryTableViewController: UITableViewController {
    
    var cat = ["Cat1", "Cat2", "Cat3"]
    
    // MARK: - UITableViewDataSource
    
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
        cell.catDesc?.text = "Delicious!"
        cell.catImageView?.image = UIImage(named: "AppIcon")
        
        return cell
    }
    
}
