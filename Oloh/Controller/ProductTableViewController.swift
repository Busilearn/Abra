//
//  ProductTableViewController.swift
//  Oloh
//
//  Created by mickael on 08/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class ProductTableViewCell: UITableViewCell{

    @IBOutlet weak var prodTitle: UILabel!
    @IBOutlet weak var prodImageView: UIImageView!
    @IBOutlet weak var prodDesc: UILabel!
    @IBOutlet weak var productCartQty: UILabel!
}


class ProductTableViewController: UITableViewController {
    // Get the default Realm
    var product: Results<Products>? = try! Realm().objects(Products.self)
    var productCart = ProductCart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.product?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        cell.prodTitle?.text = self.product![indexPath.row].name
        cell.prodDesc?.text = self.product![indexPath.row].short_description
        let prodImageUrl: String? = self.product![indexPath.row].imageUrl
        let url = URL(string: prodImageUrl!)
        
        cell.prodImageView?.kf.setImage(with: url, placeholder:UIImage(named: "AppIcon"))
    
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "singleProductSegue",
            let destination = segue.destination as? SingleProductViewController,
            let Index = self.tableView.indexPathForSelectedRow?.row
        {
            destination.product = self.product![Index]
        }
    }
    
}
