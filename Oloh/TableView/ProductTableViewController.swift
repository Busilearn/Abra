//
//  ProductTableViewController.swift
//  Oloh
//
//  Created by mickael on 08/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit


class ProductTableViewCell: UITableViewCell{
    
    @IBOutlet weak var prodTitle: UITextField!
    @IBOutlet weak var prodDesc: UITextField!
    @IBOutlet weak var prodImageView: UIImageView!
}



class ProductTableViewController: UITableViewController {
    
    var prod = ["Prod1", "Prod2", "Prod3", "Prod4", "Prod5", "Prod6"]
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prod.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        let prodName = prod[indexPath.row]
        cell.prodTitle?.text = prodName
        cell.prodDesc?.text = "Delicious!"
        cell.prodImageView?.image = UIImage(named: "AppIcon")
        
        return cell
    }
    
}
