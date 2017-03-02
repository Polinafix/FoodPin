//
//  RestaurantDetailTableViewCell.swift
//  FoodPin
//
//  Created by Polina Fiksson on 28/02/2017.
//  Copyright © 2017 PolinaFiksson. All rights reserved.
//

import UIKit

class RestaurantDetailTableViewCell: UITableViewCell {
    
    @IBOutlet var fieldLabel:UILabel!
    @IBOutlet var valueLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
