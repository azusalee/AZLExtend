//
//  AZLCodableTests.swift
//  AZLExtendExampleSwiftTests
//
//  Created by lizihong on 2022/6/15.
//  Copyright © 2022 azusalee. All rights reserved.
//

import XCTest
@testable import AZLExtendSwift

class MyCodableObject: Codable {
    @Default<Bool.False> var flag: Bool
    @Default<Double.Zero> var num_d: Double
    @Default<Int.Zero> var num_i: Int
    @Default<String.Empty> var name: String
    
}

class AZLCodableTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_decode1() throws {
        
        let dict: [String: Any] = [
            "flag": true,
            "num_d": 1.2,
            "num_i": 1,
            "name": "tom"
        ]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
        
        let obj = try? JSONDecoder().decode(MyCodableObject.self, from: data)
        
        XCTAssertEqual(obj?.flag, true)
        XCTAssertEqual(obj?.num_d, 1.2)
        XCTAssertEqual(obj?.num_i, 1)
        XCTAssertEqual(obj?.name, "tom")
        
    }
    
    func test_decode2() throws {
        let dict2: [String: Any] = [
            "flag": "1",
            "num_d": "1.2",
            "num_i": "1",
            "name": 123
        ]
        let data2 = try! JSONSerialization.data(withJSONObject: dict2, options: [])
        
        let obj2 = try? JSONDecoder().decode(MyCodableObject.self, from: data2)
        
        XCTAssertEqual(obj2?.flag, true)
        XCTAssertEqual(obj2?.num_d, 1.2)
        XCTAssertEqual(obj2?.num_i, 1)
        XCTAssertEqual(obj2?.name, "123")
    }
    
    func test_decode3() throws {
        
        let dict3: [String: Any] = [:]
        let data3 = try! JSONSerialization.data(withJSONObject: dict3, options: [])
        
        let obj3 = try? JSONDecoder().decode(MyCodableObject.self, from: data3)
        
        XCTAssertEqual(obj3?.flag, false)
        XCTAssertEqual(obj3?.num_d, 0)
        XCTAssertEqual(obj3?.num_i, 0)
        XCTAssertEqual(obj3?.name, "")
    }
    
    func test_decode4() throws {
        let dict2: [String: Any] = [
            "flag": "0",
            "num_d": "1.2",
            "num_i": "1",
            "name": 123
        ]
        let data2 = try! JSONSerialization.data(withJSONObject: dict2, options: [])
        
        let obj2 = try? JSONDecoder().decode(MyCodableObject.self, from: data2)
        
        XCTAssertEqual(obj2?.flag, false)
        XCTAssertEqual(obj2?.num_d, 1.2)
        XCTAssertEqual(obj2?.num_i, 1)
        XCTAssertEqual(obj2?.name, "123")
    }
    
    func test_decode5() throws {
        let dict2: [String: Any] = [
            "flag": "true",
            "num_d": "1.2",
            "num_i": "1",
            "name": 123
        ]
        let data2 = try! JSONSerialization.data(withJSONObject: dict2, options: [])
        
        let obj2 = try? JSONDecoder().decode(MyCodableObject.self, from: data2)
        
        XCTAssertEqual(obj2?.flag, true)
        XCTAssertEqual(obj2?.num_d, 1.2)
        XCTAssertEqual(obj2?.num_i, 1)
        XCTAssertEqual(obj2?.name, "123")
    }
    
    func test_encode() {
        
        let dict: [String: Any] = [
            "flag": true,
            "num_d": 1.2,
            "num_i": 1,
            "name": "tom"
        ]
        let data = try! JSONSerialization.data(withJSONObject: dict, options: [])
        
        let obj = try? JSONDecoder().decode(MyCodableObject.self, from: data)
        
        XCTAssertEqual(obj?.flag, true)
        XCTAssertEqual(obj?.num_d, 1.2)
        XCTAssertEqual(obj?.num_i, 1)
        XCTAssertEqual(obj?.name, "tom")
        
        let jsonData = try? JSONEncoder().encode(obj!)
        let jsonDict = try? JSONSerialization.jsonObject(with: jsonData!, options: []) as? [String: Any]
        
        XCTAssertEqual(jsonDict?["flag"] as? Bool, true)
        XCTAssertEqual(jsonDict?["num_d"] as? Double, 1.2)
        XCTAssertEqual(jsonDict?["num_i"] as? Int, 1)
        XCTAssertEqual(jsonDict?["name"] as? String, "tom")
        
    }
}
