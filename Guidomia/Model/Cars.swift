//
//  Cars.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import UIKit

struct Cars: Codable, Equatable {
    
    enum CodingKeys: String, CodingKey {
        case consList       = "consList"
        case customerPrice  = "customerPrice"
        case make           = "make"
        case marketPrice    = "marketPrice"
        case model          = "model"
        case prosList       = "prosList"
        case rating         = "rating"
    }
    
    var consList: [String]
    var customerPrice: Double
    var make: String
    var marketPrice: Double
    var model: String
    var prosList: [String]
    var rating: Int
    
    /// Show car model and make
    func carModelAndMake() -> String {
        return make + Constants.space + model
    }
    
    /// Display car price in a desired format
    func carDisplayPrice() -> String {
        let intPrice = Int((customerPrice/1000))
        return Constants.priceString + String(intPrice) + Constants.thousand
    }
    
    /// Get car rating
    func carRating() -> String {
        var star = Constants.star
        let spacePlusStar = Constants.space + star
        for _ in 1..<rating {
            star.append(spacePlusStar)
        }
        return star
    }
    
    func carProsHide() -> Bool {
        return prosList.count == 0 ? true: false
    }
    
    func carConsHide() -> Bool {
        return consList.count == 0 ? true: false
    }
    
    /// Get car image
    func carImage() -> UIImage {
        
        switch CarImages(rawValue: make) {
        case .bmw :
            return CarImages.bmw.pngImage
        case .mercedes:
            return CarImages.mercedes.pngImage
        case .rangeRover:
            return CarImages.rangeRover.pngImage
        case .alpine:
            return CarImages.alpine.pngImage
        case .toyota:
            return CarImages.toyota.pngImage
        default:
            return UIImage()
        }
    }
}
