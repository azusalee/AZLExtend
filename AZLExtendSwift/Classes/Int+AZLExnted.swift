//
//  Int+AZLExnted.swift
//  AZLExtendSwift
//
//  Created by lizihong on 2021/10/14.
//

import Foundation

extension Int {
    /**
    拆分为时分秒
    @return hour 时 minute 分 second秒
    */ 
    public func azl_timeData() -> (hour: Int, minute: Int, second: Int) {
        let intValue = self
        let hour = intValue/3600
        let minute = (intValue/60)%60
        let second = intValue%60
        return (hour: hour, minute: minute, second: second)
    }
}
