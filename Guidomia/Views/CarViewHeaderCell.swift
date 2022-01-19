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
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var carPrice: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet var carRating: UILabel!
    
    static let headerID: String = "CarViewHeaderCell"
    static let nibName = "CarViewHeaderCell"
    
    public var car: Cars? {
        didSet { self.displayData() }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func prepareForReuse() {
        
        super.prepareForReuse()
        [carName, carPrice].forEach({$0?.text = ""})
        carImageView.image = nil
    }
    private func displayData() {
        carName.text = car?.carModelAndMake()
        carPrice.text = car?.carDisplayPrice()
        carImageView.image = car?.carImage()
        carRating.text = car?.carRating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
