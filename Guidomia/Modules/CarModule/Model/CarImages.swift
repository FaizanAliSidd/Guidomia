//
//  CarImages.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.

import UIKit

/// Model used for resolving car images
public enum CarImages: String {
    
    case bmw        = "BMW"
    case mercedes   = "Mercedes Benz"
    case alpine     = "Alpine"
    case rangeRover = "Land Rover"
    case toyota     = "Toyota"

    public var image: UIImage {
        
        var imageName: String
        switch self {
        case .mercedes:
            imageName = "Mercedes"
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
