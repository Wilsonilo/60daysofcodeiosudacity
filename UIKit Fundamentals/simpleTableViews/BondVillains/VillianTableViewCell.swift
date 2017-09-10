//
//  VillianTableViewCell.swift
//  BondVillains
//
//  Created by Wilson Muñoz on 9/10/17.
//  Copyright © 2017 Udacity. All rights reserved.
//

import UIKit

class VillianTableViewCell: UITableViewCell {

    @IBOutlet var villianImae: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var subtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
