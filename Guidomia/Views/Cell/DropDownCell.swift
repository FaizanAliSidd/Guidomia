//
//  DropDownCell.swift
//  Guidomia
//
//  Created by Faizan Ali on 20/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {

    static let identifier = "dropDownCell"
    static let nibName = "DropDownCell"
    static let dropDownIdentifier = "FilterDropDown"
    static let dropDownRowHeight = 44.0
    @IBOutlet weak var dropDownTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
