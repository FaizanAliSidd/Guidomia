//
//  CarImages.swift
//  Guidomia
//
//  Created by William Scott on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

public enum CarImages: String {
    case bmw        = "BMW"
    case mercedes   = "Mercedes Benz"
    case alpine     = "Alpine"
    case rangeRover = "Land Rover"
    case toyota     = "Toyota"

    public var pngImage: UIImage {
        
        var imageName: String!
        
        switch self {
        case .mercedes:
            imageName = "Mercedez"
        case .bmw:
            imageName = "BMW"
        case .toyota:
            imageName = "Tacoma"
        case .rangeRover:
            imageName = "RangeRover"
        case .alpine:
            imageName = "Alpine"
        }
        return UIImage(named: imageName) ?? UIImage()
    }
}
