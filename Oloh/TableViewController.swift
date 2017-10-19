//
//  ViewController.swift
//  Oloh
//
//  Created by mickael on 17/10/2017.
//  Copyright © 2017 apps-technologies. All rights reserved.
//

import UIKit

struct cellData {
    let cell : Int!
    let text : String!
    let Image : UIImage!
}

class TableViewController: UITableViewController {

    var arrayOfCellData = [cellData] ()
        
    
    
    override func viewDidLoad() {
        arrayOfCellData = [cellData(cell:1,text:""image:#imageLiteral(resourceName: <#T##String#>)),
                           cellData(cell:1,text:""image:#imageLiteral(resourceName: <#T##String#>)),
                           cellData(cell:1,text:""image:#imageLiteral(resourceName: <#T##String#>))]
        
    }
  
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayOfCellData[indexPath.row],cell == 1 {
            
        }else if arrayOfCellData[indexPath.row],cell == 2{
            
            
        }else{
            
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        <#code#>
    }

}

