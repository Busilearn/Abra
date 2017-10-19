//
//  TableViewCell2.swift
//  Oloh
//
//  Created by mickael on 17/10/2017.
//  Copyright © 2017 apps-technologies. All rights reserved.
//

import UIKit

class TableViewCell2: UITableViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var productName: UILabel!
    @IBOutlet var productDescription: UILabel!
    @IBOutlet var productPrice: UILabel!
    @IBOutlet var productQuantity: UILabel!
    @IBOutlet var productCardAddRemove: UIStepper!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
