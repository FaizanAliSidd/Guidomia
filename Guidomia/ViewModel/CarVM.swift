//
//  CarVM.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import Foundation

protocol CarVMDelegate {
    func updateCarModel()
}

final class CarVM {
    
    public var datasource: [Cars]?
    private var selectedRow = IndexPath(row: 0, section: 0)
    var isExpandStatus = [Bool]()
    var CarVMDelegate: CarVMDelegate? {
        didSet {
            //datasource?.enumerated().forEach({ self.isExpandStatus.append($0.0 == 0) })
            //self.CarVMDelegate?.updateCarModel()
        }
    }
    
    init() {
        
        datasource = loadJson(filename: Constants.carList)
        datasource?.enumerated().forEach({ self.isExpandStatus.append($0.0 == 0) })
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
    
    func setExpandCollapseStatus(indexPath: IndexPath){
        
        if self.selectedRow == indexPath { return }
        
        self.selectedRow = indexPath
        self.isExpandStatus.enumerated().forEach({ self.isExpandStatus[$0.0] = false })
        self.isExpandStatus[indexPath.row] = true
        
        print(isExpandStatus)
    }
}
