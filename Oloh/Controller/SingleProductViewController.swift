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
    

    // Get the default Realm
    let realm = try! Realm()
    var product: Products?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let prodImageUrl: String? = product!.imageUrl
        let url = URL(string: prodImageUrl!)
        productImage?.kf.setImage(with: url, placeholder:UIImage(named: "AppIcon"))
        
        productPrice?.text = product!.price
        productTitle?.text = product!.name
        productDesc?.text = product!.productDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addProductCart(_ sender: UIButton) {
        
    }

    @IBAction func removeProductCart(_ sender: UIButton) {
        
    }
    
}
