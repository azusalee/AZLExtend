//
//  MyTestObject.swift
//  AZLExtendExampleSwiftTests
//
//  Created by lizihong on 2022/6/10.
//  Copyright © 2022 azusalee. All rights reserved.
//

import Foundation
import AZLExtendSwift

@objcMembers
class MyTestObject: NSObject {
    
    var lastName = ""
    
    static var lastName = ""
    
    dynamic class func myClsFun() {
        self.lastName = "myClsFun"
    }
    
    dynamic func myfunc() {
        self.lastName = "myfunc"
    }
    
}

// 交换的方法
extension MyTestObject {
    
    @objc
    class func szl_myClsFun() {
        self.lastName = "szl_myClsFun"
    }
    
    @objc
    func szl_myfunc() {
        self.lastName = "szl_myfunc"
    }
    
}

@objcMembers
class MyTestObject2: MyTestObject {
    
    @objc
    class func szl_myClsFun2() {
        self.lastName = "szl_myClsFun2"
    }
    
    @objc
    func szl_myfunc2() {
        self.lastName = "szl_myfunc2"
    }
}
