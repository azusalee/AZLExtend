//
//  AZLRawPointerTests.swift
//  AZLExtendExampleSwiftTests
//
//  Created by lizihong on 2022/6/10.
//  Copyright © 2022 azusalee. All rights reserved.
//

import XCTest
import AZLExtendSwift

class AZLRawPointerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_loadAsRGBA8888Color() throws {
        
        let p = UnsafeMutableRawPointer.allocate(byteCount: 32, alignment: 8)
        p.storeBytes(of: 255, toByteOffset: 0, as: UInt8.self)
        p.storeBytes(of: 255, toByteOffset: 1, as: UInt8.self)
        p.storeBytes(of: 255, toByteOffset: 2, as: UInt8.self)
        p.storeBytes(of: 255, toByteOffset: 3, as: UInt8.self)
        let color = p.azl_loadAsRGBA8888Color(offset: 0)
        
        XCTAssertEqual(color.azl_argbValue(), 0xFFFFFFFF)
    }
    
    func test_loadAsRGBA8888() throws {
        let p = UnsafeMutableRawPointer.allocate(byteCount: 32, alignment: 8)
        p.storeBytes(of: 50, toByteOffset: 0, as: UInt8.self)
        p.storeBytes(of: 100, toByteOffset: 1, as: UInt8.self)
        p.storeBytes(of: 150, toByteOffset: 2, as: UInt8.self)
        p.storeBytes(of: 200, toByteOffset: 3, as: UInt8.self)
        let colorData = p.azl_loadAsRGBA8888(offset: 0)
        
        XCTAssertEqual(colorData.r, 50)
        XCTAssertEqual(colorData.g, 100)
        XCTAssertEqual(colorData.b, 150)
        XCTAssertEqual(colorData.a, 200)
    }
    
    func test_loadAsARGB8888() throws {
        let p = UnsafeMutableRawPointer.allocate(byteCount: 32, alignment: 8)
        p.storeBytes(of: 50, toByteOffset: 0, as: UInt8.self)
        p.storeBytes(of: 100, toByteOffset: 1, as: UInt8.self)
        p.storeBytes(of: 150, toByteOffset: 2, as: UInt8.self)
        p.storeBytes(of: 200, toByteOffset: 3, as: UInt8.self)
        let colorData = p.azl_loadAsARGB8888(offset: 0)
        
        XCTAssertEqual(colorData.r, 100)
        XCTAssertEqual(colorData.g, 150)
        XCTAssertEqual(colorData.b, 200)
        XCTAssertEqual(colorData.a, 50)
    }

}
