//
//  CarVM.swift
//  Guidomia
//
//  Created by William Scott on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import Foundation

final class CarVM {
    public var datasource: [Cars]?

    init() {
        datasource = loadJson(filename: Constants.carList)
    }
    
    func loadJson(filename fileName: String) -> [Cars]? {
        if let jsonUrl = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: jsonUrl)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode([Cars].self, from: data)
                return jsonData
            } catch {
                print("Error:\(error)")
            }
        }
        return nil
    }
}
