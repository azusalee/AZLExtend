//
//  AZLDataTests.swift
//  AZLExtendExampleSwiftTests
//
//  Created by lizihong on 2022/6/10.
//  Copyright © 2022 azusalee. All rights reserved.
//

import XCTest
import AZLExtendSwift

class AZLDataTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_hexString() throws {
        let data = "abc".data(using: .utf8)
        XCTAssertEqual(data?.azl_hexString(), "616263")
    }


}
