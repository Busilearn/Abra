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
    // Get the default Realm
    let realm = try! Realm()
    var product = try! Realm().objects(Products.self)
    var productsInCart = try! Realm().objects(ProductCart.self)

    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsInCart.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        
        let prodName = productsInCart[indexPath.row].products?.name
        cell.cartTitleView?.text = prodName
        cell.cartDescView?.text = productsInCart[indexPath.row].products?.short_description
        cell.productCartQty?.text = String (productsInCart[indexPath.row].qty)

        let prodImageUrl: String? = productsInCart[indexPath.row].products?.imageUrl
        let url = URL(string: prodImageUrl!)
        cell.cartImageView?.kf.setImage (with: url, placeholder:UIImage(named: "AppIcon"))
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "CartProductSegue",
            let destination = segue.destination as? SingleProductViewController,
            let index = self.tableView.indexPathForSelectedRow?.row
        {
            destination.product = self.productsInCart[index].products
        }
    }
    
    @IBAction func addProductCart(_ sender: UIButton) {
        if let cell = sender.superview?.superview as? CartTableViewCell {
            let indexPath = self.tableView.indexPath(for: cell)
            try! realm.write {
                    var productCart = ProductCart()
                    productCart = productsInCart.filter("id =\(String(describing: product[indexPath!.row].id))").first!
                    productCart.qty += 1
                    realm.add(productCart, update: true)
                    cell.productCartQty.text =  String(productCart.qty)
            }
        }
    }
    
    @IBAction func removeProductCart(_ sender: UIButton) {
        
        if let cell = sender.superview?.superview as? CartTableViewCell {
            let indexPath = self.tableView.indexPath(for: cell)
                var productCart = ProductCart()
                productCart = productsInCart.filter("id =\(String(describing: product[indexPath!.row].id))").first!
                if productCart.qty > 0{
                    try! realm.write {
                        productCart.qty -= 1
                        cell.productCartQty.text = String(productCart.qty)
                    }
                }
        }
    }
}
