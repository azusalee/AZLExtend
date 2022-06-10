//
//  AZLDoubleTests.swift
//  AZLExtendExampleSwiftTests
//
//  Created by lizihong on 2022/6/10.
//  Copyright © 2022 azusalee. All rights reserved.
//

import XCTest
import AZLExtendSwift

class AZLDoubleTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_timeData() throws {
        let timeData = 3666.123.azl_timeData()
        
        XCTAssertEqual(timeData.hour, 1)
        XCTAssertEqual(timeData.minute, 1)
        XCTAssertEqual(timeData.second, 6)
    }

}
