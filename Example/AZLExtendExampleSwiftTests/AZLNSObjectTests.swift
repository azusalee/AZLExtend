//
//  AZLNSObjectTests.swift
//  AZLExtendExampleSwiftTests
//
//  Created by lizihong on 2022/6/10.
//  Copyright © 2022 azusalee. All rights reserved.
//

import XCTest
import AZLExtendSwift
@testable import AZLExtendExampleSwift

class AZLNSObjectTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_swizzleInstanceFunc() throws {
        MyTestObject.azl_swizzleInstanceFunc(oriSel: #selector(MyTestObject.myfunc), swizzleSel: #selector(MyTestObject.szl_myfunc))
        
        let obj = MyTestObject()
        obj.myfunc()
        XCTAssertEqual(obj.lastName, "szl_myfunc")
        obj.szl_myfunc()
        XCTAssertEqual(obj.lastName, "myfunc")
        
        // 交换没实现的实例方法
        MyTestObject2.azl_swizzleInstanceFunc(oriSel: #selector(MyTestObject2.myfunc), swizzleSel: #selector(MyTestObject2.szl_myfunc2))
        let obj2 = MyTestObject2()
        obj2.myfunc()
        XCTAssertEqual(obj2.lastName, "szl_myfunc2")
    }
    
    func test_swizzleClassFunc() throws {
        MyTestObject.azl_swizzleClassFunc(oriSel: #selector(MyTestObject.myClsFun), swizzleSel: #selector(MyTestObject.szl_myClsFun))
        
        MyTestObject.myClsFun()
        XCTAssertEqual(MyTestObject.lastName, "szl_myClsFun")
        MyTestObject.szl_myClsFun()
        XCTAssertEqual(MyTestObject.lastName, "myClsFun")
        
        // 交换没实现的类方法
        MyTestObject2.azl_swizzleClassFunc(oriSel: #selector(MyTestObject2.myClsFun), swizzleSel: #selector(MyTestObject2.szl_myClsFun2))
        MyTestObject2.myClsFun()
        XCTAssertEqual(MyTestObject2.lastName, "szl_myClsFun2")
    }

}
