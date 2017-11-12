//
//  CartTableViewController.swift
//  Oloh
//
//  Created by mickael on 11/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell{
    @IBOutlet weak var cartTitleView: UILabel!
    @IBOutlet weak var cartDescView: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    
}


class CartTableViewController: UITableViewController {
    
    var prod = ["Prod1", "Prod2", "Prod3", "Prod4", "Prod5", "Prod6"]
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prod.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        
        let prodName = prod[indexPath.row]
        cell.cartTitleView?.text = prodName
        cell.cartDescView?.text = "Delicious!"
        cell.cartImageView?.image = UIImage(named: "AppIcon")
        
        return cell
    }
    
}
