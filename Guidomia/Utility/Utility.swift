//
//  Utility.swift
//  Guidomia
//
//  Created by Faizan Ali on 21/01/22.
//  Copyright © 2022 Faizan. All rights reserved.

import Foundation
import UIKit

class Utility {
    
    static let shared = Utility()
    
    /// Used to load json data from file
    /// - Parameters :
    /// - resource: File name of json
    /// - Returns : Data Object
    func loadJson<T: Decodable>(resource: String) -> [T] {
        
        guard let jsonUrl = Bundle.main.url(forResource: resource, withExtension: Constants.jsonExtension) else { return [] }
        do {
            let data = try Data(contentsOf: jsonUrl)
            let result = try JSONDecoder().decode([T].self, from: data)
            return result
        } catch let error {
            print(error.localizedDescription)
        }
        
        return []
    }
    
}
