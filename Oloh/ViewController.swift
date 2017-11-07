//
//  ViewController.swift
//  Oloh
//
//  Created by Baptiste Jacob on 10/24/17.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let oac = OlohApiClient()
        oac.syncAllCategories()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

