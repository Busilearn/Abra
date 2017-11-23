//
//  CartTableViewController.swift
//  Oloh
//
//  Created by mickael on 11/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class CartTableViewCell: UITableViewCell{
    @IBOutlet weak var cartTitleView: UILabel!
    @IBOutlet weak var cartDescView: UILabel!
    @IBOutlet weak var cartImageView: UIImageView!
    @IBOutlet weak var productCartQty: UILabel!
    
}


class CartTableViewController: UITableViewController {
    let productCart = try! Realm().objects(ProductCart.self)
    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productCart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        
        let prodName = productCart[indexPath.row].products?.name
        cell.cartTitleView?.text = prodName
        cell.cartDescView?.text = productCart[indexPath.row].products?.short_description
        
        cell.productCartQty?.text = String (productCart[indexPath.row].qty)

        
        let prodImageUrl: String? = productCart[indexPath.row].products?.imageUrl
        let url = URL(string: prodImageUrl!)
        cell.cartImageView?.kf.setImage (with: url, placeholder:UIImage(named: "AppIcon"))
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "CartProductSegue",
            let destination = segue.destination as? SingleProductViewController,
            let index = self.tableView.indexPathForSelectedRow?.row
        {
            destination.product = self.productCart[index].products
        }
    }

    
}
