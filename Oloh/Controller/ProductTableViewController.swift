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
}


class ProductTableViewController: UITableViewController {
    // Get the default Realm
    let realm = try! Realm()
    var prod = ["Prod1", "Prod2", "Prod3", "Prod4", "Prod5", "Prod6"]
    
    // MARK: - UITableViewDataSource
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(realm.objects(Product.self).count)
        
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return prod.count
        return realm.objects(Product.self).count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let productRealm  = realm.objects(Product.self)
        let prodImageUrl = "https://oloh.fr/wp-content/uploads/2017/11/baron-de-lestac.jpg"
        let ph = UIImage(named: "AppIcon")
        let url = ImageResource(downloadURL: URL(string: prodImageUrl)!, cacheKey: prodImageUrl)
//            URL(string: "https://oloh.fr/wp-content/uploads/2017/11/baron-de-lestac.jpg")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductTableViewCell
        
        let prodName = productRealm[indexPath.row].name!
        cell.prodTitle?.text = prodName
        cell.prodDesc?.text = productRealm[indexPath.row].short_description
        cell.prodImageView?.kf.setImage(with: url, placeholder:ph)
        
        return cell
    }
    
}
