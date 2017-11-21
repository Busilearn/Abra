//
//  CheckoutInitController.swift
//  Oloh
//
//  Created by Baptiste Jacob on 11/19/17.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit

class FooterController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let checkoutViewController = CheckoutViewController()
//        self.present(checkoutViewController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(checkoutViewController, animated: true)
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

