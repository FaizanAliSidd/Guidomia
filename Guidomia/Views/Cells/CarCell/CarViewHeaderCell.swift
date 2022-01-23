//
//  CarViewHeaderCell.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

class CarViewHeaderCell: UITableViewCell {

    @IBOutlet weak var cellContainerView: UIView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet var carRating: UILabel!
    @IBOutlet var proLabel: UILabel!
    @IBOutlet var conLabel: UILabel!
    @IBOutlet var proDetails: UILabel!
    @IBOutlet var conDetails: UILabel!
    @IBOutlet weak var separatorLabel: UILabel!
    @IBOutlet weak var prosConsStackView: UIStackView!
    
    
    public var car: Cars? {
        didSet { self.displayHeaderData() }
    }
    
    /// Bool value to check if expanded or not
    public var isExpanded: Bool? {
        didSet {
            if self.isExpanded!{
                self.displayProsConsDataData()
            }
            else{
                self.hideProsConsDataData()
            }
        }
    }
    
    /// Method to prepare cell contents for reuse
    override func prepareForReuse() {
        
        super.prepareForReuse()
        [carName, carPrice, proLabel, proDetails, conLabel, conDetails].forEach({$0?.text = Constants.empty})
        carImageView.image = nil
    }
    
    /// Display car details except pros and cons
    private func displayHeaderData() {
        
        carName.text = car?.carModelAndMake()
        carPrice.text = car?.carDisplayPrice()
        carImageView.image = car?.carImage()
        carRating.text = car?.carRating()
        [proLabel, proDetails, conLabel, conDetails].forEach({$0?.text = Constants.empty})
    }
    
    /// Display pros and cons data
    private func displayProsConsDataData() {
        
        proLabel.isHidden = car?.carProsHide() ?? false
        conLabel.isHidden = car?.carConsHide() ?? false
        
        if !proLabel.isHidden {
            if let proArray = car?.prosList.filter({ $0.isEmpty == false }) {
                proLabel.text = Constants.prosString
                proDetails.attributedText = NSAttributedString().displayBulletedText(for: proArray)
            }
        }
        if !conLabel.isHidden {
            if let conArray = car?.consList.filter({ $0.isEmpty == false }) {
                conLabel.text = Constants.consString
                conDetails.attributedText = NSAttributedString().displayBulletedText(for: conArray)
            }
        }
    }
    
    /// Hide pros and cons data
    private func hideProsConsDataData() {
        
        [proLabel, proDetails, conLabel, conDetails].forEach({$0?.text = Constants.empty})
    }
}
