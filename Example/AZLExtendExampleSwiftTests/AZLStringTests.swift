//
//  AZLStringTests.swift
//  AZLExtendExampleSwiftTests
//
//  Created by lizihong on 2022/6/9.
//  Copyright © 2022 azusalee. All rights reserved.
//

import XCTest
import AZLExtendSwift

class AZLStringTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_md5String() {
        
        XCTAssertEqual("abc".azl_md5String(), "900150983cd24fb0d6963f7d28e17f72")
        
    }
    
    func test_subString() {
        XCTAssertEqual("abc".azl_subString(location: 0, length: 1), "a")
        XCTAssertEqual("abc".azl_subString(location: 1, length: 2), "bc")
        
        XCTAssertEqual("abc".azl_subString(location: 1, length: 3), "bc")
        
        XCTAssertEqual("abc".azl_subString(location: 4, length: 3), "")
    }
    
    func test_ranges() {
        XCTAssertEqual("abc".azl_ranges(subString: "d").count, 0)
        
        let string = "abca"
        let ranges = string.azl_ranges(subString: "a")
        guard ranges.count == 2 else {
            XCTAssert(false, "数量不对 \(ranges.count)")
            return
        }
        
        XCTAssert(String(string[ranges[0].lowerBound..<ranges[0].upperBound]) == "a")
        
        XCTAssertEqual(ranges[0].lowerBound, string.startIndex)
        XCTAssertEqual(ranges[0].upperBound, string.index(string.startIndex, offsetBy: 1))
        
        XCTAssertEqual(ranges[1].lowerBound, string.index(string.startIndex, offsetBy: 3))
        XCTAssertEqual(ranges[1].upperBound, string.index(string.startIndex, offsetBy: 4))
    }
    
    func test_utf8ToBase64() {
        XCTAssertEqual("abc".azl_utf8ToBase64(), "YWJj")
    }
    
    func test_base64ToUtf8() {
        XCTAssertEqual("YWJj".azl_base64ToUtf8(), "abc")
    }
    
    func test_forceDecodeUtf8() throws {
        let data = "abc哈".data(using: .utf8)!
        
        XCTAssertEqual(String.azl_forceDecodeUtf8(data: data), "abc哈")
        
        let subData = data[data.startIndex..<data.endIndex-1]
        
        XCTAssertEqual(String.azl_forceDecodeUtf8(data: subData), "abcå")
    }
}
