//
//  SingleProductViewController.swift
//  Oloh
//
//  Created by mickael on 16/11/2017.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher


class SingleProductViewController: UIViewController {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productNumberInCart: UILabel! // TODO
    @IBOutlet weak var productDesc: UITextView!
    @IBOutlet weak var productCartQty: UILabel!
    
    
    // Get the default Realm
    let realm = try! Realm()
    var product: Products?
    var productsInCart = try! Realm().objects(ProductCart.self)
    var productCart = ProductCart()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prodImageUrl: String? = product!.imageUrl
        let url = URL(string: prodImageUrl!)
        productImage?.kf.setImage(with: url, placeholder:UIImage(named: "AppIcon"))
        
        productPrice?.text = product!.price
        productTitle?.text = product!.name
        productDesc?.text = product!.productDescription
        
        if productsInCart.filter("id =\(String(describing: product!.id))").first != nil {
            productCart = productsInCart.filter("id =\(String(describing: product!.id))").first!
            productCartQty.text = String(describing: productCart.qty)
        } else {
            productCartQty.text = "0"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addProductCart(_ sender: UIButton) {
        try! realm.write {
            if productsInCart.filter("id =\(String(describing: product!.id))").first != nil {
                productCart = productsInCart.filter("id =\(String(describing: product!.id))").first!
                productCart.qty += 1
                realm.add(productCart, update: true)
            } else {
                productCart.id = (product?.id)!
                productCart.products = product
                productCart.qty += 1
                realm.add(productCart, update: true)
            }
            productCartQty.text =  String(productCart.qty)
        }
    }

    @IBAction func removeProductCart(_ sender: UIButton) {
            if productsInCart.filter("id =\(String(describing: product!.id))").first != nil {
                productCart = productsInCart.filter("id =\(String(describing: product!.id))").first!
                if productCart.qty > 0{
                try! realm.write {
                    productCart.qty -= 1
                    productCartQty.text = String(productCart.qty)
//                    if productCart.qty == 1 {
//                        realm.delete(productCart)
//                    }
                }
            }
        }
    }
    
}
