//
//  CheckoutInitController.swift
//  Oloh
//
//  Created by Baptiste Jacob on 11/19/17.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit
import RealmSwift

class CartController: UIViewController {
    @IBOutlet weak var totalCart: UILabel!
    let realm = try! Realm()
    
    var notificationToken: NotificationToken? = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()

        let productsInCart = realm.objects(ProductCart.self)
        var subTotal = 0.0

        for productInCart in productsInCart{
            var total = 0.0
            total = Double(productInCart.products!.price)! * Double(productInCart.qty)
            
            subTotal += total
        }
        print(subTotal)
        
        totalCart.text = String(subTotal)
    
        
        
        let results = realm.objects(ProductCart.self)
        
        // Observe Results Notifications
//        notificationToken = results.observe { [weak self] (changes: RealmCollectionChange) in
//            guard let tableView = CartTableViewController.self else { return }
//            switch changes {
//            case .initial:
//                // Results are now populated and can be accessed without blocking the UI
//                tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//                // Query results have changed, so apply them to the UITableView
//                tableView.beginUpdates()
//                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0) }),
//                                     with: .automatic)
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}),
//                                     with: .automatic)
//                tableView.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0) }),
//                                     with: .automatic)
//                tableView.endUpdates()
//            case .error(let error):
//                // An error occurred while opening the Realm file on the background worker thread
//                fatalError("\(error)")
//            }
//        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CheckoutButton(_ sender: UIButton) {
        let checkoutViewController = CheckoutViewController()
        self.navigationController?.pushViewController(checkoutViewController, animated: true)
    }
    
}

