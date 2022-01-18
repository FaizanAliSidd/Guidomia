//
//  CarCell.swift
//  Guidomia
//
//  Created by William Scott on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

class CarCell: UITableViewCell {
    
    static let identifier = "CarCell"
    //@IBOutlet weak var carName: UILabel!
    //@IBOutlet weak var carPrice: UILabel!
    //@IBOutlet weak var carImageView: UIImageView!
    //@IBOutlet var carRating: UILabel!
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
       // [carName, carPrice, proDetails, conDetails].forEach({$0?.text = ""})
        //carImageView.image = nil
        
        [proDetails, conDetails].forEach({$0?.text = ""})
    }
    
    private func displayData() {
       // carName.text = car?.carModelAndMake()
        //carPrice.text = car?.carDisplayPrice()
        //carImageView.image = car?.carImage()
        //carRating.text = car?.carRating()
        
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
