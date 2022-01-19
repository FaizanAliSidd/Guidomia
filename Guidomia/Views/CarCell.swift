//
//  CarCell.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {
    
    static let identifier = "CarCell"
    
    @IBOutlet var proLabel: UILabel!
    @IBOutlet var conLabel: UILabel!
    @IBOutlet var proDetails: UILabel!
    @IBOutlet var conDetails: UILabel!
    
    public var car: Cars? {
        
        didSet { self.displayData() }
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        [proDetails, conDetails].forEach({$0?.text = ""})
    }
    
    private func displayData() {
      
        proLabel.isHidden = car?.carProsHide() ?? false
        conLabel.isHidden = car?.carConsHide() ?? false
        
        if !proLabel.isHidden {
            if let proArray = car?.prosList.filter({ $0.isEmpty == false }) {
                proDetails.attributedText = NSAttributedString().displayBulletedText(for: proArray)
            }
        }
        if !conLabel.isHidden {
            if let conArray = car?.consList.filter({ $0.isEmpty == false }) {
                conDetails.attributedText = NSAttributedString().displayBulletedText(for: conArray)
            }
        }
    }

}
