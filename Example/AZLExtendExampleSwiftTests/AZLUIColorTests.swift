//
//  AZLUIColorTests.swift
//  AZLExtendExampleSwiftTests
//
//  Created by lizihong on 2022/6/10.
//  Copyright © 2022 azusalee. All rights reserved.
//

import XCTest
import AZLExtendSwift

class AZLUIColorTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_createColor() throws {
        let color = UIColor.azl_createColor(rgbValue: 0x222222, 1.0)
        
        XCTAssertEqual(color.azl_argbValue(), 0xff222222)
        
        let color2 = UIColor.azl_createColor(argbValue: 0x22222222)
        
        XCTAssertEqual(color2.azl_argbValue(), 0x22222222)
        
        let color3 = UIColor.azl_createColor(colorStr: "#ffffff")
        
        XCTAssertEqual(color3.azl_argbValue(), 0xffffffff)
        
        let color4 = UIColor.azl_createColor(colorStr: "#ffff")
        
        XCTAssertEqual(color4.azl_argbValue(), 0xff000000)
    }

}
