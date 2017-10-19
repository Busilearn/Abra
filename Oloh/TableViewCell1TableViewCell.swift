//
//  TableViewCell1TableViewCell.swift
//  Oloh
//
//  Created by mickael on 17/10/2017.
//  Copyright © 2017 apps-technologies. All rights reserved.
//

import UIKit

class TableViewCell1TableViewCell: UITableViewCell {

    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var categoryTitle: UILabel!
    @IBOutlet var categoryDescription: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
