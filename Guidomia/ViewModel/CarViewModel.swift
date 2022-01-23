//
//  CarViewModel.swift
//  Guidomia
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import Foundation

final class CarViewModel {
    
    public var datasource: [Cars] = [Cars]()
    public var fileteredArr = [Cars]()
    var makeArr = [String]()
    var modelArr = [String]()
    private var selectedRow = IndexPath(row: 0, section: 0)
    var isExpandStatus = [Bool]()
    
    init() {
        
        datasource = Utility.shared.loadJson(resource: Constants.carList)
        datasource.enumerated().forEach({ self.isExpandStatus.append($0.0 == 0) })
        self.fileteredArr = self.datasource
        self.makeArr = self.fileteredArr.map({$0.make})
        self.modelArr = self.fileteredArr.map({$0.model})
    }
    
    /// Set expand collapse status with indexpath
    func setExpandCollapseStatus(indexPath: IndexPath){
        
        if self.selectedRow == indexPath { return }
        self.selectedRow = indexPath
        self.isExpandStatus.enumerated().forEach({ self.isExpandStatus[$0.0] = false })
        self.isExpandStatus[indexPath.row] = true
    }
}
