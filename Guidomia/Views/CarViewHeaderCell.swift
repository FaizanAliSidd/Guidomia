//
//  CarViewHeaderCell.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

class CarViewHeaderCell: UITableViewCell {

    static let identifier = "CarHeaderCell"
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
    static let headerID: String = "CarViewHeaderCell"
    static let nibName = "CarViewHeaderCell"
    
    public var car: Cars? {
        didSet { self.displayHeaderData() }
    }
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        
        super.prepareForReuse()
        [carName, carPrice, proLabel, proDetails, conLabel, conDetails].forEach({$0?.text = ""})
        carImageView.image = nil
    }
    private func displayHeaderData() {
        carName.text = car?.carModelAndMake()
        carPrice.text = car?.carDisplayPrice()
        carImageView.image = car?.carImage()
        carRating.text = car?.carRating()
        [proLabel, proDetails, conLabel, conDetails].forEach({$0?.text = ""})
        
    }
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
    private func hideProsConsDataData() {
        
        [proLabel, proDetails, conLabel, conDetails].forEach({$0?.text = ""})
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
