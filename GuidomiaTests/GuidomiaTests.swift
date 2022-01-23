//
//  GuidomiaTests.swift
//  GuidomiaTests
//
//  Created by Faizan Ali on 18/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import XCTest
@testable import Guidomia

class GuidomiaTests: XCTestCase {
    
    var carViewModel: CarViewModel!
    var carVC: CarViewController!
    var carArray: [Cars]!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        carVC = storyboard.instantiateViewController(withIdentifier: Constants.carVCIdentifier) as? CarViewController
        carVC.loadViewIfNeeded()
        carViewModel = CarViewModel()
        carArray = carViewModel.datasource
        
        if carArray == nil {
            XCTFail("Data is missing in the array. Check the JSON.")
        }
    }
    
    func testMakeData() {
        
        let carMake = carArray?[0].make
        XCTAssertNotNil(carMake)
        XCTAssertTrue(carMake == "Land Rover")
        XCTAssertFalse(carMake == "Honda")
    }
    
    func testCarModel() {
        
        let carModel = carArray?[1].model
        XCTAssertNotNil(carModel)
        XCTAssertTrue(carModel == "Roadster")
        XCTAssertFalse(carModel == "Accord")
    }
    
    func testCustomerPrice() {
        
        let carCustomerPrice = carArray?[0].customerPrice
        XCTAssertNotNil(carCustomerPrice)
        XCTAssertTrue(carCustomerPrice == 120000.0)
    }
        
    func testMarketPrice() {
        
        let carMarketPrice = carArray?[0].marketPrice
        XCTAssertNotNil(carMarketPrice)
        XCTAssertTrue(carMarketPrice == 125000.0)
    }
    
    func testRating() {
        let carRating = carArray?[0].rating
        XCTAssertNotNil(carRating)
        XCTAssertTrue(carRating == 3)
        XCTAssertFalse(carRating == 1)
    }
    
    func testCarImages() {
        
        let landRoverCarImage = carArray?[0].carImage()
        XCTAssertNotNil(landRoverCarImage)
        
        let mercedesCarImage = carArray?[3].carImage()
        XCTAssertNotNil(mercedesCarImage)
        
        let expectedLandRoverImage = UIImage(named: "RangeRover")
        let incorrectLandRoverImage = UIImage(named: "Range_Rover")
        let expectedMercedesImage = UIImage(named: "Mercedes")
        let incorrectMercedesImage = UIImage(named: "Mercedez")
        
        XCTAssert(landRoverCarImage == expectedLandRoverImage)
        XCTAssertFalse(landRoverCarImage == incorrectLandRoverImage)
        XCTAssert(mercedesCarImage == expectedMercedesImage)
        XCTAssertFalse(mercedesCarImage == incorrectMercedesImage)
    }
    
    func testConsList() {
        
        let carConsList = carArray?[0].consList
        XCTAssertNotNil(carConsList)
        XCTAssertTrue(carConsList == ["Bad direction"])
        XCTAssertFalse(carConsList == ["Steering issue at high speed"])
    }
    
    func testProsList() {
        
        let carProsList = carArray?[0].prosList
        XCTAssertNotNil(carProsList)
        XCTAssertTrue(carProsList == ["You can go everywhere", "Good sound system"])
        XCTAssertFalse(carProsList == ["Cheap maintenance"])
        
    }
    
    func testCarModelAndMake() {
        
        let carModel = carArray[0].model
        let carMake = carArray[0].make
        let expectedCarModekAndMake = carMake + Constants.space + carModel
        let invalidCarModekAndMake = carMake + "_" + carModel
        let actualCarModelAndMake = carArray[0].carModelAndMake()
        
        XCTAssertEqual(expectedCarModekAndMake, actualCarModelAndMake)
        XCTAssertNotEqual(invalidCarModekAndMake, actualCarModelAndMake)
    }
    
    func testGetFrame() {
        
        let mainView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        let subView =  UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        mainView.addSubview(subView)
        
        let expectedResult = CGRect(x: 0, y: 0, width: 200, height: 50)
        let actualdResult = mainView.getConvertedFrame(fromSubview: subView)
        
        XCTAssertNotEqual(expectedResult, actualdResult)
    }
    
    func testDropDownSelection() {
        
        let dropDown = MakeDropDown()
        dropDown.makeDropDownIdentifier = Constants.makeDropDownIdentifier
        let indexPath = IndexPath(row: 0, section: 0)
        carVC.selectItemInDropDown(indexPos: indexPath.row, makeDropDownIdentifier: Constants.makeDropDownIdentifier)
        
        XCTAssertEqual(carVC.makeTxtField.text!, "Land Rover")
    }
    
    
}
