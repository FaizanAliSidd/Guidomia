//
//  JSONTests.swift
//  GuidomiaTests
//
//  Created by Faizan Ali on 23/01/22.
//  Copyright © 2022 Faizan. All rights reserved.
//

import XCTest
@testable import Guidomia

class JSONTests: XCTestCase {
    
    enum TestErrors: Error {
        case badFileName
    }
    
    func decode<T: Decodable>(_ type: T.Type, from filename: String) throws -> T {
        
        guard let json = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw TestErrors.badFileName
        }
        
        let jsonData = try Data(contentsOf: json)
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: jsonData)
        return result
    }
    
    func testFileName() {
        
        let expected = "car_list"
        let fileName = Constants.carList
        XCTAssertTrue(expected == fileName)
    }
    
    func testValidJSON() throws {
        _ = try? decode([Cars].self, from: "car_list.json")
    }
    
    func testInvalidJSON() {
        
        let invalid = try? decode([Cars].self, from: "invalid_car_list.json")
        XCTAssertNil(invalid, "The json is invalid, Data should be nil")
    }
    
    func testIncorrectFile() {
        
        let incorrect = try? decode([Cars].self, from: "car_list.swift")
        XCTAssertNil(incorrect, "The file is incorrect, Data should be nil")
    }
    
    
    
}
